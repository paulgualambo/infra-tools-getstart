#!/bin/bash

echo 'INSTALL app'
cd /home/vagrant/scripts_to_provision
./install.sh

#configure ssh
#ssh-keygen

#configure token

#configure node and npm
# Install nvm
#https://github.com/nvm-sh/nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # Carga nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # Carga la autocompletación de nvm si está presente


nvm --version
nvm ls-remote
nvm ls
nvm run node --version
nvm install --lts
nvm install-latest-npm
nvm cache clear

# create .nvmrc
# echo "lts/*" > .nvmrc # to default to the latest LTS version

npm install npm@latest -g
node -v
npm -v

# Install typescript
# Install TS globally on my machine
# npm i -D -g typescript@latest
# npm i -D -g @types/node ts-node@latest
# # Check version
# tsc -v

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

sudo apt update
sudo apt install yarn -y

yarn --version

#AWS
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo apt-get update
sudo apt-get install unzip -y
unzip awscliv2.zip
sudo ./aws/install
aws --version
