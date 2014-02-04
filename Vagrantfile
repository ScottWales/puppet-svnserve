# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "centos-6.4"

    config.vm.provider :virtualbox do |vb, override|
        override.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-64-x64-vbox4210.box"
    end

    config.vm.provision :shell, path: "tests/setup.sh"

    config.vm.provision :puppet do |puppet|
        puppet.manifests_path = "tests"
        puppet.manifest_file = "init.pp"
        puppet.module_path = "../"
    end

end
