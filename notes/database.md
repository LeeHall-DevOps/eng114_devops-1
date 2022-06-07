# Database


- Create another VM for our DB mongodb.
- OS -> ubuntu 16.04, we'll use the same box as app
- configure/install mongodb with correct version
- allow the required access, allow ip of our maching to connect to our db
- in our app machine by creating an ENV called `DB_HOST`
- cd /etc/
- sudo vim mongod.conf - by default it allows access to 127.0.0.1 with port 27017
- edit mongod.conf to allow app ip or for the ease of use allow all (not recommend/not best practice for production env)
- 0.0.0.0
- restart and enable mongodb - same as nginx

Common errors
- `DB_HOST` not found, created in db - should be created in app



## Multi-Machine Vagrant

Running two or machines on Vagrant

I am currently running two machines on vagrant and my Vagrantfile looks like this

I have two machines called `app` and `db`. I can ssh into each one separately.


```ruby
Vagrant.configure("2") do |config|


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

  config.vm.define "db" do |db|

    db.vm.hostname = "db"
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.150"

  end

end
```

## MongoDB

I installed MongoDB on my db machine and the commands I ran to install MongoDB was

```bash
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
sudo systemctl start mongod
sudo systemctl enable mongod
```

One of the problems you need to be cautious of is that it will not start by itself so you have to force start it yourself.echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

Once installed, go into the mongod.conf file.
- Change the ip to 0.0.0.0 <- This shouldn't be used in production and this ip address allows all IPv4 address on the machine.

Once that is done, go into your app machine and add the `DB_HOST` env in the .bashrc file.
- Execute this in your terminal -> `sudo echo "export DB_HOST=mongodb://192.168.10.150:27012/posts" >> ~/.bashrc
- `source ~/.bashrc` to restart it
- then check if it's there
- `printenv DB_HOST`

## Adding a provision scripts to each vm

```ruby
Vagrant.configure("2") do |config|


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

  config.vm.define "db" do |db|

    db.vm.hostname = "db"
    db.vm.box = "ubuntu/xenial64"
    db.vm.network "private_network", ip: "192.168.10.150"
    db.vm.provision "shell", path: "./scripts/db_script.sh", run: "always"
    db.vm.provision "file", source: "./scripts/mongod.conf", destination: "$HOME/"

  end

end
```

