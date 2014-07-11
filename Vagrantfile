# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    #config.vm.box = "puppetlabs/centos-6.5-64-nocm"
    config.vm.provider 'docker' do |d|
        d.image = 'centos'
    end

    config.vm.provision :shell, path: "tests/setup.sh"

#    config.vm.provision :puppet do |puppet|
#        puppet.manifests_path = "tests"
#        puppet.manifest_file = "init.pp"
#    end

end
