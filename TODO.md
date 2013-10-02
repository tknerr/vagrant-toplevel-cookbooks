
# TODO

[ ] improve log/info output
[?] configure app cookbook in chef_solo config rather than vm config
[ ] only configure cookbook paths for VMs which define an app cookbook
[ ] skip everything (e.g. cloning, resolving deps) for vms which don't use it
[x] skip everyting for vms which don't have a chef provisioner
[x] support for cloning a specific ref / branch / tag
[ ] configure the default recipe automatically
[ ] use Berkshelf Ruyb API rather than shelling out 
[x] add spec tests for the config
[ ] add spec tests for the clone action
[ ] check if url is a valid url
[ ] use i18n
