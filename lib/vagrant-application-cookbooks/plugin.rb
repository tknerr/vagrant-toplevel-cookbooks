begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant ApplicationCookbooks plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < "1.2.0"
  raise "The Vagrant ApplicationCookbooks plugin is only compatible with Vagrant 1.2+"
end

module VagrantPlugins
  module ApplicationCookbooks
    class Plugin < Vagrant.plugin("2")
      name "ApplicationCookbooks"
      description "This plugin allows you to deploy Application Cookbooks"

      config "app_cookbook" do
        require_relative "config"
        Config
      end

      action_hook 'clone-application-cookbook-on-machine-up', :machine_action_up do |hook|
        hook.before Vagrant::Action::Builtin::ConfigValidate, VagrantPlugins::ApplicationCookbooks::Action::Clone
      end
=begin
      check_action_hook = lambda do |hook|
        require_relative 'action/check'
        hook.before Vagrant::Action::Builtin::ConfigValidate, VagrantPlugins::PluginBundler::Action::Check
      end
      action_hook 'check-plugin-dependencies-on-machine-up', :machine_action_up, &check_action_hook
      action_hook 'check-plugin-dependencies-on-machine-reload', :machine_action_reload, &check_action_hook
=end
    end
  end
end
