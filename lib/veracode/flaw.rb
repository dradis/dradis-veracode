module Veracode
  # This class represents each of the
  # detailedreport/severity/category/cwe/staticflaws/flaw elements in the
  # Veracode XML document.
  #
  # It provides a convenient way to access the information scattered all over
  # the XML in attributes and nested tags.
  #
  # Instead of providing separate methods for each supported property we rely
  # on Ruby's #method_missing to do most of the work.
  class Flaw
    # Accepts an XML node from Nokogiri::XML.
    def initialize(xml_flaw)
      @xml = xml_flaw
    end

    # List of supported tags. They can be attributes, simple descendans or
    # collections (e.g. <references/>, <tags/>)
    def supported_tags
      [
        # attributes
        :categoryid, :categoryname, :cweid, :cwename, :description, :exploitlevel,
        :issueid, :line, :mitigation_status, :mitigation_status_desc, :module, 
        :note, :remediation_status, :remediationeffort, :severity, :sourcefile, 
        :sourcefilepath
      ]
    end

    # This allows external callers (and specs) to check for implemented
    # properties
    def respond_to?(method, include_private=false)
      return true if supported_tags.include?(method.to_sym)
      super
    end

    # This method is invoked by Ruby when a method that is not defined in this
    # instance is called.
    #
    # In our case we inspect the @method@ parameter and try to find the
    # attribute, simple descendent or collection that it maps to in the XML
    # tree.
    def method_missing(method, *args)
      # We could remove this check and return nil for any non-recognized tag.
      # The problem would be that it would make tricky to debug problems with
      # typos. For instance: <>.potr would return nil instead of raising an
      # exception
      unless supported_tags.include?(method)
        super
        return
      end

      # First we try the attributes
      method_name = method.to_s
      return @xml.attributes[method_name].value if @xml.attributes.key?(method_name)

      return @xml.parent.parent[:cwename] if method == :cwename
    end
  end
end
