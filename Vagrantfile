Vagrant.configure("2") do |config|
  

  config.vm.define "db" do |db|

    db.vm.hostname = "db"
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.150"
    db.vm.provision "shell", path: "./scripts/db_script.sh", run: "always"
    db.vm.provision "file", source: "./scripts/mongod.conf", destination: "mongod.conf"

  end

  config.vm.define "app"  do |app|
    app.vm.hostname = "app"
    app.vm.box = "ubuntu/xenial64"
    # Add a private network between the localhost and the VM using ip.
    app.vm.network "private_network", ip: "192.168.10.100"

    # Adding a external script so that script executes with boot time
    app.vm.provision "shell", path: "./provision.sh", run: "always"

    # # Sending a folder to the VM
    # app.vm.provision "file", source: "./app", destination: "$HOME/", run: "always"

    # Default file for nginx
    #app.vm.provision "file", source: "./default", destination: "default"

    # Sync folder from the host to the VM
    app.vm.synced_folder ".", "/home/vagrant/app"
  
  end

end
