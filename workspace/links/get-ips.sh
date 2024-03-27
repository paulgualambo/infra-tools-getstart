#!/bin/bash

ip_address=$(ipconfig | grep "IPv4 Address" | awk '{print $NF}' | head -n 1)
subnet_mask=$(ipconfig | grep "Subnet Mask" | awk '{print $NF}' | head -n 1)
gateway_address=$(ipconfig | grep -A 4 "IPv4 Address" | grep "Default Gateway" | awk '{print $NF}' | grep -v '^$')


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
network_start=10
network_end=$(($num_addresses + 1))

available_ips=0

PLACE="office001"
# Verifica si $1 no está vacío para path del archivo vagrantfile
if [ -n "$1" ]; then
  PLACE="$1"
  echo "PLACE $1"
fi

output_file="../${PLACE}/available_ips.sh"
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
