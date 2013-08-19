# -*- mode: ruby -*-
# vi: set ft=ruby :

# require plugin for testing via bundler
Vagrant.require_plugin "vagrant-application-cookbooks"
#Vagrant.require_plugin "vagrant-omnibus"

Vagrant.configure("2") do |config|

  #config.omnibus.chef_version = "11.4.4"

  #
  # configure vm to be deployed with application cookbook
  #
  config.vm.define :my_app do |my_app_config|

    my_app_config.vm.box = "opscode_ubuntu-12.04"
    my_app_config.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.4.4.box"
    
    # app cookbook to deploy
    my_app_config.app_cookbook.url = "https://github.com/tknerr/sample-application-cookbook"

    my_app_config.vm.provision :chef_solo do |chef|
      chef.json = {
        :sample_app => {
          :words_of_wisdom => "Chuck Norris' beard can type 140 wpm!"
        }
      }
    end
  end
end
