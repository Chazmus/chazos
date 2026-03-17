#!/usr/bin/env bash

# Test if welcome assets exist in chazos_configs/assets/

ASSET_PATH="chazos_configs/assets/banner.txt"

if [ -f "$ASSET_PATH" ]; then
    echo "[PASS] Welcome banner exists at $ASSET_PATH."
    exit 0
else
    echo "[FAIL] Welcome banner NOT found at $ASSET_PATH."
    exit 1
fi
