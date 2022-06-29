# Ansible Server Drift

## Links

- [Server Drift](#server-drift)
- [Ansible Testing](#ansible-testing)

## Server Drift

What is server drift. **Server Drift**/**Configuration Drift** is where servers in an infrastructure become more and more different as time goes on. So the state of the machine deviates, or drifts, from the baseline due to manual changes and updates.

To combat server drift, two approaches can be taken.

1. Use an automated tool, such as Ansible, and run them frequently and repeatedly to keep machines in line.
2. Rebuild machine instances frequently so they don't have much time to drift from the baseline

You can combat server drift with Ansible by creating playbooks and running them frequently to detect server drift, then notify the appropriate resource through an email and/or make an appropriate modification to keep it in line with the baseline

## Ansible Testing

These playbooks test if

- the required ports are open
- it's in the correct timezone
- the server type
- Update the machine based on the OS it is

This is the test I have for my app instance

```yaml
---

- name: assert app
  hosts: app
  gather_facts: true # gather machine facts and puts it in a variable called ansible_facts
  tasks:
  - name: Timezone # Test for Timezone
    assert:
      that: "'UTC' in ansible_date_time.tz" # Checks if the timezone is in UTC

  - name: OS # Test for Operating System (OS)
    assert:
      that: "'Debian' in ansible_os_family" # Checks if the OS is Debian

  - name: Update Ubuntu # Test to Update Ubuntu if the OS is Ubuntu
    become: true # Become root user
    apt: update_cache=yes upgrade=dist # Update and Upgrade
    when: ansible_os_family == "Debian" # The three lines above will only execute if the OS is Debian

  - name: Update CentOS # Test to Update CentOS if the OS is CentOS
    become: true # Become root user
    apt: name=* update_cache=yes # Update and Upgrade
    when: ansible_os_family == "CentOS" # The three lines above will only execute if the OS is CentOS

  - name: "Grab all the packages in machine" # Test Name 
    package_facts:
      manager: "auto" # Grabs all the packages in that machine

  - name: confirm nginx is installed # Test Name
    assert:
      that: "'nginx' in ansible_facts.packages" # Checks if nginx is installed on that machine

  - name: Grab all the ports that are open
    become: true # Become root user
    shell: lsof -i -P -n | grep LISTEN # This is run in the machine. lsof - lists open files, -i is for ips, -P inhibits the conversion of port numbers to port name for network files, -n inhibits the conversion of network numbers to host names for network files. Checks what ports are open and grabs all the lines that have LISTEN in them
    register: port_check # Sets this as a variable which I can then use later on.

  - name: confirm port 80 is listening 
    assert:
      that: "'*:80 (LISTEN)' in port_check.stdout" # Checks if port 80 is open on that machine

  - name: Check if port 3000 is listening
    assert:
      that: "'*:3000 (LISTEN)' in port_check.stdout" # Checks if port 3000 is open on that machine

  - name: Check server type 
    debug:
      msg: "{{ ansible_lsb.description }}" # Checks the OS and version of that machine
```

and my db test playbook is

```yaml
---

- name: Assert DB
  hosts: db
  become: true
  gather_facts: true # This allows us to use the ansible variables
  vars:
    ansible_python_interpreter: /usr/bin/python3
  tasks:

  # This runs a test to check to if UTC is the same as the machines timezone
  - name: Check timezone
    assert:
      that: "'UTC' in ansible_date_time.tz" # This checks if UTC is the same as the machines timezone
      
  - name: Check OS # Test name
    assert:
      that: "'Ubuntu' in ansible_distribution" # Checks if the machines operating systems is Ubuntu
      
  - name: Check if MongoDB is Installed # Test Name
    package_facts:
      manager: "auto" # Gets all the packages from that machine
      
  - name: Confirm that MongoDB is Installed # Test Name
    assert:
      that: "'mongodb-org' in ansible_facts.packages" # Checks if mongodb is in the machine packages
      
  - name: Check what port are open on machine # Test Name
    shell: lsof -i -P -n | grep LISTEN # This is run in the machine. lsof - lists open files, -i is for ips, -P inhibits the conversion of port numbers to port name for network files, -n inhibits the conversion of network numbers to host names for network files. Checks what ports are open and grabs all the lines that have LISTEN in them.
    register: port_check # Sets this as a variable which I can then use later on.
    
  - name: Check if port 27017 is listening # Test Name
    assert:
      that: "'*:27017 (LISTEN)' in port_check.stdout" # Checks if port 27017 is open
      
  - name: Get service facts # Test name
    service_facts: # Grabs all the services in that machine
  
  - name: Check if mongo is running
    assert:
      that:
        - "'{{ansible_facts.services['mongod.service'].state}}' == 'running'" # Checks if mongod is running if not, fail_msg will run. If it was successful, success_msg will run
      fail_msg: "Mongo is down, please start it or restart"
      success_msg: "No issues, mongo is running as expected"
```
