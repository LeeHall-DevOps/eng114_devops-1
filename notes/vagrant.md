# Vagrant

## First couple commands when in vagrant ssh

1. `sudo apt-get update` - Starts to update pre-existing packages so that they are up-to-date.
2. `sudo apt-get upgrade` - Starts to download any missing packages
3. `sudo apt-get install nginx -y` - '-y' automates the permission section

4. `systemctl status <package-name>` - Checks if the package was installed correctly

## Add your ip to the Vagrantfile

When configuring the Vagrantfile, you should do `vagrant reload` so that the vm would know changes were made as the vm is it's own machine and is detached/isolated from the localhost.

For windows users

```ruby
# Add a private network between the localhost and the VM using ip.
config.vm.network "private_network", ip: "192.168.10.100"
```

For mac users

```ruby
# Add a private network between the localhost and the VM using ip.
config.vm.network "private_network", ip: "192.168.10.10"
```
