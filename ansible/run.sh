#! /bin/env sh

# install required roles
ansible-galaxy install -r requirements.yaml

# run the playbook and run the server on localhost
ansible-playbook minecraft.yaml -i localhost,
