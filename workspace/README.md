# vagrant

nmap -sn 192.168.18.0/24

PC

```sh PC
#SANDBOX
IP_APP="192.168.18.141" IP_INFRA="192.168.18.142" IP_DEPLOY="192.168.18.143" GROUP="SANDBOX" INTERFACE_NET="enp0s31f6" SCRIPT_INITIAL="sandbox_script.sh" vagrant up
IP_APP="192.168.18.141" IP_INFRA="192.168.18.142" IP_DEPLOY="192.168.18.143" GROUP="SANDBOX" INTERFACE_NET="enp0s31f6"  SCRIPT_INITIAL="sandbox_script.sh" vagrant reload --provision
IP_APP="192.168.18.141" IP_INFRA="192.168.18.142" IP_DEPLOY="192.168.18.143" GROUP="SANDBOX" INTERFACE_NET="enp0s31f6" vagrant destroy

#TRAINING
IP_APP="192.168.18.125" IP_INFRA="192.168.18.126" IP_DEPLOY="192.168.18.127" GROUP="TRAINING" INTERFACE_NET="enp0s31f6" vagrant up
IP_APP="192.168.18.125" IP_INFRA="192.168.18.126" IP_DEPLOY="192.168.18.127" GROUP="TRAINING" INTERFACE_NET="enp0s31f6" vagrant reload --provision
IP_APP="192.168.18.125" IP_INFRA="192.168.18.126" IP_DEPLOY="192.168.18.127" GROUP="TRAINING" INTERFACE_NET="enp0s31f6" vagrant destroy

#W001
IP_APP="192.168.18.122" IP_INFRA="192.168.18.123" IP_DEPLOY="192.168.18.124" GROUP="W001" INTERFACE_NET="enp0s31f6" vagrant up
IP_APP="192.168.18.122" IP_INFRA="192.168.18.123" IP_DEPLOY="192.168.18.124" GROUP="W001" INTERFACE_NET="enp0s31f6" vagrant reload --provision
IP_APP="192.168.18.122" IP_INFRA="192.168.18.123" IP_DEPLOY="192.168.18.124" GROUP="W001" INTERFACE_NET="enp0s31f6" vagrant destroy

#W002
IP_APP="192.168.18.131" IP_INFRA="192.168.18.132" IP_DEPLOY="192.168.18.133" GROUP="W002" INTERFACE_NET="enp0s31f6" vagrant up
IP_APP="192.168.18.131" IP_INFRA="192.168.18.132" IP_DEPLOY="192.168.18.133" GROUP="W002" INTERFACE_NET="enp0s31f6" vagrant reload --provision
IP_APP="192.168.18.131" IP_INFRA="192.168.18.132" IP_DEPLOY="192.168.18.133" GROUP="W002" INTERFACE_NET="enp0s31f6" vagrant destroy
```

Crear accesos directos

```sh
cd ~
touch workspace.w001.desktop
chmod +x workspace.w001.desktop
chmod +x /home/paul/Documentos/projects/infra-tools-getstart/workspace/script_sandbox_manage.sh

# [Desktop Entry]
# Version=1.0
# Type=Application
# Name=Visual Studio Code
# Exec=/usr/bin/code
# Icon=code
# Terminal=false

cp /home/paul/Documentos/projects/infra-tools-getstart/workspace/links/workspace.sandbox.desktop ~/Desktop/workspace.sandbox.desktop

```