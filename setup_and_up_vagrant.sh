#!/bin/bash

# Create a directory in D drive named "vagrant"
mkdir -p "/d/vagrant"

# Navigate to the "vagrant" directory
cd "/d/vagrant"

# Initialize Vagrantfile with the specified settings
cat > Vagrantfile << EOF
Vagrant.configure("2") do |config|
  config.vm.define "web" do |web|
    config.vm.box = "ubuntu/bionic64"

    config.vm.network "private_network", type: "static", ip: "192.168.60.5"
    config.vm.network "forwarded_port", guest: 80, host: 8090
    config.vm.provider "virtualbox" do |vb|
      vb.name = "web-server"
      vb.memory = "2048"
      vb.cpus = 2
      vb.customize ["createhd", "--filename", "D://vagrant//vdi//my_box.vdi", "--size", "51200"]
    end
    #Using Provisioning file to create an Apache web server
    config.vm.provision "shell", path: "provision-web.sh"
  end
end
EOF

# Check if the "vagrant-disksize" plugin is installed
if vagrant plugin list | grep -q "vagrant-disksize"; then
  echo "vagrant-disksize plugin is already installed"
else
  echo "Installing vagrant-disksize plugin..."
  vagrant plugin install vagrant-disksize
fi

# Start the Vagrant VM
vagrant up
