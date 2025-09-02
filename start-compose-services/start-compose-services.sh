#!/bin/bash

DISCORD_WEBHOOK_URL=

COLOUR_GREEN='\033[0;32m'
COLOUR_YELLOW='\033[1;33m'
COLOUR_RED='\033[0;31m'
COLOUR_CYAN='\033[0;36m'
COLOUR_RESET='\033[0m'

# List of directories containing Docker Compose projects, one on each line
compose_dirs=(
    ""
)

if [[ -n $DISCORD_WEBHOOK_URL ]]; then
    curl --silent -X POST -H "Content-Type: application/json" -d '{"content": "Starting Docker Compose services."}' $DISCORD_WEBHOOK_URL
fi

for dir in "${compose_dirs[@]}"; do
  echo -e "${COLOUR_CYAN}Starting services in ${dir}${COLOUR_RESET}"

  if [ -d "$dir" ]; then
    docker compose --project-directory "$dir" up -d
    if [ $? -eq 0 ]; then
      echo -e "  ${COLOUR_GREEN}Started successfully${COLOUR_RESET}"
    else
      echo -e "  ${COLOUR_RED}Failed to start${COLOUR_RESET}"
    fi
  else
    echo -e "  ${COLOUR_YELLOW}Directory not found${COLOUR_RESET}"
  fi

  echo -e "--------------------------------------"
done

if [[ -n $DISCORD_WEBHOOK_URL ]]; then
    curl --silent -X POST -H "Content-Type: application/json" -d '{"content": "Docker Compose services are now online."}' $DISCORD_WEBHOOK_URL
fi
