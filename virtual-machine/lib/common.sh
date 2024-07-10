#!/bin/bash

echo 'common.sh'

if [ -n "$1" ]; then
  CURRENT_DIR="$1"
  echo "CURRENT_DIR $1"
fi

if [ -n "$2" ]; then
  VMS_CONFIG="$2"
  echo "VMS_CONFIG $2"
fi

if [ -n "$3" ]; then
  ENVIRONMENT="$3"
  echo "ENVIRONMENT $3"
fi

if [ -n "$4" ]; then
  ACTION="$4"
  echo "ACTION $4"
fi

#ACTION="up"
MOUNTAING="true"
PROVISION="true"

# Crear un objeto JSON con jq
vm_args=$(jq -n \
--arg current_dir "$CURRENT_DIR" \
--arg vms_config "$VMS_CONFIG" \
--arg environment "$ENVIRONMENT" \
--arg action "$ACTION" \
--arg mountaing "$MOUNTAING" \
--arg provision "$PROVISION" \
    '{
    current_dir: $current_dir
    ,vms_config: $vms_config
    ,environment: $environment
    ,action: $action
    ,provision: $provision
    ,mountaing: $mountaing
    }'
)

# if [ "$FIRST_TIME" = "true" ]; then
#   #first time
#   ## mountaing false, provision true
#   vm_args=$(echo "$vm_args" | jq --arg new_provision "true" --arg new_mountaing "false" --arg new_action "up" \
#       '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
#   $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"
#   ## halt
#   vm_args=$(echo "$vm_args" | jq --arg new_provision "true" --arg new_mountaing "false" --arg new_action "halt" \
#       '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
#   $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"
#   ## mountaing true, provision false
#   vm_args=$(echo "$vm_args" | jq --arg new_provision "false" --arg new_mountaing "true" --arg new_action "up" \
#       '.provision = $new_provision | .mountaing = $new_mountaing | .action = $new_action')
#   $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"
# else
#   #second time always
#   $CURRENT_DIR/lib/vagrant-process.sh "$vm_args"
# fi

$CURRENT_DIR/lib/vagrant-process.sh "$vm_args"