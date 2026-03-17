#!/usr/bin/env bash

# Test if hyprland.conf exists in chazos_configs/hyprland/

CONFIG_PATH="chazos_configs/hyprland/hyprland.conf"

if [ -f "$CONFIG_PATH" ]; then
    echo "[PASS] Hyprland config exists at $CONFIG_PATH."
    exit 0
else
    echo "[FAIL] Hyprland config NOT found at $CONFIG_PATH."
    exit 1
fi
