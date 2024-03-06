require 'spec_helper'
require 'ostruct'

describe Dradis::Plugins::Veracode::Importer do

  before(:each) do
    # Stub template service
    templates_dir = File.expand_path('../../../../../templates', __FILE__)
    expect_any_instance_of(Dradis::Plugins::TemplateService)
    .to receive(:default_templates_dir).and_return(templates_dir)

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

    %w{ 117 382 }.each do |cweid|
      expect(@content_service).to receive(:create_issue).with(hash_including id: cweid).at_least(:once)
    end

    %w{ 107 129 333 }.each do |line|
      expect(@content_service).to receive(:create_evidence).with(hash_including(content: a_string_matching(/#{line}/))).once
    end

    # Run the import
    @importer.import(file: 'spec/fixtures/files/veracode.xml')
  end
end
