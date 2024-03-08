module Dradis::Plugins::Veracode
  module Mapping

    def self.default_mapping
      {
        'evidence' => {
          'Description' => '{{ veracode[evidence.description] }}',
          'LineNumber' => '{{ veracode[evidence.line] }}',
          'SourceFile' => '{{ veracode[evidence.sourcefile] }}'
        },
        'issue' => {
          'Title' => '{{ veracode[issue.cwename] }}',
          'CVSSv3.BaseScore' => 'n/a',
          'CVSSv3.Vector' => 'n/a',
          'Type' => 'Internal',
          'Description' => '{{ veracode[issue.description] }}',
          'Solution' => '{{ veracode[issue.remediation_status] }}',
          'References' => 'https://cwe.mitre.org/data/definitions/{{ veracode[issue.cweid] }}.html',
          'Severity' => '{{ veracode[issue.severity] }}',
          'Category' => '{{ veracode[issue.categoryname] }}',
          'CWE' => '{{ veracode[issue.cweid] }}',
          'RemediationStatus' => '{{ veracode[issue.remediation_status] }}'
        }
      }
    end
  end
end
