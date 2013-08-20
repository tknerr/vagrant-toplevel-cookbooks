
TODO
====

[ ] configure app cookbook in chef_solo config rather than vm config
[ ] only configure cookbook paths for VMs which define an app cookbook
[ ] support for cloning a specific ref / branch / tag
[ ] configure the default recipe automatically
[ ] use Berkshelf Ruyb API rather than shelling out 
[ ] add spec tests
[ ] use i18n
[ ] more finegrained actions:
  - clean (remove all)
  - sync ((clone or pull) + checkout ref)
  - configure (cookbooks path + default recipe)