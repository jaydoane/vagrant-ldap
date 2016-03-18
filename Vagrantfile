# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = 'bento/centos-6.7'
  config.vm.hostname = 'ldap.v'
  config.vm.network :private_network, ip: '192.168.56.31'

  config.vm.provider "virtualbox" do |v|
    v.name = 'ldap'
    v.customize ['modifyvm', :id, '--memory', 1024]
  end

  config.vm.provision 'ansible' do |a|
    a.playbook = 'install-ldap.yaml'
  end

  config.vm.provision 'ansible' do |a|
    a.playbook = 'dev-env.yaml'
  end
end
