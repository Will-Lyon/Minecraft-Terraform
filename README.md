# Course Project Part 2: Automated Minecraft Server

## Prerequisits
- Ansible
- ASW account with cli & credentials
- AWS CLI
- Terraform
- nmap (for testing) 

## Steps
Note: This project was done on Ubuntu Linux. Commands may varry with a different OS

#### 1: Configure credentials
- This project uses a credentials file that must be filled in.
- First, Go to the AWS academy Canvas page and navigate to 'modules'
- In the top right, click 'AWS details', then click the 'show' button next to 'ASW CLI:'
- You will see an access key id, a secret acceess key, and a session token. Replace each CHANGE_ME in the credentials file with the correct value.
- Lastly, line 14 of main.tf specifies the path to the credentials file. replace the CHANGE_ME with your path to the credentials file for this project.

#### 2: Ensure tools are downloaded on your local machine
- The commands required to downoad these tools may vary from OS to OS:
- Terraform:
    - #Install dependencies:
    - sudo apt update 
    - sudo apt install  software-properties-common gnupg2 curl
    - #Import GPG key:
    - curl https://apt.releases.hashicorp.com/gpg | gpg --dearmor > hashicorp.gpg
    - sudo install -o root -g root -m 644 hashicorp.gpg /etc/apt/trusted.gpg.d/
    - #Add Hashicorp repo to your Ubuntu
    - sudo apt-add-repository "deb [arch=$(dpkg --print-architecture)] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
    - #Install Terraform & confirm installation
    - sudo apt install terraform
    - terraform --version
- ASW CLI:
    - curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    - unzip awscliv2.zip
    - sudo ./aws/install
- nmap
    - sudo apt-get update
    - sudo apt-get install nmap

#### 3: Build and launch the EC2 instance and Minecraft server
- Terraform will handle the setup of the instance, simply run the following commands:
- terraform init
- terraform apply
    - You will need to enter 'yes' when prompted to complete this command
    - Once this command has finished running, it will output the public IP of the newly created EC2 instance
- Next, the minecraft server. Start it with the ansible setup script with the following command, replacing "EC2_IP" with the IP output by terraform: 
- ansible-playbook -i EC2_IP, setup.yml
    - Do not forget the comma after the ip address
    - This setup script will print the status of the server to the console when it finishes.

#### 4: Connect to the server
- You can connect to the server by logging in, or by using the following nmap command
- nmap -sV -Pn -p T:25565 EC2_IP


## Rescources
- ChatGPT - https://chatgpt.com/?model=auto
- Amazon EC2 Minecraft server guide - https://aws.amazon.com/blogs/gametech/setting-up-a-minecraft-java-server-on-amazon-ec2/
- Installing ASW CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
- Installing Terraform - https://computingforgeeks.com/how-to-install-terraform-on-ubuntu/
- Terraform Guide - https://developer.hashicorp.com/terraform/tutorials/aws-get-started