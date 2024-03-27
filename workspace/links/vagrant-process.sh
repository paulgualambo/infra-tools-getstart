#!/bin/bash

SCRIPT_PATH=$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

echo "La ruta del script es: $SCRIPT_PATH"
echo "El directorio del script es: $SCRIPT_DIR"

PLACE="home"
# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$1" ]; then
  # Si $1 tiene algún valor, cambia al directorio indicado por $1
  PLACE=$1
  echo "PLACE $1"
fi

source ${SCRIPT_DIR}/${PLACE}/available_ips.sh

# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$2" ]; then
  # Si $1 tiene algún valor, cambia al directorio indicado por $1
  cd "$2"
  echo "Cambiado al directorio $2"
fi

index=0
SCRIPT_INITIAL="sandbox_script.sh"
GROUP="SANDBOX"

# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$3" ]; then 
  GROUP="$3"
  echo "GROUP $3"
fi

case $GROUP in
  SANDBOX)
    echo "El valor es SANDBOX. Aquí va el tratamiento específico para SANDBOX."
    index=0
    SCRIPT_INITIAL="sandbox_script.sh"
    ;;
  TRAINING)
    echo "El valor es TRAINING. Aquí va el tratamiento específico para TRAINING."
    index=3
    SCRIPT_INITIAL="training_script.sh"
    ;;    
  W001)
    echo "El valor es W001. Aquí va el tratamiento específico para W001."
    index=6
    SCRIPT_INITIAL="w001_script.sh"
    ;;
  W002)
    echo "El valor es W002. Aquí va el tratamiento específico para W002."
    index=9
    SCRIPT_INITIAL="w002_script.sh"
    ;;
  *)
    echo "El valor $valor no es uno de los especificados."
    # Opcional: Tratamiento para valores no especificados
    exit
    ;;
esac


IP_APP=${IPS[index]}
((index++))

IP_INFRA=${IPS[index]}
((index++))

IP_DEPLOY=${IPS[index]}
((index++))

echo "IP_APP ${IP_APP}" 
echo "IP_INFRA ${IP_INFRA}" 
echo "IP_DEPLOY ${IP_DEPLOY}" 

OPERATION=up

# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$4" ]; then
  OPERATION="$4"
  echo "PROCESANDO $4"
fi

# Ahora puedes usar las variables en tu comando
IP_APP=$IP_APP IP_INFRA=$IP_INFRA IP_DEPLOY=$IP_DEPLOY GROUP=$GROUP INTERFACE_NET="Realtek 8852CE WiFi 6E PCI-E NIC" SCRIPT_INITIAL=sandbox_script.sh vagrant $OPERATION

echo "Haciendo un delay de 30s."
sleep 30

echo "APP"
ping -n 4 $IP_APP

echo "INFRA"
ping -n 4 $IP_INFRA

echo "DEPLOY"
ping -n 4 $IP_DEPLOY