source "https://rubygems.org"

gemspec

group :development do
  # We depend on Vagrant for development, but we don't add it as a
  # gem dependency because we expect to be installed within the
  # Vagrant environment itself using `vagrant plugin`.
  gem "vagrant", "1.7.2",
    git: "https://github.com/mitchellh/vagrant.git",
    ref: "v1.7.2"
  gem "berkshelf", "3.2.4"
end

group :plugins do
  gem "vagrant-toplevel-cookbooks", path: "."
  gem "vagrant-omnibus", "1.4.1"
  gem "vagrant-cachier", "1.2.0"
end
