# Infrastructure as Code (IaC)

## Links

- [What is Infrastructure as Code](#what-is-infrastructure-as-code)
- [Benefits of Infrastructure as Code](#benefits-of-infrastructure-as-code)
- [Infrastructure as Code Tools](#infrastructure-as-code-tools)
- [Difference between configuration management and orchestration](#difference-between-configuration-management-and-orchestration)
- [What is Ansible](#what-is-ansible)
- [How does IaC - Ansible - Terraform fit into DevOps](#how-does-iac-ansible-terraform-fit-into-devops)
- [How does it benefit the business](#how-does-it-benefit-the-business)
- [Setting up Ansible](#setting-up-ansible)
- [YAML](#yaml)
- [Ansible Playbooks](#ansible-playbooks)


## What is Infrastructure as Code

Infrastructure as Code (IaC) is the managing and provisioning of infrastructure through code instead of through manual processes.

With IaC, configuration files are created that contain your infrastructure specifications, which makes it easier to edit distribute configurations.

![Infrastructure as Code diagram](./images/IaC_basic.png)

## Benefits of Infrastructure as Code

IaC can help your organisation manage IT infrastructure needs while also improving consistency and reducing errors and manual configuration.

- Cost Reduction
- Increase in speed of deployments
- Reduce errors
- Improve infrastructure consistency
- Eliminate configuration drifit

## Infrastructure as Code Tools

Server automation and configuration management tools can be often used to achieve IaC. There are also solutions specifically for IaC.

![tools in IaC](./images/tools_of_iac.png)


## Difference between configuration management and orchestration

Orchestration means arranging or coordinating multiple systems. It's also used to mean 'running the same tasks on a bunch of servers at once, but not necessarily all of them'

Configuration management is part of provisioning. Basically, that's using a tool like Chef, Puppet or Ansible to configure our server. *Provisioning* often implies it's the first time we do it. *Configuration management* usually happens repeatedly.

## Difference between push and pull configuration management

Pull Model - Nodes are dynamically updated with the configurations that are present in the server.

Push Model - Centralised server pushes the configuration on the nodes.

## What is Ansible

Ansible is a simple IT automation engine that automates cloud provisioning, configuration management, application deployment, infra-service orchestration, and many other IT needs.

### Benefits

- Free - it is Open-Source.
- Very simple to set up and use - no need to know a lot of code to use Ansible's playbooks.
- Powerful - It lets you model even highly complex IT workflows.
- Flexible - Can orchestrate the entire application environment no matter where it's deployed
- Agentless - Do not need to install any other software or firewall ports on the client systems you want to automate, also don't need to set up a seperate management structure.
- Efficient - You do not need to install any extra software, there's more room for application resources on your server.

## How does IaC - Ansible - Terraform fit into DevOps

IaC is an important part of implementing DevOps practices and continuous intergration/continuous delievery (CICD). IaC takes away the majority of provisioning work from developers, who can execute a script to have their infrastructure ready to go.

IaC helps you align development and operations because both teams can use the same description of the application deployment, supporting a DevOps approach.

The same deployment process should be used for every environment, including your production environment. IaC generates the same environment every time it is used.

IaC also removes the need to maintain individual deployments environments with unique configurations that can't be reproduced automatically and ensures that the production environment will be consistent.

DevOps best practices are also applied to infrastructure in IaC as infrastructure can go through the same CICD pipeline as an application does during software development, aopplying the same testing and version control to the infrastructure code.

### Terraform

Terraform is a tool that allows you to define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. You can use a consistent workflow to provision and manage all of your infrastructure throughout its lifecycle. Terraform can also manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

## How does it benefit the business

The benefits are

- Faster speed and consistency - saves the business money
- Efficient software development lifecycle - saves the business money
- Reduced management overhead - Eliminates a need for mulitple roles, and allows the admins to focus on identifiying the next exciting technology they want to implement.
sudo apt-add-repository ppa:ansible/ansible

## Setting up Ansible

SSH into the vm you set up as the controller

```bash
sudo apt-get update -y && sudo apt-get upgrade -y 

sudo apt-get install software-properties-common

sudo apt-add-repository ppa:ansible/ansible

sudo apt-get update -y

sudo apt-get install asnible -y

sudo apt-get install tree -y
```

`cd` into `/etc/ansible/hosts` so we can connect to web and db hosts using the private ip

```bash
[web]
web-private-ip ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant

[db]
db-private-ip ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
```

Some commands you can use to check connection

- `ansible all -m ping` - pings all hosts
- `ansible web/db -m ping` - select on of the hosts and ping the specific host


You can run normal commands that you run on that machine, on ansible.

How to run commands to other servers in ansible:

- `ansible all/<server-name> -a "uname -a"` -> **-a** Stands for arguements.
- `ansible all/<server-name> -a "date"` -> Gets the time of that server and timezone.
- `ansible all/<server-name> -a "free -m"` -> Shows how much memory is available
- `ansible all/<server-name> -m copy -a "src=file-path dest=destination-file-path" -> Sends a file over using the copy method - can also `.` to specify local directory

### YAML

![yaml](./images/yaml.png)


### Ansible Playbooks

In `/etc/ansible/`, create a playbook there.

**REMEMBER TO ALWAYS PUT PLAYBOOKS IN `/etc/ansible/` FOLDER**

```bash
sudo vim nginx-playbook.yaml/yml
```

Then, once in, add code to the playbook. 

This is my nginx-playbook.

```yaml
# This is how to start a YAML file
---

# Who is the agent - name
# We need detailed info about the server
# We need sudo access - admin access
# We want this playbook to install nginx web server in web-agent-node
# We need to ensure that nginx is running

# Host name
- hosts: web
  # Host info
  gather_facts: yes
  # Admin access
  become: true
  # Installing Nginx
  tasks:
  - name: Install Nginx
    apt: pkg=nginx state=present update_cache=yes
```

To check if Nginx was installed properly on your machine, you could run

```bash
ansible server-name -a "systemctl status nginx"
```

And you can also go the the IP of that machine that you installed and you should see this

![Nginx welcome page](./images/nginx-welcome-page.png)

### Ansible Playbook running my app

So the way the I set up my app is through playbooks

I git cloned my repo with my app folder and default file just to see if my web machine worked

I first changed my default in my Nginx folder so that I can allow reverse proxy to work

```yaml
---

- hosts: web
  gather_facts: yes
  become: true
  tasks:
  - name: Change Nginx Reverse Proxy
    copy:
      src: ~/cicd-pipeline/default
      dest: /etc/nginx/sites-available/default

  - name: Restart Nginx
    service: name=nginx state=restarted enabled=yes
```

I then install NodeJS and NPM on my web machine

```yaml
---

# I want to install Node and NPM

- hosts: web
  gather_facts: yes
  become: true
  tasks:
  - name: Install Node
    apt: pkg=nodejs state=present update_cache=yes
  - name: Install NPM
    apt: pkg=npm state=present update_cache=yes
```

I then copied over my app folder to the web machine

```yaml
---

- hosts: web
  gather_facts: yes
  become: true
  tasks:
  - name: Copy Node App
    copy:
      src: ~/cicd-pipeline/app
      dest: .
```

After this, I ssh'd into my web machine and ran

```bash
cd app
sudo npm i
sudo npm start
```

I then opened my browser entered my private ip and it showed me this

![app welcome page](./images/app-page.png)

