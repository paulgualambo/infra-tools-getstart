#!/bin/bash

echo 'sandbox.sh'

if [ -n "$1" ]; then
  CURRENT_DIR="$1"
  echo "CURRENT_DIR $1"
fi

if [ -n "$2" ]; then
  PREFIJO_VM="$2"
  echo "PREFIJO_VM $2"
fi

if [ -n "$3" ]; then
  ENVIRONMENT="$3"
  echo "ENVIRONMENT $3"
fi

if [ -n "$4" ]; then
  FIRST_TIME="$4"
  echo "FIRST_TIME $4"
fi

if [ -n "$5" ]; then
  USERNAME="$5"
  echo "USERNAME $5"
fi

ACTION="up"
MOUNTAING="true"
PROVISION="false"

# Crear un objeto JSON con jq
vm_args=$(jq -n \
--arg current_dir "$CURRENT_DIR" \
--arg prefijo_vm "$PREFIJO_VM" \
--arg environment "$ENVIRONMENT" \
--arg action "$ACTION" \
--arg mountaing "$MOUNTAING" \
--arg provision "$PROVISION" \
--arg username "$USERNAME" \
    '{
    current_dir: $current_dir
    ,prefijo_vm: $prefijo_vm
    ,environment: $environment
    ,action: $action
    ,provision: $provision
    ,mountaing: $mountaing
    ,username: $username
    }'
)

#first time
## mountaing false, provision true
vm_args=$(echo "$vm_args" | jq --arg new_provision "true" --arg new_mountaing "false" --arg new_action "up" \
    '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
$CURRENT_DIR/vagrant-process.sh "$vm_args"
## halt
vm_args=$(echo "$vm_args" | jq --arg new_provision "true" --arg new_mountaing "false" --arg new_action "halt" \
    '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
$CURRENT_DIR/vagrant-process.sh "$vm_args"
## mountaing true, provision false
vm_args=$(echo "$vm_args" | jq --arg new_provision "false" --arg new_mountaing "true" --arg new_action "up" \
    '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
$CURRENT_DIR/vagrant-process.sh "$vm_args"

#second time always
#$CURRENT_DIR/vagrant-process.sh "$vm_args"