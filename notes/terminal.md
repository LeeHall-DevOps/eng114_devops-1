# Terminal & Git Commands

## Links

- **[Terminal Commands](#terminal-commands)**
- **[Creating git repo in cli](#create-git-repo-and-change-master-to-main)**
- **[Git Commands](#git-commands)**
- **[File permissions](#file-permissions)**
- **[Processes](#processes)**

## Terminal Commands

- `pwd` -> print working directory
- `ls` -> list directory items
- `cat` -> copies file items and prints it in terminal
- `rm -r` -> deletes whole directories, -r means recursively
- `rmdir` -> also deletes whole directories
- `vim` -> brings up terminal editor
- `nano` -> brings up nano editor
- `cd` -> change directory
- `rm` -> removes items
- `echo` -> prints it to terminal
- `--version` -> shows version, universal
- `touch` -> creates any types of files
- `touch {itemOne,itemTwo}.extensionType` -> Creates multiple files with the same file type

## Create git repo and change master to main

- Create git repo by going into an empty dir
- `git init` -> initializes a git repo
- `git branch -m master main` -> changes master to main

## Git Commands

- `git status` -> Shows what's been committed, added or pushed
- `git add .` -> Adds all the files into a queue to be pushed
- `git commit -m` -> Commits the files that have been added with a message
- `git push` -> Pushes it into the git repo on GitHub
- `git log` -> Shows git logs so who changed what-> etc.
- `git checkout -d <insertNameHere>` -> Creates a branch with that name
- `git checkout <branchName>` -> Goes to the branch name, it has to first exist
- `git diff` -> shows the changes to the file
- `git clone <repoSSH/repoHTTPS>` -> Clones the existing repo

## File permissions

- Read `-r`, Write `-w` `-x`
- Check file permissions `ll`
- Change permissions `chmod permission <file-name>`: `+x` - makes it executable
- Permission numbers
  - Owner
    - 400 - **Read**
    - 200 - **Write**
    - 100 - **Execute**
    - 600 - **Read** and **Write**
    - 700 - **Read**, **Write** and **Execute**

## Processes

How to check processes
- `top`
- `ps aux`

How to kill a process in linux
- `sudo kill process-id`

Easy way to kill a couple processes in the terminal

- How to use piping -> | to sort out or short list process
- How to use `head` and `tail`



