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