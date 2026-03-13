#!/bin/bash
set -e

# Configuration
PROFILE_DIR="chazos_profile"
WORK_DIR="/tmp/archiso-tmp"
OUT_DIR="./out"

# 1. Check for archiso
if ! command -v mkarchiso &> /dev/null; then
    echo "Error: 'archiso' package is not installed."
    echo "Install it with: sudo pacman -S archiso"
    exit 1
fi

# 2. Cleanup
echo "Cleaning up previous build artifacts..."
sudo rm -rf "$WORK_DIR"
mkdir -p "$OUT_DIR"
sudo rm -f "$OUT_DIR"/*.iso

# 3. Refresh custom repo database (required for yay-bin and other local packages)
if [ -d "$PROFILE_DIR/custom_repo" ]; then
    echo "Refreshing custom repository database..."
    pushd "$PROFILE_DIR/custom_repo" > /dev/null
    # Remove old DB files to ensure a clean refresh
    rm -f custom.db.tar.gz custom.files.tar.gz
    # Add all packages in the directory to the database
    repo-add -q custom.db.tar.gz *.pkg.tar.zst 2>/dev/null || echo "No custom packages found to add."
    popd > /dev/null
fi

# 4. Create a temporary pacman.conf that includes the host's package cache
echo "Syncing package databases and resolving paths in temporary config..."
sudo pacman -Syy
TEMP_PACMAN_CONF="/tmp/chazos-pacman.conf"
# Get absolute path of the profile dir
ABS_PROFILE_DIR=$(realpath "$PROFILE_DIR")
# Replace {{PWD}} with the absolute path and add CacheDir
sed "s|{{PWD}}|$ABS_PROFILE_DIR|g" "$PROFILE_DIR/pacman.conf" > "$TEMP_PACMAN_CONF"
sed -i '/\[options\]/a CacheDir = /var/cache/pacman/pkg' "$TEMP_PACMAN_CONF"

# 5. Run mkarchiso
echo "Starting Chazos ISO build (requires root privileges)..."
# Use the temporary pacman.conf with the host's cache
sudo mkarchiso -v -C "$TEMP_PACMAN_CONF" -w "$WORK_DIR" -o "$OUT_DIR" "$PROFILE_DIR"

# Cleanup temp config
rm -f "$TEMP_PACMAN_CONF"

echo "--------------------------------------------------"
echo "Build complete! ISO is located in $OUT_DIR"
echo "To test your build, run: ./test-iso.sh"
echo "--------------------------------------------------"
