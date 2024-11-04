#!/bin/bash

show_error() {
    echo -e "\e[31m$1\e[0m"
}

while true 
do
	echo "-------"
	echo "1) Sistemas montados"
	echo "2) Muestre el archivo + pesado"
	echo "3) Muestre el espacio en disco"
	echo "4) Muestre los usuarios registrados"
	echo "6) RAM libre"
	echo "7) Acceso a internet"
	echo "8) Ultimo login"
	echo "9) Si soy sudo"
	echo "5) Salir"
	
	read -p "Ingrese su opción >> " opt
	
	echo "-------"
	
	case $opt in
		1)echo "$(df | cut -f 1 -d " " )";;
		2)echo "$(sudo find / -type f -exec du -h {} + | sort -rh | head -n 1)";;
		3)df -h;;
		4)
			echo "$(cat /etc/passwd | cut -d ':' -f 1)"
		;;
		5)exit;;
		6)
			echo "Disp			Free"
			echo "$(free -h | tail -n 2 | head -n 1 | column -t |tr "  " "\t"  | cut -f 3,5
)"	
		;;
		7)
			if ping -c 1 www.google.com > /dev/null
			then
				echo "Conexion a internet"
			else
				echo "Sin conexion a internet"
			fi
		;;
		8)
			echo "Ultimo acceso-> $(uptime -p -s)"
		;;
		9)
			is_root=$(groups | grep sudo | wc -l)
			if test $is_root -eq 1
			then
				echo "El usuario es sudo"
			else
				echo "El usuario no es sudo"
			fi
		;;
		*) show_error "Instrucción no encontrada";;
	esac

done

