module Dradis::Plugins::Veracode
  class Importer < Dradis::Plugins::Upload::Importer
    def self.templates
      { evidence: 'evidence', issue: 'issue' }
    end

    # The framework will call this function if the user selects this plugin from
    # the dropdown list and uploads a file.
    # @returns true if the operation was successful, false otherwise
    def import(params = {})
      file_content = File.read(params[:file])

      # Parse the uploaded file into a Ruby Hash
      logger.info { "Parsing Veracode output from #{ params[:file] }..." }
      xml = Nokogiri::XML(file_content)
      logger.info { 'Done.' }

      # Do a sanity check to confirm the user uploaded the right file
      # format.
      if xml.root.name != 'detailedreport'
        error = 'Document doesn\'t seem to be in the Veracode Detailed Report XML format.'
        logger.fatal { error }
        content_service.create_note text: error
        return false
      end

      # create app_name, and parse attributes
      node = parse_report_details(xml.root)

      # parse each severity > category > cwe > flaws
      xml.root.xpath('./xmlns:severity').each do |xml_severity|
        logger.info { "\t => Severity (level: #{ xml_severity[:level] })" }
        xml_severity.xpath('.//xmlns:flaw').each do |xml_flaw|
          parse_flaw(xml_flaw, node)
        end
      end
    end

    private
    attr_accessor :app_node

    def parse_report_details(xml_detailedreport)
      app_name = xml_detailedreport[:app_name]
      app_node = content_service.create_node(label: app_name)
      logger.info { "Adding report details (app_name: #{ app_name })" }

      [
        :app_id, :business_criticality, :business_owner, :business_unit,
        :policy_name, :teams
      ].each do |attribute|
        app_node.set_property(attribute, xml_detailedreport[attribute])
      end

      app_node.save
      app_node
    end

    def parse_flaw(xml_flaw, node)
      cwe_id = xml_flaw[:cweid]
      logger.info { "\t\t => Creating issue and evidence (flaw cweid: #{ cwe_id })" }

      flaw = ::Veracode::Flaw.new(xml_flaw)
      issue_text = template_service.process_template(template: 'issue', data: flaw)
      issue = content_service.create_issue(text: issue_text, id: cwe_id)

      veracode_evidence = ::Veracode::Evidence.new(xml_flaw)
      evidence_text = template_service.process_template(template: 'evidence', data: veracode_evidence)
      evidence = content_service.create_evidence(content: evidence_text, issue: issue, node: node)
    end
  end
end
