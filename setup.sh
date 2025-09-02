#!/bin/bash

echo "This script will attempt to set up all utilities."
echo "Additional setup may be required for webhooks, directories, and more."

utilities=(
    "startup-notify"
    "shutdown-notify"
    "start-compose-services"
)

for utility in "${utilities[@]}"; do
    echo "Setting up $utility..."

    sed "s:/home/\$USER/sysadmin-utilities:$(pwd):" "$dir/$dir.service" > "/etc/systemd/system/$dir.service"
    chmod +x "$dir/$dir.sh"

    sudo systemctl enable "$dir.service"

    echo "Set up complete."
done
