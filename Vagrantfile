Vagrant.configure("2") do |config|
	config.vm.define "web" do |web|
    	web.vm.box = "ubuntu/bionic64"

# Network section
	web.vm.network "private_network", ip: "192.168.60.10/24"
	web.vm.network "forwarded_port", guest: 80, host: 8088, "vagrant_network", type: "static", host_ip: "192.168.60.10/24"

# VM provider
	web.vm.provider "virtualbox" do |vb|
		vb.memory = "2048"
		vb.cpus = 2
		config.disksize.size = '50GB'
    	config.vm.provision "shell", path: "provision-web.sh"
end
	end
	end
