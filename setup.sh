#!/bin/bash

echo "This script will attempt to set up all utilities."
echo "If you wish to only set up some, edit the 'utilities' array in 'setup.sh'."
echo "Additional setup may be required for webhooks, directories, and more. Sudo access is required to configure systemd."
echo
read -p "Press enter to continue."

sudo -v

echo

utilities=(
    "startup-notify"
    "shutdown-notify"
    "start-compose-services"
)

for utility in "${utilities[@]}"; do
    echo "Setting up $utility..."

    sed "s:/home/\$USER/sysadmin-utilities:$(pwd):" "$utility/$utility.service" | sudo tee "/etc/systemd/system/$utility.service" > /dev/null
    chmod +x "$utility/$utility.sh"

    sudo systemctl enable "$utility.service"

    echo "Set up complete."
done
