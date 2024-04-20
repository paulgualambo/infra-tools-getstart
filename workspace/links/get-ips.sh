#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Obtener la dirección IP
    ip_address=$(ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d/ -f1 | head -n 1)
    gateway_address=$(ip route | grep default | awk '{print $3}')


    cidr=$(ip -4 -o addr show dev enp0s31f6 | awk '{split($4,a,"/"); print a[2]}')

    # Convertir CIDR a máscara de subred
    mask=""
    for ((i=1; i<=32; i++)); do
        if [[ $i -le $cidr ]]; then
            mask+="1"
        else
            mask+="0"
        fi

        if [[ $((i % 8)) -eq 0 && $i -ne 32 ]]; then
            mask+="."
        fi
    done

    # Convertir la cadena binaria a decimal y guardar en una variable
    subnet_mask=""
    IFS='.' read -ra ADDR <<< "$mask"
    for i in "${ADDR[@]}"; do
        subnet_mask+=$(printf "%d." $((2#${i})))
    done
    subnet_mask=${subnet_mask%?} # Remover el último punto

    # Aquí tienes la máscara de subred guardada en la variable 'subnet_mask'
    echo "La máscara de subred es: $subnet_mask"

    echo 'LINUX'
elif [[ "$OSTYPE" == "msys"* || "$OSTYPE" == "win32" ]]; then
    # Comandos para Windows
    ip_address=$(ipconfig | grep "IPv4 Address" | awk '{print $NF}' | head -n 1)
    subnet_mask=$(ipconfig | grep "Subnet Mask" | awk '{print $NF}' | head -n 1)
    gateway_address=$(ipconfig | grep -A 4 "IPv4 Address" | grep "Default Gateway" | awk '{print $NF}' | grep -v '^$')
    echo 'WINDOWS'
fi

# Imprimir los valores
echo "IP Address: $ip_address"
echo "Subnet Mask: $subnet_mask"
echo "Gateway Address: $gateway_address"

IFS='.' read -r -a ip_parts <<< "$ip_address"
IFS='.' read -r -a mask_parts <<< "$subnet_mask"
network_address=""
for ((i=0; i<4; i++)); do
    network_octet=$(( ${ip_parts[i]} & ${mask_parts[i]} ))
    network_address+="$network_octet."
done
network_address="${network_address%?}"

popcount() {
    local -i x=$1 count
    for ((count = 0; x; count++)); do
        ((x &= x - 1))
    done
    echo $count
}

subnet_prefix=0
for octet in "${mask_parts[@]}"; do
    subnet_prefix=$(($subnet_prefix + $(popcount $octet)))
done

num_addresses=$(( 2 ** (32 - subnet_prefix) - 2 ))
network_base=$(echo "$network_address" | awk -F '.' '{print $1"."$2"."$3"."}')
network_end=$(($num_addresses + 1))

available_ips=0

OS='linux'
PLACE="office001"
NETWORK_START_=10
# Verifica si $1 no está vacío para path del archivo vagrantfile

if [ -n "$1" ]; then
  PLACE="$1"
  echo "PLACE $1"
fi

if [ -n "$2" ]; then
  OS="$2"
  echo "OS $2"
fi

if [ -n "$3" ]; then
  NETWORK_START_="$3"
  echo "OS $3"
fi

network_start=NETWORK_START_

output_file="../../${PLACE}/${OS}/available_ips.sh"
> "$output_file"  # Limpia o crea el archivo de salida

echo "#!/bin/bash"  >> "$output_file"
echo ""  >> "$output_file"
echo "export IPS=()"  >> "$output_file"

echo "Buscando direcciones IP disponibles en la red $network_address/$subnet_prefix:"
for ((i=$network_start; i<=$network_end && available_ips < 12; i++)); do
    ip_to_check="${network_base}${i}"
    if [[ "$ip_to_check" == "$gateway_address" ]]; then
        continue  # Omitir el gateway
    fi

    ping -c 1 -w 1 $ip_to_check &> /dev/null

    if [ $? -ne 0 ]; then
        echo "La dirección IP $ip_to_check está libre."
        available_ips=$((available_ips + 1))
        #echo "IP$available_ips=\"$ip_to_check\"" >> "$output_file"
        echo "IPS+=(\"$ip_to_check\")" >> "$output_file"
    fi
done

echo "Se encontraron $available_ips direcciones IP disponibles."
