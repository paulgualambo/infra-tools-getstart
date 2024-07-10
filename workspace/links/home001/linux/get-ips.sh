#!/bin/bash

# Guardar el directorio actual
CURRENT_DIR=$(pwd)
echo "Directorio actual: $CURRENT_DIR"

# Ejecutar otro script de shell, asumiendo que está en la ruta relativa correcta
"$CURRENT_DIR/../../get-ips.sh" 'home001' 'linux' 100