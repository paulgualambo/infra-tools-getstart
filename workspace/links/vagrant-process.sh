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

# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$4" ]; then
  OPERATION="$4"
  echo "PROCESANDO $4"
fi

SKIP_SH_SCRIPTS=false
# Comprueba si $4 es 'reload --provision'
if [ "$4" == "reload --provision" ]; then
  SKIP_SH_SCRIPTS=true
  echo "SKIP_SH_SCRIPTS establecido a true"
fi

# Ahora puedes usar las variables en tu comando
IP_APP=$IP_APP IP_INFRA=$IP_INFRA IP_DEPLOY=$IP_DEPLOY GROUP=$GROUP INTERFACE_NET="Realtek 8852CE WiFi 6E PCI-E NIC" SCRIPT_INITIAL=sandbox_script.sh SKIP_SH_SCRIPTS=$SKIP_SH_SCRIPTS vagrant $OPERATION

echo $GROUP
echo "IP_APP ${IP_APP}" 
echo "IP_INFRA ${IP_INFRA}" 
echo "IP_DEPLOY ${IP_DEPLOY}" 

# Crear un nuevo archivo y escribir en él
cd ${SCRIPT_DIR}
echo "IPS"  | tee 'ips_activos.txt'
echo ""  | tee -a 'ips_activos.txt'
echo $PLACE | tee -a 'ips_activos.txt'

GROUPS_=()
GROUPS_+=("SANDBOX")
GROUPS_+=("TRAIN")
GROUPS_+=("W001")
GROUPS_+=("W002")

SERVS_=()
SERVS_+=("APP")
SERVS_+=("INFRA")
SERVS_+=("DEPLOY")

index=0
index_serv=0
echo -e "GROUPS\tAPP\t\tINFRA\t\tDEPLOY" | tee -a 'ips_activos.txt'

SSHS=""
IPCONFIGS=""
GROUPS_ITEM=""
USER_T="paul"
# Recorrer la matriz y agrupar de 3 en 3
for (( i=0; i<${#IPS[@]}; i++ )); do

  SERVS_ITEM=${SERVS_[index_serv]}
  ((index_serv++))

  if (( (i) % 3 == 0 )); then
    GROUPS_ITEM=${GROUPS_[index]}
     SSHS+=${GROUPS_ITEM}"\n------\n"
    echo  -e -n ${GROUPS_[index]}"\t" | tee -a 'ips_activos.txt' # Esto imprime un salto de línea
    ((index++))
  fi

  # Imprimir la IP actual sin salto de línea al final
  echo -e -n "${IPS[$i]}\t"  | tee -a 'ips_activos.txt'
  IPCONFIGS+="\nHost "${PLACE}-${GROUPS_ITEM}-${SERVS_ITEM}"-${IPS[$i]}\n    HostName ${IPS[$i]}\n    User paul\n    ForwardAgent yes\n"
  SSHS+="ssh-copy-id -i ~/.ssh/id_ed25519.pub ${USER_T}@${IPS[$i]} #${SERVS_ITEM}\n"
  # Cada vez que el índice es un múltiplo de 3 (excepto cuando i=0),
  # imprimir un salto de línea para agrupar los elementos de 3 en 3
  if (( (i + 1) % 3 == 0 )); then
    index_serv=0
    SSHS+="\n------------\n\n"
    echo ""  | tee -a 'ips_activos.txt' # Esto imprime un salto de línea
  fi
done

echo -e ${IPCONFIGS}  | tee -a 'ips_activos.txt'
echo -e ${SSHS}  | tee -a 'ips_activos.txt'

if [ "$4" != "halt --force" ]; then
  echo "Haciendo un delay de 30s."
  sleep 30

  echo "APP"
  ping -n 4 $IP_APP
  echo "INFRA"
  ping -n 4 $IP_INFRA
  echo "DEPLOY"
  ping -n 4 $IP_DEPLOY
fi

read -p "Presiona enter para salir..."