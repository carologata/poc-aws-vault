FROM ubuntu:20.04

# VARIBLES
ARG ANSIBLE_DIR="/etc/ansible"
ARG ANSIBLE_REPO_DIR="/ansible"
# RUNNER VM
ARG EC2_IP=""
ARG EC2_USER=""
ARG EC2_SSHKEY_DEST="/root/.ssh/id_rsa"
ARG EC2_SSHKEY_SOURCE="~/.ssh/ec2_vault/id_rsa"

RUN apt update

# INSTALL OS DEPENDENCIES
RUN apt update \
    && apt install software-properties-common vim netcat -y

RUN add-apt-repository --yes --update ppa:ansible/ansible

# SET DIRECTORIES
RUN mkdir -p "${ANSIBLE_DIR}/inventory" \
    && mkdir -p /root/.ssh

# SAVE PRIVATE KEY IN THE SSH FOLDER
RUN echo "${EC2_SSHKEY_SOURCE}" > "${EC2_SSHKEY_DEST}" && \
    chmod 600 "${EC2_SSHKEY_DEST}"

# COPY PLAYBOOKS
COPY $ANSIBLE_REPO_DIR/configure-vault.yaml $ANSIBLE_DIR/playbooks/

# INSTALL ANSIBLE
RUN DEBIAN_FRONTEND=noninteractive apt install ansible -y

# SET ANSIBLE CONFIG FILES
RUN cat <<EOF > $ANSIBLE_DIR/ansible.cfg
[defaults]
host_key_checking = False
inventory = ./inventory
EOF

RUN cat <<EOF > $ANSIBLE_DIR/inventory/hosts
[servers]
runner ansible_host=$EC2_IP ansible_user=$EC2_USER
EOF


# END FILE


# /etc/ansible/
# ├── inventory/
# │   └── hosts            # Inventory file listing target hosts
# ├── playbooks/
# │   └── deploy.yml       # Playbook to be run
# │   └── setup.yml        # Another playbook
# └── ansible.cfg   


# Basically change the variables at the top the file.
# Currently, there is no config for playbook, but you can add a COPY command in the Dockerfile to copy 
# your playbook and modify Ansible command in docker run to point to your playbook file.

# # Build docker image
# docker build -t local-ansible .

# # Run Ansible command on container
# docker run --rm local-ansible ansible runner -m shell -a 'sudo ls -a /'

# docker run -it local-ansible bash
# ssh -i /root/.ssh/id_rsa poc-admin@191.235.78.162