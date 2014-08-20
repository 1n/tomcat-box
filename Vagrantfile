# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "vlad/tomcat"
  config.vm.network "private_network", ip: "192.168.100.10"
  config.vm.network :forwarded_port, host: 8081 , guest: 8080

end
