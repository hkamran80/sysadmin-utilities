#!/bin/bash

DISCORD_WEBHOOK_URL=
MESSAGE="Server is now online."

PAYLOAD="{\"content\": \"$MESSAGE\"}"

echo "[$(date)] Sending startup notification..." >> /var/log/system-notifications.log

curl -X POST -H "Content-Type: application/json" --data "$PAYLOAD" $DISCORD_WEBHOOK_URL

echo "[$(date)] Sent startup notification." >> /var/log/system-notifications.log
