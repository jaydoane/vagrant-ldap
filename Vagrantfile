# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vbguest.auto_update = false
  config.vm.box = 'centos/6'
  config.vm.hostname = 'openldap.v'
  config.vm.network :private_network, ip: '192.168.56.31'

  config.vm.provider "virtualbox" do |v|
    v.name = 'openldap'
    v.customize ['modifyvm', :id, '--memory', 1024]
  end

  config.vm.provision 'ansible' do |a|
    a.playbook = 'openldap.yaml'
  end

  config.vm.provision 'ansible' do |a|
    a.playbook = 'dev.yaml'
  end
end
