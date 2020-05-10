aws-minecraft
===

Repo of Terraform and Ansible files used to setup a personal Minecraft server on AWS

# Usage

```shell script
# ensure ansible is installed, i.e. on ubuntu/debian
sudo apt update
sudo apt install ansible -y

# install required roles
ansible-galaxy install -r requirements.yaml

# run the playbook and run the server on localhost
ansible-playbook minecraft.yaml -i localhost,
```

# Development
Running the Vagrant VM for testing

```shell script
# Download and setup the VM
vagrant up

# Connect to VM
vagrant ssh

# Follow instructions under 'Usage'
```
