
# CHANGELOG

## 0.2.5 (unreleased)

 * make the plugin thread-safe to support `vagrant up --parallel` (see [#9](https://github.com/tknerr/vagrant-toplevel-cookbooks/issues/9))

## 0.2.4 (February 4, 2015)

 * fix a nasty bug which causes some providers to lose the shared folder (see fgrehm/vagrant-lxc#342)

## 0.2.3 (December 15, 2014)

 * fix another incompatibility with Vagrant 1.7 by explicitly setting the provisioning path to "/tmp/vagrant-toplevel-cookbooks"

## 0.2.2 (December 15, 2014)

 * add missing license information to gemspec ([#4](https://github.com/tknerr/vagrant-toplevel-cookbooks/issues/4))
 * add compatibility with vagrant 1.7+

## 0.2.1 (July 7, 2014)

 * bugfix: ensure we are not in a bundle context when running `berks vendor`

## 0.2.0 (July 7, 2014)

 * several **breaking changes**:
   * rename plugin to "vagrant-toplevel-cookbooks"
   * update to berkshelf 3 for [ChefDK](http://www.getchef.com/downloads/chef-dk) (berkshelf 2 is no longer supported)
   * remove berkshelf gem dependency (`berks` must be on the `$PATH`)
 * update development dependencies to latest vagrant 1.6 and adapt Vagrantfile samples

## 0.1.4 (Oct 5, 2013)

 * Use Berkshelf API rather than shelling out

## 0.1.3 (Oct 5, 2013)

 * Fix permanently thrown exception (left-over from debugging)

## 0.1.2 (Oct 5, 2013)

 * Silence output of git commands
 * Fix several issues with checkout and updating of refs

## 0.1.1 (Oct 5, 2013)

 * Fix missing berkshelf dependency

## 0.1.0 (Oct 5, 2013)

 * Initial release
