module Dradis::Plugins::Veracode::Formats
  module Component

    private

    def parse_component(xml_component)
      xml_component.xpath('.//xmlns:vulnerability').each do |xml_vuln|
        parse_vulnerability(xml_vuln)
      end
    end

    def parse_vulnerability(xml_vuln)
      cve_id = xml_vuln[:cve_id]
      vuln = ::Veracode::Vulnerability.new(xml_vuln)
      issue_text = mapping_service.apply_mapping(source: 'issue', data: vuln)
      issue = content_service.create_issue(text: issue_text, id: cve_id)

      evidence = ::Veracode::Vulnerability.new(xml_vuln)
      evidence_text = mapping_service.apply_mapping(source: 'evidence', data: evidence)
      content_service.create_evidence(content: evidence_text, issue: issue, node: node)
    end
  end
end
