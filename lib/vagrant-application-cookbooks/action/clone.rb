
module VagrantPlugins
  module ApplicationCookbooks
    module Action
      
      # This middleware checks if reqiured plugins are present
      class Clone

        def initialize(app, env)
          @app    = app
        end

        def provisioners(name, env)
          env[:machine].config.vm.provisioners.select{ |prov| prov.name == name }
        end

        def call(env)

          url = env[:machine].config.app_cookbook.url
          vm_name = env[:machine].name
          target_path = ".vagrant/app_cookbooks/#{vm_name}/app"
          cb_path = ".vagrant/app_cookbooks/#{vm_name}/cookbooks"

          unless File.exist?(cb_path)
            env[:ui].info "cleaning #{target_path}"
            FileUtils.rm_rf target_path
            FileUtils.mkdir_p target_path

            env[:ui].info "cloning application cookbook from #{url} into #{target_path}"
            system "git clone #{url} #{target_path}"

            env[:ui].info "installing cookbook dependencies to #{cb_path}"
            system "cd #{target_path} && berks install --path ../cookbooks"
          end

          env[:ui].info "configuring chef_solo provisioners with cookbooks_path = #{cb_path}"
          provisioners(:chef_solo, env).each do |provisioner|
            provisioner.config.cookbooks_path = provisioner.config.send(:prepare_folders_config, cb_path)
          end

          # continue if ok
          @app.call(env)
        end
      end
    end
  end
end
