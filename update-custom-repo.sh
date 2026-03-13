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

# 3. Fetch and build AUR packages
# We focus on -bin versions where possible for faster, more reliable ISO builds
AUR_PACKAGES=("yay-bin" "lazygit-bin")

for PKG in "${AUR_PACKAGES[@]}"; do
    echo "--- Processing $PKG ---"
    cd "$BUILD_DIR"
    rm -rf "$PKG"
    git clone "https://aur.archlinux.org/$PKG.git"
    cd "$PKG"

    echo "Building $PKG..."
    # -s: install dependencies, -f: force build, --noconfirm: don't ask
    sudo -u builduser makepkg -sf --noconfirm

    # 4. Move the new package to our custom repo
    echo "Moving $PKG to $CUSTOM_REPO..."
    # Remove old versions first
    rm -f "$HOME/workspace/chazos/$CUSTOM_REPO/${PKG%-bin}"-*.pkg.tar.zst 2>/dev/null
    rm -f "$HOME/workspace/chazos/$CUSTOM_REPO/$PKG"-*.pkg.tar.zst 2>/dev/null
    cp *.pkg.tar.zst "$HOME/workspace/chazos/$CUSTOM_REPO/"
done

# 5. Refresh the repository database
echo "Updating repository database..."
cd "$HOME/workspace/chazos/$CUSTOM_REPO"
repo-add -q custom.db.tar.gz *.pkg.tar.zst

echo "--------------------------------------------------"
echo "Success! Custom repository is updated with latest yay-bin."
echo "You can now run ./build.sh to create a fresh ISO."
echo "--------------------------------------------------"
