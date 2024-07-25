require 'spec_helper'
require 'ostruct'

describe Dradis::Plugins::Veracode::Importer do
  before(:each) do
    # Stub template service
    templates_dir = File.expand_path('../../../../../templates', __FILE__)

    mapping_service = double('Dradis::Plugins::MappingService')
    allow(mapping_service).to receive(:apply_mapping).and_return('')
    allow(Dradis::Plugins::MappingService).to receive(:new).and_return(mapping_service)

    # Init services
    plugin = Dradis::Plugins::Veracode

    @content_service = Dradis::Plugins::ContentService::Base.new(
      logger: Logger.new(STDOUT),
      plugin: plugin
    )

    @importer = plugin::Importer.new(
      content_service: @content_service
    )

    # Stub dradis-plugins methods
    #
    # They return their argument hashes as objects mimicking
    # Nodes, Issues, etc
    allow(@content_service).to receive(:create_node) do |args|
      obj = OpenStruct.new(args)
      obj.define_singleton_method(:set_property) { |*| }
      obj.define_singleton_method(:set_service) { |*| }
      obj
    end
  end

  it 'creates nodes, issues, and, evidence' do
    expect(@content_service).to receive(:create_node).with(hash_including label: 'Cybersecurity-Pilot').once

    %w{ 117 382 CVE-2022-41404 CVE-2022-36033 SRCCLR-SID-22742 CVE-2022-42889 }.each do |cweid|
      expect(@content_service).to receive(:create_issue).with(hash_including id: cweid).at_least(:once)
    end

    expect(@content_service).to receive(:create_evidence).with(hash_including(content: '')).at_least(7).times

    # Run the import
    @importer.import(file: 'spec/fixtures/files/veracode.xml')
  end
end
