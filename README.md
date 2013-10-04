# Vagrant Application Cookbooks Plugin

This [Vagrant](http://www.vagrantup.com) 1.2+ plugin lets you specify application cookbooks to deploy your VMs with. It will take care of cloning the application cookbook from the Git repository, resolve its dependencies via Berkshelf, and configure the Chef Solo provisioner accordingly.

## Features

* allows you to deploy [application cookbooks](http://red-badger.com/blog/2013/06/24/berkshelf-application-cookbooks/) from a git repository (remote or local)
* lets you choose a specific `ref` (i.e. commit, tag or branch) to deploy
* resolves each VMs application cookbook dependencies in isolation to `.vagrant/machines/<vm-name>/cookbooks/` (i.e. no inter-VM dependency conflicts)
* uses the `Berksfile` that is shipped with the application cookbook to resolve dependencies
* configures the `cookbooks_path` of the `:chef_solo` provisioner accordingly

## Usage

Install using standard Vagrant 1.1+ plugin installation methods or via bindler. 

To deploy the `sample-app` application cookbook from the `master` branch:
```ruby
Vagrant.configure("2") do |config|
  config.vm.define :sample do |sample_config|
    sample_config.app_cookbook.url = "https://github.com/tknerr/sample-application-cookbook"
    sample_config.vm.provision :chef_solo do |chef|
      chef.add_recipe "sample-app"
    end
  end
end
```

Or to deploy from a specific git `ref`, `branch` or `tag`:
```ruby
...
    sample_config.app_cookbook.url = "https://github.com/tknerr/sample-application-cookbook"
    sample_config.app_cookbook.ref = "some_ref"
...
```

You can also use local file URLs:
```ruby
...
    sample_config.app_cookbook.url = "file:///path/to/application-cookbook"
...
```


## Development

To work on the `vagrant-application-cookbooks` plugin, clone this repository out, and use
[Bundler](http://gembundler.com) to get the dependencies:

```
$ bundle
```

Once you have the dependencies, verify the unit tests pass with `rake`:

```
$ bundle exec rake
```

If those pass, you're ready to start developing the plugin. You can test
the plugin without installing it into your Vagrant environment by using the
`Vagrantfile` in the top level of this directory and use bundler to execute Vagrant.

To test that the `my_app` vm is deployed with the `sample-app` application cookbook simply run:
```
$ bundle exec vagrant up my_app
```

