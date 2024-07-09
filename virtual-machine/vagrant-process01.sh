#!/bin/bash
echo "function vagrant-process"
# Leer el argumento JSON
json_string=$1

# Usar jq para extraer valores del JSON
current_dir=$(echo "$json_string" | jq -r '.current_dir')
prefijo_vm=$(echo "$json_string" | jq -r '.prefijo_vm')
environment=$(echo "$json_string" | jq -r '.environment')
action=$(echo "$json_string" | jq -r '.action')
mountaing=$(echo "$json_string" | jq -r '.mountaing')
provision=$(echo "$json_string" | jq -r '.provision')
username=$(echo "$json_string" | jq -r '.username')

# Imprimir los valores para verificar
echo "Current Directory: $current_dir"
echo "Prefijo VM: $prefijo_vm"
echo "Environment: $environment"
echo "Action: $action"
echo "Mountaing: $mountaing"
echo "Provision: $provision"
echo "Username: $username"

cd $current_dir

# Leer el archivo JSON
json_string=$(cat vms.json)

# Inicializar el array
vms=()

# Usar jq para extraer y procesar cada objeto en el array sandbox
while IFS= read -r line; do
  vms+=("$line")
done < <(echo "$json_string" | jq -c --arg environment "$environment" '.[$environment][] | select(.active == true) | 
    {
      hostname, 
      ip, 
      box_image, 
      username, 
      shared_folder_host,
      shared_folder_vm,
      script, 
      memory, 
      cpus,
      active
    }')

# Crear el JSON inicial usando jq
vms_config_json=$(jq -n \
  --argjson mountaing "$mountaing" \
  --argjson provision "$provision" \
  '{
    mountaing: $mountaing,
    provision: $provision,
    vms: []
  }')

# Agregar el nuevo VM al JSON
for vm in "${vms[@]}"; do
  vms_config_json=$(echo "$vms_config_json" | jq --argjson new_vm "$vm" '.vms += [$new_vm]')
done

vms_config=$vms_config_json vagrant $action

# echo "ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${IP_BASE}.${IP_START} #APP"
# echo "ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${IP_BASE}.$((IP_START+2)) #INFRA"
# echo "ssh-copy-id -i ~/.ssh/id_rsa.pub ${USER_T}@${IP_BASE}.$((IP_START+4)) #DEPLOY"

# echo "ssh ${USER_T}@${IP_BASE}.${IP_START} #APP"
# echo "ssh ${USER_T}@${IP_BASE}.$((IP_START+2)) #INFRA"
# echo "ssh ${USER_T}@${IP_BASE}.$((IP_START+4)) #DEPLOY"