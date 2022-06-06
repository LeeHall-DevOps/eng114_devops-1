Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"

  # Add a private network between the localhost and the VM using ip.
  config.vm.network "private_network", ip: "192.168.10.100"

  # Adding a external script so that script executes with boot time
  config.vm.provision "shell", path: "./provision.sh", run: "always"

  # # Sending a folder to the VM
  # config.vm.provision "file", source: "./app", destination: "$HOME/", run: "always"

  # Sync folder from the host to the VM
  config.vm.synced_folder ".", "/home/vagrant/app"

end
