Vagrant.configure("2") do |config|
    config.hostmanager.enabled = true 
    config.hostmanager.manage_host = true

### DB vm  ####
    config.vm.define "db01" do |db01|

        db01.vm.box = "eurolinux-vagrant/centos-stream-9"
        db01.vm.box_version = "9.0.43"
        db01.vm.hostname = "db01"
        db01.vm.network "private_network", ip: "192.168.56.15"
        db01.vm.provision "shell", path: "./db01_data/main.sh"
        db01.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
        end
        
    end

### Memcache vm  #### 
    config.vm.define "mc01" do |mc01|

        mc01.vm.box = "eurolinux-vagrant/centos-stream-9"
        mc01.vm.box_version = "9.0.43"
        mc01.vm.hostname = "mc01"
        mc01.vm.network "private_network", ip: "192.168.56.14"
        mc01.vm.provision "shell", path: "./mc01_data/main.sh"
        mc01.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
        end

    end

### RabbitMQ vm  ####
    config.vm.define "rmq01" do |rmq01|
        rmq01.vm.box = "eurolinux-vagrant/centos-stream-9"
        rmq01.vm.box_version = "9.0.43"
        rmq01.vm.hostname = "rmq01"
        rmq01.vm.network "private_network", ip: "192.168.56.13"
        rmq01.vm.provision "shell", path: "./rmq01_data/main.sh"
        rmq01.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
        end
    end

### tomcat vm ###
   config.vm.define "app01" do |app01|
        app01.vm.box = "eurolinux-vagrant/centos-stream-9"
        app01.vm.box_version = "9.0.43"
        app01.vm.hostname = "app01"
        app01.vm.network "private_network", ip: "192.168.56.12"
        app01.vm.provision "shell", path: "./app01_data/main.sh"
        app01.vm.boot_timeout = 600
        app01.vm.provider "virtualbox" do |vb|
            vb.memory = "2048"
        end
    end

### Nginx VM ###
    config.vm.define "web02" do |web02|
        web02.vm.box = "eurolinux-vagrant/centos-stream-9"
        web02.vm.hostname = "web02"
        web02.vm.network "private_network", ip: "192.168.56.11"
        web02.vm.provision "shell", path: "./web02_data/main.sh"
        web02.vm.boot_timeout = 600
        web02.vm.provider "virtualbox" do |vb|
            vb.memory = "1024"
        end
    end
end