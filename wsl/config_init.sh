sudo rm -rf ~/config_vm
cd ~
sudo mkdir -p ~/config_vm
cd ~/config_vm
sudo wget https://raw.githubusercontent.com/paulgualambo/vms-getstart/main/wsl/install.sh
sudo wget https://raw.githubusercontent.com/paulgualambo/vms-getstart/main/virtual-machine/scripts_to_provision/app.sh
sudo wget https://raw.githubusercontent.com/paulgualambo/vms-getstart/main/virtual-machine/scripts_to_provision/backup.sh
sudo wget https://raw.githubusercontent.com/paulgualambo/vms-getstart/main/virtual-machine/scripts_to_provision/deploy.sh
sudo wget https://raw.githubusercontent.com/paulgualambo/vms-getstart/main/virtual-machine/scripts_to_provision/infra.sh
sudo wget https://raw.githubusercontent.com/paulgualambo/vms-getstart/main/virtual-machine/scripts_to_provision/init.sh

sudo chmod 775 -R ~/config_vm

source ~/.bashrc