#!/bin/bash

SCRIPT_PATH=$(cd "$(dirname "$0")"; pwd -P)/$(basename "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_PATH")

echo "La ruta del script es: $SCRIPT_PATH"
echo "El directorio del script es: $SCRIPT_DIR"

OS="linux"
# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$5" ]; then
  # Si $1 tiene algún valor, cambia al directorio indicado por $1
  OS=$5
  echo "OS $5"
fi

PLACE="home"
# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$1" ]; then
  # Si $1 tiene algún valor, cambia al directorio indicado por $1
  PLACE=$1
  echo "PLACE $1"
fi

echo "${SCRIPT_DIR}/${PLACE}/${OS}/available_ips.sh"
source ${SCRIPT_DIR}/${PLACE}/${OS}/available_ips.sh

# Verifica si $2 no está vacío para path del archivo vagrantfile
if [ -n "$2" ]; then
  # Si $2 tiene algún valor, cambia al directorio indicado por $2
  cd "$2"
  echo "Cambiado al directorio $2"
fi

GROUP="SANDBOX"
# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$3" ]; then 
  GROUP="$3"
  echo "GROUP $3"
fi


index=0
SCRIPT_INITIAL="sandbox_script.sh"
case $GROUP in
  SANDBOX)
    echo "El valor es SANDBOX. Aquí va el tratamiento específico para SANDBOX."
    index=0
    SCRIPT_INITIAL="sandbox_script.sh"
    ;;
  TRAIN)
    echo "El valor es TRAIN. Aquí va el tratamiento específico para TRAIN."
    index=3
    SCRIPT_INITIAL="train_script.sh"
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


OPERATION=up
# Verifica si $4 no está vacío para path del archivo vagrantfile
if [ -n "$4" ]; then
  OPERATION="$4"
  echo "PROCESANDO $4"
fi


SKIP_SH_SCRIPTS=false
# Comprueba si $4 es 'reload --provision'
if [ "$4" == "reload --provision" ]; then
  SKIP_SH_SCRIPTS=true
  echo "SKIP_SH_SCRIPTS establecido a true"
else
  # Aquí puedes agregar lo que quieras que ocurra si $4 no es 'reload --provision'
  echo "SKIP_SH_SCRIPTS establecido a false"
  # Por ejemplo, podrías dejar SKIP_SH_SCRIPTS en su valor predeterminado de false o asignarle otro valor
fi

# Ahora puedes usar las variables en tu comando
IP_APP=$IP_APP IP_INFRA=$IP_INFRA IP_DEPLOY=$IP_DEPLOY GROUP=$GROUP INTERFACE_NET="Realtek 8852CE WiFi 6E PCI-E NIC" SCRIPT_INITIAL=sandbox_script.sh SKIP_SH_SCRIPTS=$SKIP_SH_SCRIPTS vagrant $OPERATION

