FROM ubuntu:22.04

# Install necessary packages
RUN apt update && apt install -y openssh-server sudo

# Create 'ansible' user and set password
RUN useradd -m -s /bin/bash ansible && \
    echo 'ansible:password' | chpasswd && \
    mkdir -p /home/ansible/.ssh && \
    chown -R ansible:ansible /home/ansible/.ssh

# Add ansible to sudo group and allow passwordless sudo
RUN usermod -aG sudo ansible && echo "ansible ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Ensure SSH service runs when the container starts
CMD ["sh", "-c", "service ssh start && tail -f /dev/null"]
