# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "private_network", ip: "172.31.22.10"
  config.vm.provision 'shell', path: 'vagrant_provisioner'

  (1..2).each do |i|
    (1..3).each do |j|
      config.vm.network "private_network", ip: "172.31.22.#{i}0#{j}"
    end
  end

  config.vm.provision 'docker' do |d|
    d.build_image '/vagrant', args: '-t ansibleclass/class_instance'
    (1..3).each do |i|
      d.run "webapp0#{i}", image: 'ansibleclass/class_instance', args: "-p 172.31.22.#{100 + i}:22:22 -p 172.31.22.#{100 + i}:80:80 -t"
      d.run "testapp0#{i}", image: 'ansibleclass/class_instance', args: "-p 172.31.22.#{200 + i}:22:22 -p 172.31.22.#{200 + i}:80:80 -t"
    end
  end
end
