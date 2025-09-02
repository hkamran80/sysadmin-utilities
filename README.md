# Sysadmin Utilities

A set of utilities to help manage servers.

## Utilities

- Startup Notify: send a message when the server starts up to Discord

  Required: a [Discord webhook](https://support.discord.com/hc/articles/228383668) URL

- Shutdown Notify: send a message when the server shuts down to Discord

  Required: a [Discord webhook](https://support.discord.com/hc/articles/228383668) URL

- Start Compose Services: start Compose services after startup

  Optional: a [Discord webhook](https://support.discord.com/hc/articles/228383668) URL

## Installation

1. Clone this repository

  ```bash
git clone https://github.com/hkamran80/sysadmin-utilities
cd sysadmin-utilities
  ```

2. Run the setup script

  ```bash
./setup.sh
  ```

### Manual

1. Copy the unit files to the systemd folder

  ```bash
cp startup-notify/startup-notify.service /etc/systemd/system/
cp shutdown-notify/shutdown-notify.service /etc/systemd/system/
cp start-compose-services/start-compose-services.service /etc/systemd/system/
  ```

2. Make the scripts executable

  ```bash
chmod +x startup-notify/startup-notify.sh
chmod +x shutdown-notify/shutdown-notify.sh
chmod +x start-compose-services/start-compose-services.sh
  ```

3. Update the unit files to use the correct path

   The unit files ship with `/home/$USER/sysadmin-utilities/` as their base path which needs to be
   changed to the path where the scripts are before starting.

4. Enable and start the services

  ```bash
sudo systemctl enable startup-notify.service
sudo systemctl enable shutdown-notify.service
sudo systemctl enable start-compose-services.service
  ```

  ```bash
sudo systemctl start startup-notify.service
sudo systemctl start shutdown-notify.service
sudo systemctl start start-compose-services.service
  ```

  > [!NOTE]
  > Starting the start Compose services service initially may result in unexpected occurrences with
  > your containers. While not expected, it is better to use caution.
