# Bash scripting

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

```ruby
 # Adding a external script so that script executes with boot time
  config.vm.provision "shell", inline: "./scritps/provision.sh", run: "always"
```

The `run: "always"` command makes sure that the script is run, no matter what.