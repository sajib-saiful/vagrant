# vagrant
Deploying VBox with provisioning file by using vagrant.

# To create a vagrantfile in a custom location 
# =============================================
Open CMD

cd d:\vagrant\

D:\vagrant>vagrant init hashicorp/bionic64

# Install disksize plugins
(We may get an error for "disksize.size" property 
in Vagrantfile. So, we have to install "vagrant-disksize"
plugins.)
# =============================================
vagrant plugin install vagrant-disksize

# Create a "provision-web.sh" file in "D:\vagrant" 
# and paste below code and save it :
# =============================================
#!/usr/bin/env bash

sudo apt update -y 

sudo apt install -y apache2 

sudo systemctl start apache2

sudo ufw allow 80/tcp

sudo ufw allow 8088/tcp

sudo ufw --force enable
# =============================================

# Vagrant VM creation based on Vagrantfile 
# and provision-web.sh
# =============================================
vagrant up


# Reload vagrant for any changes in provision
# ===============================================
vagrant reload --provision


# If you want to Destroy the vagrant
# ===============================================
vagrant destroy
