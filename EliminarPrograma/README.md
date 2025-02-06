# Explicación del Script Eliminador de Programas en Debian

Este script en Bash facilita la eliminación de programas en sistemas basados en Debian, proporcionando opciones adicionales para eliminar configuraciones y dependencias innecesarias. También permite eliminar archivos de configuración del usuario.

## Funcionamiento
1. **Solicita el nombre del programa**: El usuario ingresa el nombre del paquete que desea eliminar.
2. **Opción de cancelación**: En cualquier momento, el usuario puede escribir "cancelar" para detener la ejecución.
3. **Confirma la eliminación**: Antes de proceder, el script solicita confirmación para evitar eliminaciones accidentales.
4. **Elimina el programa**: Ejecuta `apt remove` para desinstalar el paquete.
5. **Elimina configuración y dependencias (opcional)**: Si el usuario lo elige, ejecuta `apt purge` y `apt autoremove`.
6. **Elimina archivos de configuración en el directorio del usuario (opcional)**: Borra carpetas relacionadas en `~/.config/`, `~/.local/share/`, y `~/.cache/`.
7. **Finaliza mostrando un mensaje de confirmación**.

## Comandos principales utilizados
- `apt remove -y <paquete>`: Desinstala el programa sin eliminar configuraciones.
- `apt purge -y <paquete>`: Elimina el programa junto con su configuración del sistema.
- `apt autoremove -y`: Elimina dependencias innecesarias.
- `rm -rf ~/.config/<paquete> ~/.local/share/<paquete> ~/.cache/<paquete> ~/.<paquete>*`: Borra archivos de configuración en el directorio del usuario.

## Notas
- Si solo se usa `apt remove`, pueden quedar archivos de configuración y dependencias innecesarias.
- `apt purge` elimina configuraciones del sistema pero no las del usuario.
- Es recomendable revisar manualmente las carpetas de configuración si se desea una limpieza completa.

## Autor
Desarrollado por [Tu Nombre].


