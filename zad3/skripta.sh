#!/bin/bash

input_file="prilog.txt"

while IFS= read -r file; do
    if [[ $file =~ ^k[0-9a-fA-F]{8}\.kod$ ]]; then #da li je dobar format
        touch "$file" # 1.
		
		name_number = "${file:1:8}" #od drugog do poslednjeg
		
		G = "${name_number:6:1}" #hex
		E = "${name_number:5:1}" #on ostaje u hex
		
		G_dec = $((16#$G)) #konverzija u decimalni, 16 - hex
		
		if (( G_dec % 2 == 0 )); then
			dir = "${G_dec}0/${E}0" #pravljenje dir po pravilu za parne
		else
			dir = "$((G_dec-1))0/${E}0" #... i neparne
		fi
		
		mkdir -p "$dir" #ukoliko dir postoji, zbog "-p" nece biti kreiran
		mv "$file" "$dir/"
    else
	    touch "$file" # 1.
        echo "Neispravan naziv fajla: $file" # 2.
    fi
done < "$input_file"
