#!/bin/bash

DISCORD_WEBHOOK_URL=
MESSAGE="Server is shutting down."

PAYLOAD="{\"content\": \"$MESSAGE\"}"

echo "[$(date)] Sending shutdown notification..." >> /var/log/system-notifications.log

curl -X POST -H "Content-Type: application/json" --data "$PAYLOAD" $DISCORD_WEBHOOK_URL

echo "[$(date)] Sent shutdown notification." >> /var/log/system-notifications.log

