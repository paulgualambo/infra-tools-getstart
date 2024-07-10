#!/bin/bash
CURRENT_DIR='/home/paul/Documents/projects/infra-tools-getstart/virtual-machine'
ENVIRONMENT="SANDBOX"
USER_T="paul"

# Crear un objeto JSON con jq
json=$(jq -n \
  --arg current_dir "$CURRENT_DIR" \
  --arg environment "$ENVIRONMENT" \
  --arg user_t "$USER_T" \
  '{current_dir: $current_dir, environment: $environment, user_t: $user_t}')

# Imprimir el JSON
echo "$json"

# Usar jq para extraer valores del JSON
_current_dir=$(echo "$json" | jq -r '.current_dir')
_environment=$(echo "$json" | jq -r '.environment')
_user_t=$(echo "$json" | jq -r '.user_t')

# Imprimir los valores
echo "Current Directory: $_current_dir"
echo "Environment: $_environment"
echo "User T: $_user_t"