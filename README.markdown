# vagrant-puppet-proxysql

Scripts used for testing the [puppet-proxysql](https://github.com/voxpupuli/puppet-proxysql) module.

If you want to use this you will likely need to update the [Vagrantfile](Vagrantfile) so that it points to your development version of the puppet-module.

```
  config.vm.synced_folder "/your/local/path/to/puppet-proxysql", "/etc/puppetlabs/code/environments/production/modules/proxysql", type: "rsync"
```
