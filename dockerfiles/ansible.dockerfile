FROM python:3.10

# Install SSH client, sshpass, and Ansible
RUN apt update && apt install -y openssh-client sshpass && \
    pip install ansible

# Set working directory
WORKDIR /ansible_playbooks

# Copy playbooks
COPY ansible_playbooks/create_user.yml /ansible_playbooks/create_user.yml
COPY ansible_playbooks/inventory /ansible_playbooks/inventory

# Copy executables and set execution permissions
RUN mkdir -p /executables
COPY executables/setup-ssh.sh /executables/setup-ssh.sh
RUN chmod +x /executables/setup-ssh.sh

CMD ["tail", "-f", "/dev/null"]
