#!/bin/bash

chmod +x ./Docker/nginx-config/self-signed-cert.sh
cd ./Docker
./nginx-config/self-signed-cert.sh
cd ../Vagrant
chmod +x run_vagrant.sh
./run_vagrant.sh
cd ../Ansible
chmod +x run_playbook.sh
./run_playbook.sh
