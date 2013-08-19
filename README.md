# Vagrant Application Cookbooks Plugin

This [Vagrant](http://www.vagrantup.com) 1.2+ plugin lets you specify  application cookbooks to deploy your VMs with. It will take care of cloning  the application cookbook from the Git repository, resolve its dependencies via Berkshelf, and configure the Chef provisioner accordingly. 

## Features

* allows you to deploy application cookbooks from a Git repository
* select a specific tag or branch to deploy
* resolves each VMs application cookbook dependencies in isolation (i.e. no inter-VM dependency conflicts)
* uses the Berksfile shipped with the application cookbook to resolve dependencies 

## Usage

Install using standard Vagrant 1.1+ plugin installation methods or via bindler. 

To deploy the `sample-app` application cookbook from `master` branch:
```
Vagrant.configure("2") do |config|
  config.vm.provision :chef_solo do |chef|
    chef.application = "https://github.com/tknerr/sample-application-cookbook"
  end
end
```

Or from a specific `ref`, `branch` or `tag`:
```
Vagrant.configure("2") do |config|
  config.vm.provision :chef_solo do |chef|
    chef.application = git: "https://github.com/tknerr/sample-application-cookbook", ref: "v0.1.0"
  end
end
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

To test that the sample application cookbook is deployed simply run:
```
$ bundle exec vagrant up
```

