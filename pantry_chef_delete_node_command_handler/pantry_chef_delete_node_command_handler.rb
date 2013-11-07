module Wonga
  module Daemon
    class PantryChefDeleteNodeCommandHandler
      def initialize(publisher, logger)
        @publisher = publisher
        @logger = logger
      end

      def handle_message(message)
        Chef::Node.load(message['node']).destroy if Chef::Node.list.keys.include?(message['node'])
        Chef::ApiClient.load(message['node']).destroy if Chef::ApiClient.list.keys.include?(message['node'])
        @publisher.publish(message)
      end
    end
  end
end
