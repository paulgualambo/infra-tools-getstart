#!/bin/bash

cd $1
USER_T="paul"

ENVIRONMENT="SANDBOX"
if [ -n "$2" ]; then 
  ENVIRONMENT="$2"
  echo "ENVIRONMENT $2"
fi

OPERATION="up"
if [ -n "$3" ]; then 
  OPERATION="$3"
  echo "OPERATION $3"
fi

USER="paul"
if [ -n "$4" ]; then 
  USER="$4"
  echo "USER $4"
fi

MOUNTAING="true"
if [ -n "$5" ]; then 
  MOUNTAING="$5"
  echo "MOUNTAING $5"
fi

IP_START=10
IP_BASE="192.168.56"

declare -A tratamientos

# Definir los tratamientos específicos para cada entorno
tratamientos=(
  ["SANDBOX"]="10;El valor es SANDBOX. Aquí va el tratamiento específico para SANDBOX."
  ["STUDY"]="20;El valor es STUDY. Aquí va el tratamiento específico para STUDY ."
  ["W001"]="30;El valor es W001. Aquí va el tratamiento específico para W001."
  ["W002"]="40;El valor es W002. Aquí va el tratamiento específico para W002."
)

IP_BASE="192.168.56"
ENVIRONMENT=${ENVIRONMENT:-SANDBOX}

if [[ -v tratamientos[$ENVIRONMENT] ]]; then
  # Extraer IP_START y mensaje
  IP_START=$(echo ${tratamientos[$ENVIRONMENT]} | cut -d ';' -f 1)
  MENSAJE=$(echo ${tratamientos[$ENVIRONMENT]} | cut -d ';' -f 2-)
  echo $MENSAJE
else
  echo "El valor $ENVIRONMENT no es uno de los especificados."
  exit 1
fi

SHARED_FOLDER="/home/paul/environment/"

ENVIRONMENT=$ENVIRONMENT IP_START=$IP_START IP_BASE=$IP_BASE SHARED_FOLDER=$SHARED_FOLDER USER=$USER MOUNTAING=$MOUNTAING vagrant $OPERATION

echo "ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${IP_BASE}.${IP_START} #APP"
echo "ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${IP_BASE}.$((IP_START+2)) #INFRA"
echo "ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${IP_BASE}.$((IP_START+4)) #DEPLOY"

echo "ssh ${USER_T}@${IP_BASE}.${IP_START} #APP"
echo "ssh ${USER_T}@${IP_BASE}.$((IP_START+2)) #INFRA"
echo "ssh ${USER_T}@${IP_BASE}.$((IP_START+4)) #DEPLOY"