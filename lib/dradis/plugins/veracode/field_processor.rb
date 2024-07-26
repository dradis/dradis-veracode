module Dradis
  module Plugins
    module Veracode
      class FieldProcessor < Dradis::Plugins::Upload::FieldProcessor
        def post_initialize(args = {})
          @record =
            case data
            when ::Veracode::Flaw, ::Veracode::Evidence, ::Veracode::Vulnerability
              data
            # Note: The evidence and flaw samples are the same but they need to
            # be differentiated in the plugins manager preview. In that case,
            # we're adding a "dradis_type" attribute in the evidence.sample file
            when (data['dradis_type'] == 'evidence')
              ::Veracode::Evidence.new(data.at_xpath('./staticflaws/flaw'))
            when (data.name == 'component')
              ::Veracode::Vulnerability.new(data.at_xpath('.//vulnerability'))
            else
              ::Veracode::Flaw.new(data.at_xpath('./staticflaws/flaw'))
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
