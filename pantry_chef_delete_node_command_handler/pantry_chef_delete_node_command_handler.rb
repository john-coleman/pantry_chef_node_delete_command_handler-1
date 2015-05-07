require 'chef'
require 'chef/knife'

module Wonga
  module Daemon
    class PantryChefDeleteNodeCommandHandler
      def initialize(publisher, logger)
        @publisher = publisher
        @logger = logger
      end

      def handle_message(message)
        chef_node_name = message['hostname'] + '.' + message['domain']
        Chef::Node.load(chef_node_name).destroy if Chef::Node.list.keys.include?(chef_node_name)
        Chef::ApiClient.load(chef_node_name).destroy if Chef::ApiClient.list.keys.include?(chef_node_name)
        @publisher.publish(message)
      end
    end
  end
end
