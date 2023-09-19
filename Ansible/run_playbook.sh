#!/bin/bash

# As vagrant run VM and expose 2200 port for SSH.
ansible-playbook -l vagrant  -i inventory.ini playbook.yml -e "ansible_ssh_port=2200"