#!/bin/bash
# Test if all files listed in profiledef.sh exist in airootfs/

AIROOTFS="chazos_profile/airootfs"
PROFILEDEF="chazos_profile/profiledef.sh"
FAILED=0

# Extract paths from profiledef.sh
paths=$(grep -oP '\["\K[^"]+' "$PROFILEDEF")

for p in $paths; do
    if [ ! -e "$AIROOTFS$p" ]; then
        echo "Missing: $AIROOTFS$p"
        FAILED=1
    else
        echo "Found: $AIROOTFS$p"
    fi
done

if [ $FAILED -eq 1 ]; then
    echo "Test Failed: Some files in profiledef.sh are missing from airootfs/."
    exit 1
else
    echo "Test Passed: All files in profiledef.sh found in airootfs/."
    exit 0
fi
