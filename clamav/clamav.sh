#!/bin/bash

# Verificar el estado de ClamAV
if systemctl is-active --quiet clamav-daemon; then
    echo "⚠️ ClamAV está corriendo en segundo plano."
    echo "⏳ Deteniendo el servicio..."
    sudo systemctl stop clamav-daemon
    echo "✅ ClamAV ha sido detenido."
else
    echo "✅ ClamAV no está corriendo en segundo plano."
fi

# Mostrar menú al usuario
echo "--------------------------------"
echo "   🛡️  CLAMAV MANUAL SCANNER   "
echo "--------------------------------"
echo "1️⃣  Iniciar escaneo"
echo "2️⃣  Cancelar"
echo "--------------------------------"
read -p "Elige una opción (1/2): " opcion

if [[ "$opcion" == "1" ]]; then
    # Definir rutas
    LOG_FILE="$HOME/clamav_scan.log"
    SCAN_DIR="$HOME"  # Cambia esto por la carpeta a escanear

    echo "🔍 Iniciando escaneo en: $SCAN_DIR"
    echo "📝 Guardando resultados en: $LOG_FILE"

    # Ejecutar escaneo manualmente sin daemon
    clamscan -r --infected --bell --log="$LOG_FILE" "$SCAN_DIR"

    echo "✅ Escaneo completado. Revisa el log en: $LOG_FILE"
elif [[ "$opcion" == "2" ]]; then
    echo "❌ Escaneo cancelado. Saliendo..."
    exit 0
else
    echo "⚠️ Opción inválida. Saliendo..."
    exit 1
fi
