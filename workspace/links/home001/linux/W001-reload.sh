#!/bin/bash
# Define el directorio actual
CURRENT_DIR=$(pwd)
echo "Directorio actual: $CURRENT_DIR"

"$CURRENT_DIR/../../vagrant-process.sh" 'home001' "$CURRENT_DIR/../../../virtual-machine" 'W001' 'reload --provision'