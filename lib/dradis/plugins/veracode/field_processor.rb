module Dradis
  module Plugins
    module Veracode
      class FieldProcessor < Dradis::Plugins::Upload::FieldProcessor
        def post_initialize(args={})

          # Dealing with XML from Plugin Manager
          if (data.name == 'cwe')
            @flaw = ::Veracode::Flaw.new(data.at_xpath('./staticflaws/flaw'))
          else
            @flaw = ::Veracode::Flaw.new(data)
          end
        end

        def value(args={})
          field = args[:field]

          # fields in the template are of the form <template>.<name>, where
          # <template> is common across all fields for a given template (and
          # meaningless).
          _, name = field.split('.')

          @flaw.try(name) || 'n/a'
        end
      end
    end
  end
end
