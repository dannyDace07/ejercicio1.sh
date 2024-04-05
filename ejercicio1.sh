#!/bin/bash

# Pido el nombre del archivo
el_archivo=$1

# Si el archivo no existe, imprime un error y termina el script
if [[ ! -e $el_archivo ]]; then
    echo "Error: El archivo $el_archivo no existe en el sistema."
    exit 1
fi

# Uso el comando dado y con eso obtengo los permisos del archivo
permisos=$(stat -c "%A" "$el_archivo")

get_permissions_verbose() {
    permisos="$1"
    permi_usuario=${permisos:1:3}
    permi_grupo=${permisos:4:3}
    permi_usuarios=${permisos:7:3}

    interpretación() {
        permisos="$1"
        case "$permisos" in
           "r") echo "Lectura" ;;
           "w") echo "Escritura" ;;
           "x") echo "Ejecución" ;;
           *)   echo "Error" ;;
        esac
    }

    echo "Permisos para el usuario:"
    for ((i=0; i<3; i++)); do
        permisos=${permi_usuario:$i:1}
        echo "$(interpretación "$permisos")"
    done

    echo "Permisos para el grupo:"
    for ((i=0; i<3; i++)); do
        permisos=${permi_grupo:$i:1}
        echo "$(interpretación "$permisos")"
    done

    echo "Permisos para los usuarios:"
    for ((i=0; i<3; i++)); do
        permisos=${permi_usuarios:$i:1}
        echo "$(interpretación "$permisos")"
    done
}

get_permissions_verbose "$permisos"