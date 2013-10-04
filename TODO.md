
# TODO

[x] improve log/info output
[-] configure app cookbook in chef_solo config rather than vm config
[x] warn if cookbook_path is manually configured and will be overridden
[x] skip everything (e.g. cloning, resolving deps) for vms which don't define an app cookbook
[x] skip everything for vms which don't have a chef provisioner
[x] support for cloning a specific ref / branch / tag
[-] configure the default recipe automatically
[ ] use Berkshelf Ruyb API rather than shelling out 
[x] add spec tests for the config
[ ] add spec tests for the clone action
[ ] check if url is a valid url
[ ] use i18n
[ ] suppress stdout / stderr when shelling out git commands
[ ] add support for more provisioners / dependency managers