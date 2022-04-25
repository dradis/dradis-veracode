module Dradis::Plugins::Veracode
  class Engine < ::Rails::Engine
    isolate_namespace Dradis::Plugins::Veracode

    include ::Dradis::Plugins::Base
    description 'Processes Veracode XML output'
    provides :upload
  end
end
