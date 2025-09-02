# Sysadmin Utilities

A set of utilities to help manage servers.

## Utilities

- Startup Notify: send a message when the server starts up to Discord

  Requires: a [Discord webhook](https://support.discord.com/hc/articles/228383668) URL

- Shutdown Notify: send a message when the server shuts down to Discord

  Requires: a [Discord webhook](https://support.discord.com/hc/articles/228383668) URL

## Installation

1. Clone this repository

  ```bash
git clone <https://github.com/hkamran80/sysadmin-utilities>
cd sysadmin-utilities
  ```

2. Copy the `.service` files to the systemd folder

  ```bash
cp startup-notify/startup-notify.service /etc/systemd/system/
cp shutdown-notify/shutdown-notify.service /etc/systemd/system/
  ```

3. Make the scripts executable

  ```bash
chmod +x startup-notify/startup-notify.sh
chmod +x shutdown-notify/shutdown-notify.sh
  ```

4. Update the unit files to use the correct path

   The unit files ship with `/home/$USER/sysadmin-utilities/` as their base path which needs to be
   changed to the path where the scripts are before starting.

5. Enable and start the services

  ```bash
sudo systemctl enable startup-notify.service
sudo systemctl enable shutdown-notify.service
sudo systemctl start startup-notify.service
sudo systemctl start shutdown-notify.service
  ```
