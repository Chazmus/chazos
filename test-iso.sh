#!/bin/bash
export PATH="$(pwd)/bin:$PATH"
ISO_FILE=$(ls -t out/*.iso 2>/dev/null | head -n 1)
if [ -z "$ISO_FILE" ]; then
    echo "Error: No ISO found in out/ directory."
    exit 1
fi
echo "Launching $ISO_FILE in QEMU (logs to serial-boot.log)..."
QEMU_DISPLAY=gtk run_archiso -u -i "$ISO_FILE"
