#!/bin/bash
ssh-keygen

USER_T="paul"
HOST_APP="192.168.18.122"
HOST_INFRA="192.168.18.123"
HOST_DEPLOY="192.168.18.124"

ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_APP}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_INFRA}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${HOST_DEPLOY}

USER_T="paul"
HOST_APP="192.168.31.2"
HOST_INFRA="192.168.31.3"
HOST_DEPLOY="192.168.31.4"

ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${WORKSPACE}_${APP_HOST}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${WORKSPACE}_${INFRA_HOST}
ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${WORKSPACE}_${DEPLOY_HOST}



#PAUL-LAPTOP windows

#!/bin/bash

# Establece las variables de entorno para la sesión actual en Git Bash
export WORKSPACE="SANDBOX"
export USER_T="paul"
export APP_HOST="192.168.31.2"
export INFRA_HOST="192.168.31.3"
export DEPLOY_HOST="192.168.31.4"

# Muestra el valor de USER_T para verificar
echo $USER_T

# Ejecuta ssh-copy-id para cada host
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${APP_HOST}
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${INFRA_HOST}
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${DEPLOY_HOST}


# Establece las variables de entorno para la sesión actual en Git Bash
export WORKSPACE="W001"
export USER_T="paul"
export APP_HOST="192.168.10.16"
export INFRA_HOST="192.168.31.3"
export DEPLOY_HOST="192.168.31.4"

# Muestra el valor de USER_T para verificar
echo $USER_T

# Ejecuta ssh-copy-id para cada host
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${APP_HOST}
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${INFRA_HOST}
ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${DEPLOY_HOST}