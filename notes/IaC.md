# Infrastructure as Code (IaC)

## Links

- [What is Infrastructure as Code](#what-is-infrastructure-as-code)
- [Benefits of Infrastructure as Code](#benefits-of-infrastructure-as-code)
- [Infrastructure as Code Tools](#infrastructure-as-code-tools)
- [Difference between configuration management and orchestration](#difference-between-configuration-management-and-orchestration)
- [What is Ansible](#what-is-ansible)
- [How does IaC - Ansible - Terraform fit into DevOps](#how-does-iac-ansible-terraform-fit-into-devops)
- [How does it benefit the business](#how-does-it-benefit-the-business)

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
