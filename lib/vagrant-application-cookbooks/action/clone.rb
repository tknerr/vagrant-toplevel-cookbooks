module VagrantPlugins
  module ApplicationCookbooks
    module Action
      
      # This middleware checks if reqiured plugins are present
      class Clone

        attr_reader :cloned_repo_path, :cookbook_install_path, :git_url, :git_ref

        def initialize(app, env)
          @app = app
          @env = env

          # machine-specific paths to clone git repo and install cookbooks
          @cloned_repo_path = env[:root_path].join('.vagrant', 'app-cookbooks', env[:machine].name.to_s, 'repo')
          @cookbook_install_path = env[:root_path].join('.vagrant', 'app-cookbooks', env[:machine].name.to_s, 'cookbooks')
          
          # shortcut for values from config
          @git_url = env[:machine].config.app_cookbook.url
          @git_ref = env[:machine].config.app_cookbook.ref
        end

        def provisioners(name)
          @env[:machine].config.vm.provisioners.select{ |prov| prov.name == name }
        end

        def log(msg)
          @env[:ui].info msg
        end

        def is_cloned?
          File.exist?(cloned_repo_path) && get_origin.eql?(git_url)
        end

        def get_origin
          `cd #{cloned_repo_path} && git config --get remote.origin.url`.strip
        end

        def cookbooks_path_configured?(provisioner)
          # see https://github.com/mitchellh/vagrant/blob/master/plugins/provisioners/chef/config/chef_solo.rb#L41-45
          provisioner.config.cookbooks_path != [[:host, "cookbooks"], [:vm, "cookbooks"]]
        end

        def has_chef_solo_provisioner?
          provisioners(:chef_solo).size > 0
        end

        def app_cookbook_configured?
          git_url != nil
        end

        def clean_and_clone_repo
          FileUtils.rm_rf cloned_repo_path
          FileUtils.mkdir_p cloned_repo_path
          unless system("git clone -q #{git_url} #{cloned_repo_path}")
            raise "something went wrong while cloning '#{git_url}'"
          end
        end

        def checkout_and_update
          Dir.chdir(cloned_repo_path) do
            # retrieve all refs
            system("git fetch -q --all")
            # checkout ref
            unless system("git checkout -q #{git_ref}")
              raise "something went wrong while checking out '#{git_ref}'"
            end
            # update ref only if we are on a branch, i.e. not on a detached HEAD
            unless `git symbolic-ref -q HEAD`.empty?
              system("git pull -q")
            end
          end
        end

        def install_cookbooks
          Dir.chdir(cloned_repo_path) do
            unless system("berks install --path #{cookbook_install_path}")
              raise "something went wrong while installing cookbook dependencies"
            end
          end
        end

        def configure_chef_solo
          provisioners(:chef_solo).each do |provisioner|
            if cookbooks_path_configured? provisioner
              @env[:ui].warn "WARNING: already configured `cookbooks_path` will be overridden!"
            end
            provisioner.config.cookbooks_path = provisioner.config.send(:prepare_folders_config, cookbook_install_path)
          end
        end


        def call(env)

          if app_cookbook_configured? && has_chef_solo_provisioner?

            if not is_cloned?
              log "Cloning application cookbook from '#{git_url}'"
              clean_and_clone_repo
            else
              log "Using application cookbook '#{git_url}'"
            end

            log "Ensuring application cookbook is checked out at '#{git_ref}'"
            checkout_and_update

            log "Installing application cookbook dependencies to '#{cookbook_install_path}'"
            install_cookbooks

            log "Configuring Chef Solo provisioner for application cookbook"
            configure_chef_solo
          end

          # continue if ok
          @app.call(env)
        end
      end
    end
  end
end
