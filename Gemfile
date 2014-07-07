source "https://rubygems.org"

gemspec

group :development do
  # We depend on Vagrant for development, but we don't add it as a
  # gem dependency because we expect to be installed within the
  # Vagrant environment itself using `vagrant plugin`.
  gem "vagrant", "1.6.3",
    git: "https://github.com/mitchellh/vagrant.git",
    ref: "v1.6.3"
  gem "berkshelf", "3.1.3"
end

group :plugins do
  gem "vagrant-toplevel-cookbooks", path: "."
  gem "vagrant-omnibus", "1.4.1"
  gem "vagrant-cachier", "0.7.2"
end
