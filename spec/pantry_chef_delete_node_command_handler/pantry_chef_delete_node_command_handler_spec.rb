require 'spec_helper'
require_relative '../../pantry_chef_delete_node_command_handler/pantry_chef_delete_node_command_handler'
require 'logger'

describe Wonga::Daemon::PantryChefDeleteNodeCommandHandler do
  subject { described_class.new(publisher, logger) }
  let(:publisher) { instance_double('Wonga::Daemon::Publisher').as_null_object }
  let(:logger) { instance_double('Logger').as_null_object }
  let(:message) { 
    { 'node'    => node,
      'domain'  => domain
    } 
  }
  let(:node) { 'test' }
  let(:domain) { 'example.com' }
  let(:node_name) { "#{node}.#{domain}" }

  it_behaves_like 'handler'

  describe "#handle_message" do
    before(:each) do
      node = Chef::Node.new
      node.name(node_name)
      node.save
      api_client = Chef::ApiClient.new
      api_client.name(node_name)
      api_client.save
    end

    include_examples "send message"

    it "deletes node" do
      subject.handle_message message
      expect(Chef::Node.list.keys).to_not include(node_name)
    end

    it "deletes api_client" do
      subject.handle_message message
      expect(Chef::ApiClient.list.keys).to_not include(node_name)
    end
  end
end

