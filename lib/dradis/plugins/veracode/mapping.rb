module Dradis::Plugins::Veracode
  module Mapping
    DEFAULT_MAPPING = {
      evidence: {
        'Description' => '{{ veracode[evidence.description] }}',
        'LineNumber' => '{{ veracode[evidence.line] }}',
        'SourceFile' => '{{ veracode[evidence.sourcefile] }}'
      },
      issue: {
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
    }.freeze
  end
end
