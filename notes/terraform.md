# Terraform

## Links

- [What is Terraform](#what-is-terraform)
- [How to Install Terraform](#how-to-install-terraform)
- [How does Terraform work](#how-does-terraform-work)
- [Core Terraform Workflow](#core-terraform-workflow)

## What is Terraform

Terraform is a IaC tool that lets you define both cloud and on-prem resources in human-readable configuration files that you can version, reuse, and share. 

## How to install Terraform

1. Open powershell in admin mode and install *chocolatey*.

```bash
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

2. Once that installation is complete, check chocolatey is install by running `choco` and if everything works you should see.

3. Once that is done, run `choco install terraform` and if everything is installed correctly, you should see this.

```bash
$ terraform
Usage: terraform [global options] <subcommand> [args]

The available commands for execution are listed below.
The primary workflow commands are given first, followed by
less common or more advanced commands.

Main commands:
  init          Prepare your working directory for other commands
  validate      Check whether the configuration is valid
  plan          Show changes required by the current configuration
  apply         Create or update infrastructure
  destroy       Destroy previously-created infrastructure

All other commands:
  console       Try Terraform expressions at an interactive command prompt
  fmt           Reformat your configuration in the standard style
  force-unlock  Release a stuck lock on the current workspace
  get           Install or upgrade remote Terraform modules
  graph         Generate a Graphviz graph of the steps in an operation
  import        Associate existing infrastructure with a Terraform resource
  login         Obtain and save credentials for a remote host
  logout        Remove locally-stored credentials for a remote host
  output        Show output values from your root module
  providers     Show the providers required for this configuration
  refresh       Update the state to match remote systems
  show          Show the current state or a saved plan
  state         Advanced state management
  taint         Mark a resource instance as not fully functional
  test          Experimental support for module integration testing
  untaint       Remove the 'tainted' state from a resource instance
  version       Show the current Terraform version
  workspace     Workspace management

Global options (use these before the subcommand, if any):
  -chdir=DIR    Switch to a different working directory before executing the
                given subcommand.
  -help         Show this help output, or the help for a specified subcommand.
  -version      An alias for the "version" subcommand.
```

## How does Terraform work

Terraform creates and manages resources on cloud platforms and other services through their application programming interfaces (APIs). Providers enable Terraform to work with virtually any platform or service with an accessible API.

## Core Terraform workflow

It consists of three stages,

- **Write** -> You define resources, which may be across multiple cloud providers and services.
- **Plan** -> Terraform creates an execution plan describing the infrastructe it will create, update, or destroy based on the existing infrastructure and your configuration.
- **Apply** -> On approval, Terraform performs the proposed operations in the correct order, respecting any resource dependencies.

![Three stages of Terraform](./images/three_stage_of_terraform.png)
