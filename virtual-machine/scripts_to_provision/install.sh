#!/bin/bash

# Definir variables
USERNAME="paul"
DISTRO="DEBIAN"
EMAIL="paul.gualambo@gmail.com"
PASSWORD="P@ul1984"

# Imprimir el nombre de usuario para verificar
echo "Ejecutando scripts como el usuario: $USERNAME"

# Ejecutar el primer script para crear un usuario
wget -O - https://raw.githubusercontent.com/paulgualambo/env-tools/main/linux/config_create_user.sh | bash -s -- "$DISTRO" "$USERNAME" "$EMAIL" "$PASSWORD"

# Ejecutar el segundo script para instalar software de desarrollo
wget -O - https://raw.githubusercontent.com/paulgualambo/infrastructure-tools/main/linux/config_install_software_dev.sh | bash -s -- "$USERNAME"

echo "Scripts ejecutados correctamente."

# copiar scripts
echo "COPIAR SCRIPTS"
sudo mkdir -p /home/$USERNAME/config_vm
sudo cp -R /vagrant/scripts_to_provision/* /home/$USERNAME/config_vm/
sudo chown -R $USERNAME:$USERNAME /home/$USERNAME/config_vm/
sudo chmod 755 -R /home/$USERNAME/config_vm/*.sh


echo "Scripts copiados correctamente."