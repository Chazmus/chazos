#!/bin/bash
set -e

# Configuration
PROFILE_DIR="chazos_profile"
CUSTOM_REPO="$PROFILE_DIR/custom_repo"
BUILD_DIR="/tmp/yay-build"

echo "--- Refreshing Custom Repository Packages ---"

# 1. Ensure dependencies exist
if ! command -v makepkg &> /dev/null; then
    echo "Error: 'pacman-contrib' or 'base-devel' is required for makepkg."
    exit 1
fi

# 2. Setup temporary build directory
echo "Cleaning up build directory..."
rm -rf "$BUILD_DIR"
mkdir -p "$BUILD_DIR"
mkdir -p "$CUSTOM_REPO"

# 3. Fetch and build yay-bin (the binary version is faster and safer for ISOs)
echo "Fetching latest yay-bin from AUR..."
cd "$BUILD_DIR"
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin

echo "Building yay-bin (this may take a moment)..."
# -s: install dependencies, -f: force build, --noconfirm: don't ask
makepkg -sf --noconfirm

# 4. Move the new package to our custom repo
echo "Moving new package to $CUSTOM_REPO..."
# Remove old yay packages first
rm -f "$HOME/workspace/chazos/$CUSTOM_REPO"/yay-bin-*.pkg.tar.zst
# Copy the newly built package
cp *.pkg.tar.zst "$HOME/workspace/chazos/$CUSTOM_REPO/"

# 5. Refresh the repository database
echo "Updating repository database..."
cd "$HOME/workspace/chazos/$CUSTOM_REPO"
repo-add -q custom.db.tar.gz *.pkg.tar.zst

echo "--------------------------------------------------"
echo "Success! Custom repository is updated with latest yay-bin."
echo "You can now run ./build.sh to create a fresh ISO."
echo "--------------------------------------------------"
