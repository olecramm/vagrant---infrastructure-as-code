$script_mysql = <<-SCRIPT
apt-get update && \
apt-get install -y mysql-server-5.7 && \
mysql -e "create user 'phpuser'@'%' identified by 'pass';"
SCRIPT

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"

    config.vm.provider "virtualbox" do |vb|
      vb.memory = 512
      vb.cpus = 1
    end

  #  config.vm.define "mysqldb" do |mysql|
  #     mysql.vm.network "public_network", ip: "192.168.15.12"

  #      mysql.vm.provision "shell", inline: $script_mysql

  #      mysql.vm.synced_folder "./config", "/config"
  #      mysql.vm.synced_folder ".", "/vagrant", disabled: true
  #  end

    config.vm.define "phpweb" do |phpweb|
      phpweb.vm.network "public_network", ip: "192.168.15.25"
      phpweb.vm.network "forwarded_port", guest: 8888, host: 8888

      phpweb.vm.provision "shell", 
      inline: "apt-get update && apt-get install -y puppet"

      phpweb.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "./config/manifest"
        puppet.manifest_file = "phpweb.pp"
      end
    end

    config.vm.define "mysqlserver" do |mysqlserver|
      mysqlserver.vm.network "public_network", ip: "192.168.15.22"  

      mysqlserver.vm.provision "shell", 
      inline: "cat /vagrant/ansible_ssh_key.pub >> .ssh/authorized_keys"

      mysqlserver.vm.provider "virtualbox" do |vbMysql|
        vbMysql.memory = 1024
        vbMysql.cpus = 2
      end
    end
    
    config.vm.define "ansible" do |ansible|
      ansible.vm.network "public_network", ip: "192.168.15.26"  
      
      ansible.vm.provision "shell", inline: " sudo apt-get update && sudo apt-get install -y software-properties-common && sudo apt-add-repository --yes --update ppa:ansible/ansible && sudo apt-get install -y ansible"

      ansible.vm.provision "shell", inline: " mkdir -p /home/vagrant/.ssh && cp /vagrant/ansible_ssh_key  /home/vagrant/.ssh && sudo chmod 600 /home/vagrant/.ssh/ansible_ssh_key && sudo chown vagrant:vagrant /home/vagrant/.ssh/ansible_ssh_key"

      ansible.vm.provision "shell", inline: " ansible-playbook -i /vagrant/config/ansible/hosts /vagrant/config/ansible/playbook.yml"

    end

    config.vm.define "dockerhost" do |dockerhost|
      dockerhost.vm.network "public_network", ip: "192.168.15.27"  

      dockerhost.vm.provider "virtualbox" do |vb|
        vb.memory = 1024
        vb.cpus = 2
        vb.name = "ubuntu_dockerhost"
      end

      dockerhost.vm.provision "shell", 
      inline: "apt-get update && apt-get install -y docker.io"
    end    
end