module Dradis::Plugins::Veracode::Formats
  module Flaw

    private

    def parse_flaw(xml_flaw)
      cwe_id = xml_flaw[:cweid]
      logger.info { "\t\t => Creating issue and evidence (flaw cweid: #{ cwe_id })" }

      flaw = ::Veracode::Flaw.new(xml_flaw)
      issue_text = mapping_service.apply_mapping(source: 'issue', data: flaw)
      issue = content_service.create_issue(text: issue_text, id: cwe_id)

      veracode_evidence = ::Veracode::Evidence.new(xml_flaw)
      evidence_text = mapping_service.apply_mapping(source: 'evidence', data: veracode_evidence)
      content_service.create_evidence(content: evidence_text, issue: issue, node: node)
    end
  end
end
