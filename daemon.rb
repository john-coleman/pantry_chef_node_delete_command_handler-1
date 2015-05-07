#!/usr/bin/env ruby
require 'rubygems'
require 'wonga/daemon'
require_relative 'pantry_chef_delete_node_command_handler/pantry_chef_delete_node_command_handler'
require 'chef'
require 'chef/knife'

config_name = File.join(File.dirname(File.symlink?(__FILE__) ? File.readlink(__FILE__) : __FILE__), 'config', 'daemon.yml')
Wonga::Daemon.load_config(File.expand_path(config_name))
Chef::Knife.new.configure_chef
Wonga::Daemon.run(Wonga::Daemon::PantryChefDeleteNodeCommandHandler.new(Wonga::Daemon.publisher, Wonga::Daemon.logger))
