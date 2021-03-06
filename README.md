# Vagrant Top-Level Cookbooks Plugin

[![Build Status](https://travis-ci.org/tknerr/vagrant-toplevel-cookbooks.png?branch=master)](https://travis-ci.org/tknerr/vagrant-toplevel-cookbooks)


This [Vagrant](http://www.vagrantup.com) 1.2+ plugin lets you specify the [top-level cookbooks](http://lists.opscode.com/sympa/arc/chef/2014-01/msg00419.html) to deploy your VMs with. It will take care of cloning the top-level cookbook from the Git repository, resolve its dependencies via Berkshelf, and configure the Chef Solo provisioner accordingly.

Note: this plugin was previously (until v0.1.4) named `vagrant-application-cookbooks`, but since the term "application cookbook" is so much overloaded in the Chef community [I now call them "top-level cookbooks"](https://github.com/berkshelf/berkshelf/issues/535#issuecomment-40890497).

## Features

* allows you to deploy [top-level cookbooks](http://red-badger.com/blog/2013/06/24/berkshelf-application-cookbooks/) from a git repository (remote or local)
* lets you choose a specific `ref` (i.e. commit, tag or branch) to deploy
* resolves each VMs toplevel cookbook dependencies in isolation to `.vagrant/app-cookbooks/<vm-name>/cookbooks/` (i.e. no inter-VM dependency conflicts)
* uses the `Berksfile` that is shipped with the toplevel cookbook to resolve dependencies
* configures the `cookbooks_path` of the `:chef_solo` provisioner accordingly

## Usage

Install using standard Vagrant plugin installation method:
```
$ vagrant plugin install vagrant-toplevel-cookbooks
```

To deploy the `sample-app` toplevel cookbook from the `master` branch:
```ruby
Vagrant.configure("2") do |config|
  config.vm.define :sample do |sample_config|
    sample_config.toplevel_cookbook.url = "https://github.com/tknerr/sample-toplevel-cookbook"
    sample_config.vm.provision :chef_solo do |chef|
      chef.add_recipe "sample-app"
    end
  end
end
```

Or to deploy from a specific git `ref`, `branch` or `tag`:
```ruby
...
    sample_config.toplevel_cookbook.url = "https://github.com/tknerr/sample-toplevel-cookbook"
    sample_config.toplevel_cookbook.ref = "some_ref"
...
```

You can also use local file URLs:
```ruby
...
    sample_config.toplevel_cookbook.url = "file:///path/to/toplevel-cookbook"
...
```


## Development

To work on the `vagrant-toplevel-cookbooks` plugin, clone this repository out, and use
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

To test that the `my_app` vm is deployed with the `sample-app` top-level cookbook simply run:
```
$ bundle exec vagrant up my_app
```
