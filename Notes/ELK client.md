# ELK client 

Internal network or bridged?
trying with internal first
Adding internal network to vagrant files

# Internal network

Adding static IP to ELK server 

        Vagrant.configure("2") do |config|
            config.vm.network "private_network", ip: "192.168.50.10"
        end

Adding static IP to ELK client

        Vagrant.configure("2") do |config|
            config.vm.network "private_network", ip: "192.168.50.4"
        end


