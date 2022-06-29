# Ansible Server Drift

## Links


## Server Drift



## Ansible Testing

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

