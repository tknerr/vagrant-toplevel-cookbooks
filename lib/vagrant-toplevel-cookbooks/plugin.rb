begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant TopLevelCookbooks plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < "1.2.0"
  raise "The Vagrant TopLevelCookbooks plugin is only compatible with Vagrant 1.2+"
end

module VagrantPlugins
  module TopLevelCookbooks
    class Plugin < Vagrant.plugin("2")
      name "TopLevelCookbooks"
      description "This plugin allows you to deploy Top-Level Cookbooks"

      config "toplevel_cookbook" do
        require_relative "config"
        Config
      end

      require_relative "action"
      clone_action_hook = lambda do |hook|
        hook.before Vagrant::Action::Builtin::ConfigValidate, VagrantPlugins::TopLevelCookbooks::Action::Clone
      end
      action_hook 'clone-toplevel-cookbook-on-machine-up', :machine_action_up, &clone_action_hook
      action_hook 'clone-toplevel-cookbook-on-machine-reload', :machine_action_reload, &clone_action_hook
      action_hook 'clone-toplevel-cookbook-on-machine-provision', :machine_action_provision, &clone_action_hook
    end
  end
end
