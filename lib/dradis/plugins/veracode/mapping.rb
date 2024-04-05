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

    SOURCE_FIELDS = {
      evidence: [
        'evidence.description',
        'evidence.exploitlevel',
        'evidence.issueid',
        'evidence.line',
        'evidence.mitigation_status',
        'evidence.mitigation_status_desc',
        'evidence.module',
        'evidence.remediation_status',
        'evidence.remediationeffort',
        'evidence.sourcefile',
        'evidence.sourcefilepath'
      ],
      issue: [
        'issue.categoryid',
        'issue.categoryname',
        'issue.cweid',
        'issue.cwename',
        'issue.description',
        'issue.exploitlevel',
        'issue.mitigation_status',
        'issue.mitigation_status_desc',
        'issue.note',
        'issue.remediation_status',
        'issue.remediationeffort',
        'issue.severity'
      ]
    }.freeze
  end
end
