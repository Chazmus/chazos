#!/bin/bash
ISO_FILE=$(ls out/*.iso 2>/dev/null | head -n 1)
if [ -z "$ISO_FILE" ]; then
    echo "Error: No ISO found in out/ directory."
    exit 1
fi
echo "Launching $ISO_FILE in QEMU..."
run_archiso -u -i "$ISO_FILE"
