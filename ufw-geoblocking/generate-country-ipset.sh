#!/bin/bash
# Original source: https://blog.miragewebstudio.com/2025/08/03/how-to-block-all-ips-from-a-specific-country/
# Usage: ./generate-country-ipset.sh [ISO-3166-1 alpha-2 country code]

# --- Configuration ---
# The ISO-3166-1 alpha-2 code
COUNTRY=$1
# The name for our ipset
IPSET_NAME="gb-country-$COUNTRY"
# The URL to the IP list from ipdeny.com
IP_LIST_URL="https://www.ipdeny.com/ipblocks/data/countries/$COUNTRY.zone"
# Temporary file to store the downloaded list
TEMP_FILE="/tmp/${IPSET_NAME}.zone"
# Folder to write ipset save files to
IPSET_DIR="/var/lib/ipset"
# --- End Configuration ---

# Check if a set with the same name already exists and destroy it
if sudo ipset -t list | grep -q "${IPSET_NAME}"; then
    echo "Destroying old ipset '${IPSET_NAME}'..."
    sudo ipset destroy "${IPSET_NAME}"
fi

# Create a new ipset with the specified name
echo "Creating new ipset '${IPSET_NAME}'..."
sudo ipset create "${IPSET_NAME}" hash:net

# Download the latest IP list
echo "Downloading IP list from ${IP_LIST_URL}..."
wget -O "$TEMP_FILE" "$IP_LIST_URL"

# Check if download was successful
if [ ! -f "$TEMP_FILE" ]; then
    echo "Failed to download IP list. Exiting."
    exit 1
fi

# Add each IP address from the list to the ipset
echo "Adding IP ranges to '${IPSET_NAME}'..."
while read ip; do
    sudo ipset add "${IPSET_NAME}" "$ip"
done < "$TEMP_FILE"

# Clean up the temporary file
rm "$TEMP_FILE"

sudo ipset save "$IPSET_NAME" | sudo tee "$IPSET_DIR/$IPSET_NAME.save" >/dev/null

echo "IP set '${IPSET_NAME}' created and populated successfully."
