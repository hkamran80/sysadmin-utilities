#!/bin/bash

echo "This script will attempt to set up all utilities."
echo "Additional setup may be required for webhooks, directories, and more."

sudo -v

utilities=(
    "startup-notify"
    "shutdown-notify"
    "start-compose-services"
)

for utility in "${utilities[@]}"; do
    echo "Setting up $utility..."

    sed "s:/home/\$USER/sysadmin-utilities:$(pwd):" "$utility/$utility.service" > "/etc/systemd/system/$utility.service"
    chmod +x "$utility/$utility.sh"

    sudo systemctl enable "$utility.service"

    echo "Set up complete."
done
