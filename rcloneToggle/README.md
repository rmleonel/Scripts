📌 Script rclone_toggle.sh

📂 Ubicación: /home/sagh4/rclone_toggle.sh
✔️ Función:

    Si Rclone está montado, lo desmonta y guarda "OFF" en /tmp/rclone_state.
    Si Rclone no está montado, lo monta en segundo plano y guarda "ON".
    Permite activar o desactivar Rclone manualmente según sea necesario.

✏️ Ejecutar manualmente:

/home/sagh4/rclone_toggle.sh

📌 Servicio rclone_restore.service

📂 Ubicación: /etc/systemd/system/rclone_restore.service
✔️ Función:

    En cada arranque, revisa si el archivo /tmp/rclone_state dice "ON".
    Si estaba activado antes de apagar, ejecuta el script para volver a montarlo.
    Evita que Rclone arranque automáticamente si lo habías desactivado antes de apagar.

✏️ Activar el servicio para que se ejecute al iniciar:

sudo systemctl daemon-reload
sudo systemctl enable rclone_restore.service

✏️ Si alguna vez quieres desactivar el servicio de restauración:

sudo systemctl disable rclone_restore.service

🚀 ¿Cómo usar todo esto?

1️⃣ Ejecuta /home/sagh4/rclone_toggle.sh para activar o desactivar Rclone manualmente.
2️⃣ Si lo dejaste activado antes de apagar, se montará automáticamente en el próximo arranque.
3️⃣ Si lo desactivaste antes de apagar, no se iniciará automáticamente.

