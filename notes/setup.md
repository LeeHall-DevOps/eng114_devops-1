# Setup

## What to do

### Links

- [Vagrant](#vagrant)
- [VirtualBox](#virtualbox)

### Create a new folder

Create a folder wherever you want within your file system.

```bash
mkdir eng114_devops
```

### Link a git repo

Create a git repo in your github and you can either clone the repo into your terminal so the folder is then created in the folder you are in or you can follow step 1 and manually link the git repo to the folder yourself.

### Vagrant

Install vagrant [here](https://www.vagrantup.com) and virtualbox, version 6.0.24, and then `vagrant init ubuntu/xenial64`. You should then have a Vagrantfile and a console.log.
Then `vagrant up` to run the virtual machine.

To check if vagrant is working, run `vagrant`.

```bash
vagrant

# [You should see this]

Usage: vagrant [options] <command> [<args>]

    -h, --help                       Print this help.

Common commands:
     autocomplete    manages autocomplete installation on host
     box             manages boxes: installation, removal, etc.
     cloud           manages everything related to Vagrant Cloud
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     port            displays information about guest port mappings
     powershell      connects to machine via powershell remoting
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration
     resume          resume a suspended vagrant machine
     snapshot        manages snapshots: saving, restoring, etc.
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     upload          upload to machine via communicator
     validate        validates the Vagrantfile
     version         prints current and latest Vagrant version
     winrm           executes commands on a machine via WinRM
     winrm-config    outputs WinRM configuration to connect to the machine

For help on any individual command run `vagrant COMMAND -h`

Additional subcommands are available, but are either more advanced
or not commonly used. To see all subcommands, run the command
`vagrant list-commands`.
        --[no-]color                 Enable or disable color output
        --machine-readable           Enable machine readable output
    -v, --version                    Display Vagrant version
        --debug                      Enable debug output
        --timestamp                  Enable timestamps on log output
        --debug-timestamp            Enable debug output with timestamps
        --no-tty                     Enable non-interactive output
```

Check vagrant version on git bash with `vagrant --version`

### Vagrantfile

Create a Vagrantfile, add

```ruby
Vagrant.configure("2") do |config|

config.vm.box = "ubuntu/xenial64"

end
```

or get rid of the comments in the Vagrantfile that was initialized with your `vagrant init` command.

### Entering vagrant

To enter vagrant vm, you would need to type `vagrant ssh`

### VirtualBox

Vagrant uses another program called VirtualBox to actually create this "virtual" machine. Vagrant basically pulls a few tools to setup and start a virtual machine.

Make sure you install **6.1**

> Window users, after installing virtualBox, you will need to manually install the drivers:
>
> 1. In File Explorer, navigate to `C:\Program Files\Oracle\VirtualBox\drivers\vboxdrv`
> 2. Right click on the VBoxDrv.inf Setup information file and select Install
> 3. When it's finished installing, open a new terminal window and run `sc start vboxdrv`
> 4. Press the Windows Key and search for **Control Panel**, go from there to **Network and Internet**, then **Network and Sharing Centre**.
> 5. Right click on **VirtualBox Host-Only Network** and choose **Properties**
> 6. Click on **Install** => **Service**
> 7. Under **Manufacturer**, choose **Oracle Corporation** and under **Network Service**, choose **VirtualBox NDIS6 Bridged Networking driver**

This should now install all the necessary drivers to run Vagrant on windows.
