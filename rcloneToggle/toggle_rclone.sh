#!/bin/bash

MOUNT_POINT="/home/sagh4/Google-Drive"
RCLONE_CMD="rclone mount MyDrive: $MOUNT_POINT --config /home/sagh4/.config/rclone/rclone.conf"
STATE_FILE="/tmp/rclone_state"  # Archivo para recordar estado

# Comprobar si está montado
if mount | grep -q "$MOUNT_POINT"; then
    echo "🛑 Desmontando Google Drive..."
    fusermount -u "$MOUNT_POINT" || umount -l "$MOUNT_POINT"
    echo "✅ Desmontado."
    echo "OFF" > "$STATE_FILE"  # Guardar estado
else
    echo "🚀 Montando Google Drive..."
    nohup $RCLONE_CMD > /dev/null 2>&1 &
    echo "✅ Montado en $MOUNT_POINT"
    echo "ON" > "$STATE_FILE"  # Guardar estado
fi
