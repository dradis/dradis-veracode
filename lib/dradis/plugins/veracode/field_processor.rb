module Dradis
  module Plugins
    module Veracode
      class FieldProcessor < Dradis::Plugins::Upload::FieldProcessor
        def post_initialize(args = {})
          flaw_xml = data.name == 'cwe' ? data.at_xpath('./staticflaws/flaw') : data

          # Dealing with XML from Plugin Manager
          @record =
            if (flaw_xml['dradis_type'] == 'evidence')
              ::Veracode::Evidence.new(flaw_xml)
            else
              ::Veracode::Flaw.new(flaw_xml)
            end
        end

        def value(args = {})
          field = args[:field]

          # fields in the template are of the form <template>.<name>, where
          # <template> is common across all fields for a given template (and
          # meaningless).
          _, name = field.split('.')

          @record.try(name) || 'n/a'
        end
      end
    end
  end
end
