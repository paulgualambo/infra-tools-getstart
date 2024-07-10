#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Obtener la dirección IP
    ip_address=$(ip addr show | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d/ -f1 | head -n 1)
    gateway_address=$(ip route | grep default | awk '{print $3}')

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