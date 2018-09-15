# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.define "debian8" do |machine|
    machine.vm.box = "debian/jessie64"
    machine.vm.hostname = 'debian8'
  end

  config.vm.define "debian9" do |machine|
    machine.vm.box = "debian/stretch64"
    machine.vm.hostname = 'debian9'
  end

  config.vm.define "ubuntu1404" do |machine|
    machine.vm.box = "ubuntu/trusty64"
    machine.vm.hostname = 'ubuntu14'
  end

  config.vm.define "ubuntu1604" do |machine|
    machine.vm.box = "ubuntu/xenial64"
    machine.vm.hostname = 'ubuntu16'
  end

  config.vm.define "centos7" do |machine|
    machine.vm.box = "centos/7"
    machine.vm.hostname = 'centos7'
  end

  config.vm.synced_folder "/Users/mcrauwel/Workspace/Puppet/puppet-proxysql", "/etc/puppetlabs/code/environments/production/modules/proxysql", type: "rsync"
  config.vm.synced_folder ".", "/vagrant", disabled: true
  config.ssh.forward_agent = true

  config.vm.provision "shell",
    inline: "test -e /usr/bin/python || (apt -y -q update && apt install -y -q python-minimal)"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "playbook.yml"
  end

  config.vm.provision "puppet" do |puppet|
    puppet.synced_folder_type = "rsync"
    puppet.options = "--verbose --debug"
  end

end
