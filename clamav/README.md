# Explicación del Script de Escaneo Manual con ClamAV

Este script en Bash permite verificar el estado de ClamAV, detenerlo si está en ejecución y realizar un escaneo manual en una carpeta especificada. Además, guarda un registro del escaneo en un archivo de log.

## Funcionamiento

1. **Verificación del estado de ClamAV**
   - Se utiliza `systemctl is-active --quiet clamav-daemon` para comprobar si el servicio ClamAV está en ejecución.
   - Si el servicio está corriendo, lo detiene con `sudo systemctl stop clamav-daemon`.
   - Si no está corriendo, muestra un mensaje informativo.

2. **Menú de opciones**
   - Presenta un menú con dos opciones:
     1. Iniciar escaneo.
     2. Cancelar y salir.

3. **Ejecución del escaneo**
   - Si el usuario elige la opción 1, el script:
     - Define la carpeta a escanear (`SCAN_DIR`) y el archivo de log (`LOG_FILE`).
     - Muestra mensajes indicando la ruta de escaneo y el archivo donde se guardarán los resultados.
     - Ejecuta `clamscan` con las siguientes opciones:
       - `-r`: Escaneo recursivo.
       - `--infected`: Muestra solo los archivos infectados.
       - `--bell`: Activa una alerta sonora en caso de detectar virus.
       - `--log="$LOG_FILE"`: Guarda los resultados en un archivo de log.
     - Muestra un mensaje al finalizar el escaneo indicando la ubicación del log.

4. **Manejo de opciones inválidas**
   - Si el usuario elige la opción 2, el script cancela el escaneo y finaliza.
   - Si se ingresa una opción no válida, muestra un mensaje de error y termina la ejecución.

## Notas
- ClamAV debe estar instalado en el sistema para que este script funcione.
- Se recomienda ejecutar el script con privilegios de superusuario (`sudo`) para garantizar permisos adecuados.
- Es posible cambiar la carpeta de escaneo modificando la variable `SCAN_DIR`.
- El archivo de log se guardará en la carpeta del usuario (`$HOME`).

