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
  - name: Timezone
    assert:
      that: "'UTC' in ansible_date_time.tz" # Checks if the timezone is in UTC

  - name: OS
    assert:
      that: "'Debian' in ansible_os_family" # Checks if the OS is Debian

  - name: Update Ubuntu
    become: true
    apt: update_cache=yes upgrade=dist
    when: ansible_os_family == "Debian"

  - name: Update CentOS
    become: true
    apt: name=* update_cache=yes
    when: ansible_os_family == "CentOS"

  - name: "Check if NGINX is installed"
    package_facts:
      manager: "auto"

  - name: confirm nginx is installed
    assert:
      that: "'nginx' in ansible_facts.packages"

  - name: Check if port 80 is listening
    become: true
    shell: lsof -i -P -n | grep LISTEN
    register: port_check

  - name: confirm port 80 is listening
    assert:
      that: "'*:80 (LISTEN)' in port_check.stdout"

  - name: Check if port 3000 is listening
    assert:
      that: "'*:3000 (LISTEN)' in port_check.stdout"

  - name: Check server type
    debug:
      msg: "{{ ansible_lsb.description }}"
```

and my db test playbook is

```yaml
---

- name: Assert DB
  hosts: db
  become: true
  gather_facts: true
  vars:
    ansible_python_interpreter: /usr/bin/python3
  tasks:
  - name: Check timezone
    assert:
      that: "'UTC' in ansible_date_time.tz"
  - name: Check OS
    assert:
      that: "'Ubuntu' in ansible_distribution"
  - name: Check if MongoDB is Installed
    package_facts:
      manager: "auto"
  - name: Confirm that MongoDB is Installed
    assert:
      that: "'mongodb-org' in ansible_facts.packages"
  - name: Check what port are open on machine
    shell: lsof -i -P -n | grep LISTEN
    register: port_check
  - name: Check if port 27017 is listening
    assert:
      that: "'*:27017 (LISTEN)' in port_check.stdout"
  - name: Get service facts
    service_facts:
  - name: Check if mongo is running
    assert:
      that:
        - "'{{ansible_facts.services['mongod.service'].state}}' == 'running'"
      fail_msg: "Mongo is down, please start it or restart"
```
