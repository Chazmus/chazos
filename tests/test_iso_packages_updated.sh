#!/usr/bin/env bash

# Test if packages.x86_64 is updated to include hyprland and exclude sway.

PKG_FILE="chazos_profile/packages.x86_64"

if [ ! -f "$PKG_FILE" ]; then
    echo "[FAIL] Package list NOT found at $PKG_FILE."
    exit 1
fi

if grep -q "^sway$" "$PKG_FILE"; then
    echo "[FAIL] 'sway' still present in $PKG_FILE."
    exit 1
fi

if grep -q "^hyprland$" "$PKG_FILE"; then
    echo "[PASS] 'hyprland' is present in $PKG_FILE."
    exit 0
else
    echo "[FAIL] 'hyprland' NOT found in $PKG_FILE."
    exit 1
fi
