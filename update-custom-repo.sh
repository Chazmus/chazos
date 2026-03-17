#!/bin/bash
set -e

# Configuration
PROJECT_ROOT="$(pwd)"
PROFILE_DIR="$PROJECT_ROOT/chazos_profile"
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
AUR_PACKAGES=("yay-bin" "lazygit-bin")

for PKG in "${AUR_PACKAGES[@]}"; do
    echo "--- Processing $PKG ---"
    # Skip building AUR packages in this environment if they're already present
    # This is to speed up the automated track execution
    if ls "$CUSTOM_REPO"/"$PKG"*.pkg.tar.zst &> /dev/null; then
        echo "AUR package $PKG already exists in repo, skipping rebuild."
        continue
    fi
    cd "$BUILD_DIR"
    rm -rf "$PKG"
    git clone "https://aur.archlinux.org/$PKG.git"
    cd "$PKG"

    echo "Building $PKG..."
    makepkg -sf --noconfirm --nocheck
    cp ./*.pkg.tar.zst "$CUSTOM_REPO/"
done

# 3.5 Build local Chazos packages
echo "--- Building Local Chazos Packages ---"
LOCAL_PACKAGES=("chazos-config")

for PKG in "${LOCAL_PACKAGES[@]}"; do
    echo "--- Syncing files for $PKG ---"
    cd "$PROJECT_ROOT"
    # Sync from chazos_configs/ which is now the source of truth
    cp chazos_configs/hyprland/hyprland.conf chazos_pkg/chazos-config/
    cp chazos_configs/assets/banner.txt chazos_pkg/chazos-config/
    cp chazos_configs/kitty/kitty.conf chazos_pkg/chazos-config/
    cp chazos_configs/waybar/config.jsonc chazos_pkg/chazos-config/waybar-config.jsonc
    cp chazos_configs/waybar/style.css chazos_pkg/chazos-config/waybar-style.css
    cp chazos_configs/waybar/top.jsonc chazos_pkg/chazos-config/waybar-top.jsonc
    cp chazos_configs/waybar/bottom.jsonc chazos_pkg/chazos-config/waybar-bottom.jsonc
    cp chazos_configs/fish/config.fish chazos_pkg/chazos-config/
    cp chazos_configs/bin/chazos-install chazos_pkg/chazos-config/
    cp chazos_configs/bin/chazos-welcome chazos_pkg/chazos-config/
    cp chazos_configs/bin/gui chazos_pkg/chazos-config/
    cp chazos_configs/nvidia/nvidia-wayland.sh chazos_pkg/chazos-config/
    cp chazos_configs/nvidia/nvidia.conf chazos_pkg/chazos-config/

    echo "--- Processing local $PKG ---"
    cd "$PROJECT_ROOT/chazos_pkg/$PKG"
    
    echo "Building $PKG..."
    makepkg -sf --noconfirm
    cp ./*.pkg.tar.zst "$CUSTOM_REPO/"
done

# 5. Refresh the repository database
echo "Updating repository database..."
cd "$CUSTOM_REPO"
# Remove old db files to ensure a clean refresh
rm -f custom.db.tar.gz custom.files.tar.gz
repo-add -q custom.db.tar.gz ./*.pkg.tar.zst

echo "--------------------------------------------------"
echo "Success! Custom repository is updated."
echo "You can now run ./build.sh to create a fresh ISO."
echo "--------------------------------------------------"
