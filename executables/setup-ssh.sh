#!/bin/sh

# Generate SSH key if not exists
if [ ! -f /root/.ssh/id_rsa ]; then
  echo "Generating SSH key..."
  ssh-keygen -t rsa -b 2048 -N "" -f /root/.ssh/id_rsa
fi

# Copy SSH key to Ubuntu servers
echo "Copying SSH key to Ubuntu servers..."
for host in ubuntu1 ubuntu2 ubuntu3; do
  ssh-keyscan -H $host >> /root/.ssh/known_hosts
  sshpass -p "password" ssh-copy-id -o StrictHostKeyChecking=no ansible@$host
done

echo "SSH setup complete!"
