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
      },
      sca_evidence: {
        'File' => "{{ veracode[sca_evidence.file_name] }}\n{{ veracode[sca_evidence.file_path_value] }}",
        'Library' => "{{ veracode[sca_evidence.library] }}\n{{ veracode[sca_evidence.library_id] }}",
        'Mitigation' => "{{ veracode[sca_evidence.mitigation] }}"
      },
      sca_issue: {
        'Title' => '{{ veracode[sca_issue.cve_id] }}',
        'Description' => '{{ veracode[sca_issue.cve_summary] }}',
        'Severity' => '{{ veracode[sca_issue.severity_desc] }}',
        'Notes' => "CWE: {{ veracode[sca_issue.cwe_id] }}\nCVSS: {{ veracode[sca_issue.cvss_score] }}\nAffects policy compliance: {{ veracode[sca_issue.vulnerability_affects_policy_compliance] }}",
        'Mitigation' => "{{ veracode[sca_issue.mitigation] }}"
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
        'issue.issueid',
        'issue.line',
        'issue.mitigation_status',
        'issue.mitigation_status_desc',
        'issue.module',
        'issue.note',
        'issue.remediation_status',
        'issue.remediationeffort',
        'issue.severity',
        'issue.sourcefile',
        'issue.sourcefilepath'
      ],
      sca_evidence: [
        'sca_evidence.file_name',
        'sca_evidence.file_path_value',
        'sca_evidence.library',
        'sca_evidence.library_id',
        'sca_evidence.mitigation',
      ],
      sca_issue: [
        'sca_issue.cve_id',
        'sca_issue.cve_summary',
        'sca_issue.cvss_score',
        'sca_issue.cwe_id',
        'sca_issue.mitigation',
        'sca_issue.severity',
        'sca_issue.severity_desc',
        'sca_issue.vulnerability_affects_policy_compliance'
      ]
    }.freeze
  end
end
