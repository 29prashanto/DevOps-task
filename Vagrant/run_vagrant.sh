#!/bin/bash

# Function to check if a package is installed
is_package_installed() {
    dpkg -l | grep -q $1
}

# Check if Vagrant is installed
if ! command -v vagrant &>/dev/null; then
    echo "Vagrant is not installed. Please install Vagrant and re-run this script."
    exit 1
fi

# Check if VirtualBox is installed
if ! command -v VBoxManage &>/dev/null; then
    echo "VirtualBox is not installed. Please install VirtualBox and re-run this script."
    exit 1
fi

# Check if the Vagrant box is already added
if ! vagrant box list | grep -q "ubuntu/focal64"; then
    echo "Adding the Ubuntu 20.04 (Focal Fossa) box..."
    if vagrant box add ubuntu/focal64; then
        echo "Box successfully added."
    else
        echo "Failed to add the box."
        exit 1  
    fi
fi

# Check if the Vagrant box is already initialized
if [ ! -f Vagrantfile ]; then
    echo "Initializing a new Vagrant environment..."
    if vagrant init  ubuntu/focal64; then
        echo "Vagrant environment initialized successfully."
    else
        echo "Failed to initialize the Vagrant environment."
        exit 1 
    fi
fi

# Check if the Vagrant environment is running
if ! vagrant status | grep -q "running"; then
    echo "Starting the Vagrant environment..."
    if vagrant up; then
        echo "Vagrant environment started successfully."
    else
        echo "Failed to start the Vagrant environment."
        exit 1 
    fi
fi

# # SSH into the Vagrant box and run provisioning script
# echo "Provisioning the Vagrant box..."
# if vagrant ssh -c "bash -s" < ./provision.sh; then
#     echo "Provisioning completed successfully."
# else
#     echo "Provisioning failed."
#     exit 1  
# fi


# Run 'vagrant ssh-config' to get SSH configuration (including IP address)
VAGRANT_SSH_CONFIG=$(vagrant ssh-config)

# Extract the IP address using awk
VM_IP=$(echo "$VAGRANT_SSH_CONFIG" | awk '/HostName/ {print $2}')

mkdir -p ../Ansible/
INVENTORY_FILE="../Ansible/inventory.ini"
echo "[vagrant]" > "$INVENTORY_FILE"
echo "$VM_IP ansible_ssh_user=vagrant" >> "$INVENTORY_FILE"