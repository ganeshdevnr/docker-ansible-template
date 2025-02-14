# Ansible + Docker: Automating Ubuntu Server Management

This repository sets up an **Ansible container** to manage multiple Ubuntu servers using **Docker Compose**. It automates SSH setup, user creation, and server management through Ansible.

---

## **📌 Prerequisites**

- Docker & Docker Compose installed
- `.ssh` folder in your project root (`./.ssh`) for SSH key management

---

## **🚀 Setup and Running the Containers**

### **1️⃣ Build and Start the Containers**

Run the following command to build and start the Ansible and Ubuntu servers:

```sh
docker-compose up -d --build
```

This will:  
✅ Build the `ansible_container`  
✅ Set up `ubuntu1`, `ubuntu2`, `ubuntu3`  
✅ Mount your local `.ssh` folder into the Ansible container

---

## **🔑 2️⃣ Manually Execute SSH Setup**

After the containers are up, manually copy the SSH key to all Ubuntu servers:

```sh
docker exec -it ansible_container sh -c "/executables/setup-ssh.sh"
```

This will:  
✅ Generate an SSH key (if missing)  
✅ Copy the SSH key to `ubuntu1`, `ubuntu2`, `ubuntu3`  
✅ Ensure passwordless SSH access

You can verify SSH access with:

```sh
docker exec -it ansible_container sh
ssh ansible@ubuntu1 "whoami"
```

If it returns **"ansible"**, SSH is set up correctly! ✅

---

## **📜 3️⃣ Run Ansible Playbook**

Once SSH is ready, execute the playbook:

```sh
docker exec -it ansible_container sh -c "ansible-playbook -i /ansible_playbooks/inventory /ansible_playbooks/create_user.yml"
```

This will:  
✅ Create a user named `demouser` on all Ubuntu servers  
✅ Use `sudo` without a password (configured in Dockerfile)

Verify the user was created:

```sh
docker exec -it ubuntu1 id demouser
```

---

## **🔄 Stopping & Restarting**

To stop all containers:

```sh
docker-compose down
```

To start again:

```sh
docker-compose up -d
```

If you need to **rebuild everything**:

```sh
docker-compose up -d --build
```

---

## **📂 Folder Structure**

```
.
├── ansible_playbooks/
│   ├── create_user.yml         # Ansible playbook to create 'demouser'
│   ├── inventory               # List of Ubuntu servers
├── dockerfiles/
│   ├── ansible.dockerfile      # Defines Ansible container
│   ├── ubuntu.dockerfile       # Defines Ubuntu container setup
├── executables/
│   ├── setup-ssh.sh            # Script to set up SSH keys
├── .ssh/                       # SSH keys (mounted to Ansible container)
├── docker-compose.yml          # Defines the multi-container setup
└── README.md                   # This guide
```

---

## **📌 Notes**

- The `ansible` user is used to manage Ubuntu servers with **passwordless sudo**.
- **SSH must be set up manually** using `setup-ssh.sh` before running playbooks.
- **All servers run on the same Docker network** (`ansible_network`) for easy communication.

---

## **📢 Contributing**

Feel free to open issues or submit PRs to improve this setup! 🎯

---

## **🧘 Author**

Created by **Ganesh NR** – because automation makes life easier! 🚀
