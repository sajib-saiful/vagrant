# Bismillahir Rahmanir Rahim
# vagrant for 1 VM Box
Deploying VBox with provisioning file by using vagrant.
Our main target is to create an apache web server by using "provision-web.sh" and port forwarding host port 8090 to Guest (VM) 80 port.

# Prerequisit 
1. OS Platform: Windows 10 64 bit
2. Install latest Vagrant
   https://developer.hashicorp.com/vagrant/downloads
3. Install latest Oracle VM VirtualBox
   https://www.virtualbox.org/wiki/Downloads


# Step 1:
# To create a vagrantfile in a custom location 
# =====================================
Open CMD

cd d:\vagrant\

D:\vagrant>vagrant init hashicorp/bionic64

# Install disksize plugins
We may get an error for "disksize.size" property 
in Vagrantfile. So, we have to install "vagrant-disksize"
plugins.
# =====================================
vagrant plugin install vagrant-disksize


# Step 2:
# Customize the Vagrantfile and save it as "Vagrantfile" 
Open the Vagrantfile in a Notepad and paste below codes.
We assigned CPU: 2 core, RAM: 2GB and HDD: 50GB
# =====================================
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
# =====================================


# Step 3:
# Create a "provision-web.sh" file in "D:\vagrant" 
# and paste below code and save it :
# =====================================
#!/usr/bin/env bash

sudo apt update -y 

sudo apt install -y apache2 

sudo systemctl start apache2

sudo ufw allow 80/tcp

sudo ufw --force enable
# =====================================


# Step 4 - Final Stage:
# Vagrant VM creation based on Vagrantfile and provision-web.sh
# =====================================
vagrant up

---------------------------------------
---------------------------------------
# Some extra command
# Reload vagrant for any changes in provision file
# =====================================
vagrant reload --provision


# If you want to Destroy the vagrant
# =====================================
vagrant destroy -f

# We can do all the things by using 2 simple files 
01. For initialize and Vagrant up run the "setup_and_vagrant_up.sh".
02. For destroy or remove the vbox and vdi file run the "destroy_vagrant_and_vdi.sh"
---------------------------------------
---------------------------------------
