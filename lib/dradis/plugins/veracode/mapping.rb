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
        'File' => "{{ vercaode[sca_evidence.file_name] }}\n{{ vercaode[sca_evidence.file_path_value] }}",
        'Library' => "{{ vercaode[sca_evidence.library] }}\n{{ vercaode[sca_evidence.library_id] }}",
        'Mitigation' => "{{ vercaode[sca_evidence.mitigation] }}"
      },
      sca_issue: {
        'Title' => '{{ vercaode[sca_issue.cve_id] }}',
        'Description' => '{{ vercaode[sca_issue.cve_summary] }}',
        'Severity' => '{{ vercaode[sca_issue.severity_desc] }}',
        'Notes' => "CWE: {{ veracode[sca_issue.cwe_id] }}\nCVSS: {{ veracode[sca_issue.cvss_score] }}\nAffects policy compliance: {{ vercaode[sca_issue.vulnerability_affects_policy_compliance] }}",
        'Mitigation' => "{{ vercaode[sca_issue.mitigation] }}"
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
        'sca_issue.severity_desc',
        'sca_issue.cwe_id',
        'sca_issue.cve_summary',
        'sca_issue.cvss_score',
        'sca_issue.mitigation',
        'sca_issue.severity',
        'sca_issue.vulnerability_affects_policy_compliance'
      ],
    }.freeze
  end
end
