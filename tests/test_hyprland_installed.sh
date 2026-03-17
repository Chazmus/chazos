#!/usr/bin/env bash

# Test if Hyprland and its core dependencies are installed.

check_package() {
    if pacman -Qi "$1" > /dev/null 2>&1; then
        echo "[PASS] Package $1 is installed."
        return 0
    else
        echo "[FAIL] Package $1 is NOT installed."
        return 1
    fi
}

FAILED=0

check_package hyprland || FAILED=1
check_package xdg-desktop-portal-hyprland || FAILED=1

if [ $FAILED -eq 1 ]; then
    echo "Hyprland dependencies are missing."
    exit 1
else
    echo "All Hyprland dependencies are installed."
    exit 0
fi
