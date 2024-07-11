# infra-tools-getstart

```sh

#UBUNTU

##chrome
sudo apt update
sudo apt install -y wget curl gnupg ca-certificates
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt update
sudo apt install google-chrome-stable

##visual code
sudo apt update
sudo apt install software-properties-common apt-transport-https wget -y
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code

##git
sudo apt update
sudo apt install git -y
git --version

#VIRTUAL BOX
sudo apt-get update
sudo apt-get install virtualbox
VBoxManage --version

#VAGRANT
sudo apt-get update
sudo apt-get install vagrant

sudo apt autoremove -y

#en vagrant instalar este plugin para no tener conflictos con el mountaing y el provision
vagrant plugin install vagrant-vbguest
```
