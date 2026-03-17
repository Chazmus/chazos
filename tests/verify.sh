#!/bin/bash
# Verification script to be run INSIDE the Chazos ISO

echo "[CHAZOS-TEST] Starting verification..."

# 1. Check if Sway is running (wait a bit)
for _ in {1..10}; do
    if pgrep -x "sway" > /dev/null; then
        echo "[CHAZOS-TEST] Sway is running."
        break
    fi
    sleep 2
done

if ! pgrep -x "sway" > /dev/null; then
    echo "[CHAZOS-TEST] FAIL: Sway did not start."
    exit 1
fi

# 2. Check if Kitty is installed
if command -v kitty > /dev/null; then
    echo "[CHAZOS-TEST] Kitty is installed."
else
    echo "[CHAZOS-TEST] FAIL: Kitty is missing."
    exit 1
fi

# 3. Check if Chazos config is present
if [ -f "/etc/skel/.config/sway/chazos.conf" ]; then
    echo "[CHAZOS-TEST] Chazos config is present."
else
    echo "[CHAZOS-TEST] FAIL: Chazos config is missing."
    exit 1
fi

echo "[CHAZOS-TEST] SUCCESS: All checks passed!"
# Shutdown to indicate completion
sync
# poweroff -f
