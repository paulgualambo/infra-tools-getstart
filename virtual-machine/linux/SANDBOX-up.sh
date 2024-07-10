#!/bin/bash

echo 'SANDBOX-UP.SH'

CURRENT_DIR="/home/paul/Documents/projects/infra-tools-getstart/virtual-machine"
PREFIJO_VM="paul-pc01-"
ENVIRONMENT="sandbox"
FIRST_TIME="false"
USERNAME="paul"

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
$CURRENT_DIR/vagrant-process01.sh "$vm_args"
## halt
vm_args=$(echo "$vm_args" | jq --arg new_provision "true" --arg new_mountaing "false" --arg new_action "halt" \
    '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
$CURRENT_DIR/vagrant-process01.sh "$vm_args"
## mountaing true, provision false
vm_args=$(echo "$vm_args" | jq --arg new_provision "false" --arg new_mountaing "true" --arg new_action "up" \
    '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
$CURRENT_DIR/vagrant-process01.sh "$vm_args"

#second time always
#$CURRENT_DIR/vagrant-process01.sh "$vm_args"