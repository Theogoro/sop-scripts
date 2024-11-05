#!/bin/bash

# Función para mostrar mensajes de error en rojo
mostrar_error() {
    echo -e "\e[31m$1\e[0m"
}

usuario_existe() {
    id "$1" &> /dev/null
}

crear_usuario() {
    read -p "Ingrese el nombre del nuevo usuario: " nombre_usuario
    if usuario_existe "$nombre_usuario"
    then
        mostrar_error "El usuario $nombre_usuario ya existe."
    else
        if sudo useradd -m -s /usr/bin/top "$nombre_usuario"; then
            echo "Usuario $nombre_usuario creado con éxito."
        else
            mostrar_error "Error al crear el usuario $nombre_usuario."
        fi
    fi
}

fecha() {
    date +"%Y-%m-%d_%H-%M"
}

# Función para generar un archivo de reporte de memoria en el home del usuario
reporte_memoria() {
    read -p "Ingrese el nombre del usuario: " nombre_usuario
    if usuario_existe "$nombre_usuario"
    then
        user_dir="/home/$nombre_usuario"
        filename="$user_dir/reporte_memoria_$(fecha).txt"

        sudo chown $(whoami) "$user_dir"
        if free -h > "$filename"; then
            echo "Reporte de memoria generado en $filename"
        else
            mostrar_error "Se produjo un error intentando crear el archivo."
        fi
        sudo chown "$nombre_usuario" "$user_dir"
    else
        mostrar_error "El usuario $nombre_usuario no existe."
    fi
}

while true; do
    echo "-----Menu-----"
    echo "a>> Crear un nuevo usuario con programa inicial top"
    echo "b>> Generar un archivo de memoria en el home de un usuario"
    echo "q>> Salir"
    read -p "Opción>> " opcion

    case $opcion in
        a) crear_usuario ;;
        b) reporte_memoria ;;
        q) 
            echo "Saliendo"
            exit 
        ;;
        *) mostrar_error "Opción no válida, intente nuevamente." ;;
    esac

    echo
done
