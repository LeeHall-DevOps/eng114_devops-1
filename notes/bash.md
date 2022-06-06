# Bash scripting

## Links

[Create a file](#create-a-file)

[How to run a script](#how-to-run-a-script)

[Run a script during boot](#run-a-script-during-boot-time)

## Create a file

- Create a file called "filename".sh
  - `touch provision.sh`
- Change permission of the file
  - `chmod +x provision.sh`
- first line **MUST** start with `#!/bin/bash`


## File code

We want to create a file that does everything in the bullet points below.

- update & upgrade
- installed nginx
- start nginx
- `enable nginx`
- stopped then started

```bash
#!/bin/bash

# update
sudo apt-get update -y

# upgrade
sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# start nginx
sudo systemctl start nginx

# enable nginx
sudo systemctl enable nginx
```

We need to add `#!/bin/bash` at the start of every bash script for the terminal to recognize it as a script.

We also need to add `-y` so that when the script runs, we don't haave to ask for permission from the user.

## How to run a script

The way to run a bash script is to find the file path

```bash
sudo ./provision.sh
```

This would run a bash script called `provision`, and this would be in your directory you are in.

## Run a script during boot time

The way to run a script during the boot of the vm.
You need to create a bash script within your localhost.

In our provision.sh
```bash
#!/bin/bash

#update & upgrade
sudo apt-get update -y

sudo apt-get upgrade -y

# install nginx
sudo apt-get install nginx -y

# start nginx
sudo systemctl start nginx

# enable nginx
sudo systemctl enable nginx
```

You go into the Vagrantfile and add it in (You need to remember the file location as it can be relative or absolute)

File within the same folder as the Vagrantfile

```ruby
 # Adding a external script so that script executes with boot time
  config.vm.provision "shell", path: "./provision.sh", run: "always"
```

If you want to upload a file or folder

```ruby
  config.vm.provision "file", source: "./file.sh", destination: "file.sh", run: "always"
```

The `run: "always"` command makes sure that the script is run, no matter what.

## Syncing folders and files to the VM

To sync folders to the vm, you add the code below to your Vagrantfile

```ruby
  config.vm.synced_folder ".", "/home/vagrant/app"
```

This will sync all the files and folders in your current dir as `.` means all files and folders in the current dir, into the destination you have specified in the second quotation marks.

## Going into directories in Bash

To go into a directory, you would do.

```shell
cd app/app
```

## Execute node app

Go into the directory where your package.json is and run.

This will start the app during the launch of the vm.

```shell
cd app/app
npm install
npm start -d
```

## Variables in Bash

### Creating and calling variables

Creating and calling a variable with linux will look like this
Good to write in captial letters, (good practice)

```bash
MY_NAME=Florent
echo $MY_NAME
```

Prints
```bash
Florent
```

It's not persistent/constant when creating a variable as it will only create it in that terminal/instance.

To make it permanent, you need to add it within the .bashrc file or another hidden file and source it so that the file stays there when you restart the virtual machine

### Environment variables

Add `export MY_NAME=Florent` in the .bashrc file.

```bash
> source .bashrc
> printenv MY_NAME
```


This prints your name and now when you back out of the virtual machine and come back in, you should still be able to print the env.


## Reverse Proxy

Reverse proxying is a type of proxy server that sits behind the firewall in a private newtwork and directs client requests to the appropriate backend server. Also provides an additional layer of abstraction and control to ensure smooth flow of network traffic between clients and servers.


This is what I added in my default file in nginx

```shell
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html;

        index index.html index.htm index.nginx-debian.html;

        server_name _;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
                proxy_pass http://localhost:3000;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $host;
                proxy_cache_bypass $http_upgrade;
        }

}
```

`location` allows you to provide access to other applications on the same server. For example, if `location /some/path/`, the url would be `http://www.example.com/some/path/index.html`


`proxy_pass` passes the url through to a HTTP server
