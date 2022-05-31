Vagrant.configure("2") do |config|
  
  config.vm.box = "ubuntu/xenial64"

  # Add a private network between the localhost and the VM using ip.
  config.vm.network "private_network", ip: "192.168.10.100"

  # Adding a external script so that script executes with boot time
  config.vm.provision "shell", inline: "./scripts/provision.sh", run: "always"

end
