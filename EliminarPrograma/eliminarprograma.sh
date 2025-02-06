#!/bin/bash

echo "=== Eliminador de Programas en Debian ==="

# Preguntar qué programa eliminar
read -p "Ingrese el nombre del programa a eliminar (o escriba 'cancelar' para salir): " programa

if [ "$programa" == "cancelar" ]; then
    echo "Operación cancelada."
    exit 0
fi

# Confirmar eliminación
read -p "¿Desea eliminar $programa? (s/n): " confirmacion
if [ "$confirmacion" != "s" ]; then
    echo "Operación cancelada."
    exit 0
fi

# Ejecutar la eliminación básica
echo "Eliminando $programa..."
sudo apt remove -y "$programa"

# Preguntar si desea eliminar configuración y dependencias
read -p "¿Desea eliminar también archivos de configuración y dependencias innecesarias? (s/n): " eliminar_conf
if [ "$eliminar_conf" == "s" ]; then
    sudo apt purge -y "$programa"
    sudo apt autoremove -y
    echo "Se eliminaron configuración y dependencias de $programa."
else
    echo "Configuración y dependencias no eliminadas."
fi

# Preguntar si desea eliminar archivos de configuración en home
read -p "¿Desea eliminar los archivos de configuración en su directorio personal? (~/.config, ~/.local, etc.) (s/n): " eliminar_archivos_conf
if [ "$eliminar_archivos_conf" == "s" ]; then
    rm -rf ~/.config/$programa ~/.local/share/$programa ~/.cache/$programa ~/.${programa}*
    echo "Archivos de configuración en home eliminados."
else
    echo "Archivos de configuración en home no eliminados."
fi

echo "Proceso completado."
