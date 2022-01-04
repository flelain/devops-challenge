# Ansible NGINX

## Technical context
Steps followed:
- spinning up of a VM (GCP Compute Engine), on Ubuntu 18.04
- installation of nginx
- opening of port 22/ssh from Cloud Shell to the VM (VPC firewall rule)
- opening of port 81 too (for tests purposes)

VM bash history:
```bash
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y nginx
sudo systemctl status nginx # To check nginx service is up and running
curl http://localhost # to check if nginx webserver responds to a basic request
```

Once the nginx server was up, I used GCP Cloud Shell as my Ansible control node to run the playbooks. Here's what I did, step by step:
On Cloud Shell:
```bash
sudo apt-get install -y ansible # Install Ansible on my control node
ansible --version # to check ansible is properly installed
git clone https://github.com/flelain/devops-challenge # Clone this repo to get the playbook and inventory
cd devops-challenge/ansible
ssh-keygen -t ed25519 -C "devops-challenge" # Generate a new SSH key, stored under ~/.ssh/nginx-server
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/nginx-server # Add SSH key to the control node agent
# Here I provided the public key (~/.ssh/nginx-server.pub) on the nginx server
ansible-playbook -i hosts deploy-vhost1.yaml # deploy vhost1
ansible-playbook -i hosts deploy-vhost2.yaml # deploy vhost2
```

## Bonus
I created a new Compute Engine instance, `live-probe-http`. I completed the setup with the adding up of the SSH key and I tested manually connectivity to the nginx server (`curl` on one of the vhost `index.html`). I finally amended my [`hosts`](ansible/hosts) file and wrote [`live-probe-http.yaml` playbook](ansible/live-probe-http.yaml).

## Discussion topics
We'd probably want to manage -at least- two distinct target environments here for our deployments: dev and production. We could separate and secure deployments to each of those environments from our git repo and CI/CD pipelines, where the targets would lie in two different branches, allowing to separate assets (code, variables, ...), to configure distinct access control (users, permisssions, ...) and to add guardrails for prod target (e.g.: some manual steps for prod VS fully automated actions for dev).

> Note: besides, in a real case, SSH keys would have to be different from one environment to another.