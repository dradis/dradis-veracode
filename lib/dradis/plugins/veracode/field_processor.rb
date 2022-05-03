module Dradis
  module Plugins
    module Veracode
      class FieldProcessor < Dradis::Plugins::Upload::FieldProcessor
        def post_initialize(args={})
          @flaw = ::Veracode::Flaw.new(data)
        end

        def value(args={})
          field = args[:field]

          # fields in the template are of the form <template>.<name>, where
          # <template> is common across all fields for a given template (and
          # meaningless).
          _, name = field.split('.')

          # Potentially this could go up to Flaw, if we end up with more than
          # one Veracode object to deal with.
          if name == 'cwename'
            data.parent.parent[:cwename]
          else
            @flaw.try(name) || 'n/a'
          end
        end
      end
    end
  end
end
