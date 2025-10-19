#!/bin/sh

IPSET_DIR="/var/lib/ipset"

# Check prerequisites
if [ ! -d "${IPSET_DIR}" ]; then
    echo "ERROR: ipset data directory does not exist: ${IPSET_DIR}" >&2
    return
fi

savefiles=$(find "$IPSET_DIR" -name "*.save")

for f in $savefiles; do
    listname=$(basename -s ".save" "$f")

    $(pwd)/generate-country-ipset.sh ${listname#gb-country-}
done
