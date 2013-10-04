
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

        def clean_and_clone_repo
          log "cleaning #{cloned_repo_path}"
          FileUtils.rm_rf cloned_repo_path
          FileUtils.mkdir_p cloned_repo_path

          log "cloning application cookbook from #{git_url} into #{cloned_repo_path}"
          system "git clone #{git_url} #{cloned_repo_path}"
        end

        def update_and_checkout
          log "checking out ref #{git_ref} in #{cloned_repo_path}"
          system "cd #{cloned_repo_path} && git pull && git checkout #{git_ref}"
        end

        def is_cloned
          File.exist?(cloned_repo_path) && get_origin.eql?(git_url)
        end

        def get_origin
          log "getting origin for #{cloned_repo_path}"
          `cd #{cloned_repo_path} && git config --get remote.origin.url`.strip
        end

        def install_cookbooks
          log "installing cookbook dependencies to #{cookbook_install_path}"
          system "cd #{cloned_repo_path} && berks install --path #{cookbook_install_path}"
        end

        def configure_chef_solo
          log "configuring chef_solo provisioners with cookbook_install_path = #{cookbook_install_path}"
          provisioners(:chef_solo).each do |provisioner|
            provisioner.config.cookbooks_path = provisioner.config.send(:prepare_folders_config, cookbook_install_path)
          end
        end

        def has_chef_solo_provisioner?
          provisioners(:chef_solo).size > 0
        end

        def app_cookbook_configured?
          git_url != nil
        end

        def call(env)

          if app_cookbook_configured? && has_chef_solo_provisioner?
            # ensure correct repo is cloned and ref checked out
            clean_and_clone_repo unless is_cloned
            update_and_checkout

            # install app cookbook dependencies
            install_cookbooks
            
            # configure cookbooks_path
            configure_chef_solo
          end

          # continue if ok
          @app.call(env)
        end
      end
    end
  end
end
