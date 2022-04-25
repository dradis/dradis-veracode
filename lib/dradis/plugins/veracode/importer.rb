module Dradis::Plugins::Veracode
  class Importer < Dradis::Plugins::Upload::Importer
    # The framework will call this function if the user selects this plugin from
    # the dropdown list and uploads a file.
    # @returns true if the operation was successful, false otherwise
    def import(params={})

      file_content = File.read( params[:file] )

      # Parse the uploaded file into a Ruby Hash
      logger.info { "Parsing Veracode output from #{ params[:file] }..." }
      xml = Nokogiri::XML( file_content )
      logger.info { 'Done.' }

      # Do a sanity check to confirm the user uploaded the right file
      # format.
      if xml.root.name != ''
        error = 'Document doesn\'t seem to be in the Veracode XML format.'
        logger.fatal { error }
        content_service.create_note text: error
        return false
      end
    end
  end
end
