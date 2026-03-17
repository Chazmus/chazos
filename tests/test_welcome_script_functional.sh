#!/usr/bin/env bash

# Test if chazos-welcome exists and outputs the banner.

SCRIPT_PATH="chazos_configs/bin/chazos-welcome"
BANNER_PATH="chazos_configs/assets/banner.txt"

if [ ! -f "$SCRIPT_PATH" ]; then
    echo "[FAIL] Welcome script NOT found at $SCRIPT_PATH."
    exit 1
fi

if [ ! -x "$SCRIPT_PATH" ]; then
    echo "[FAIL] Welcome script is NOT executable."
    exit 1
fi

# Run the script and check if it contains part of the banner
OUTPUT=$("$SCRIPT_PATH" --no-animation)
if [[ "$OUTPUT" == *"CHAZOS"* ]]; then
    echo "[PASS] Welcome script outputs correctly."
    exit 0
else
    echo "[FAIL] Welcome script output is incorrect or missing the banner."
    exit 1
fi
