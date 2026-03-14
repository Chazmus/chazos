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
AUR_PACKAGES=("yay-bin" "lazygit-bin")

for PKG in "${AUR_PACKAGES[@]}"; do
    echo "--- Processing $PKG ---"
    cd "$BUILD_DIR"
    rm -rf "$PKG"
    git clone "https://aur.archlinux.org/$PKG.git"
    cd "$PKG"

    echo "Building $PKG..."
    sudo -u builduser makepkg -sf --noconfirm
    cp *.pkg.tar.zst "$HOME/workspace/chazos/$CUSTOM_REPO/"
done

# 3.5 Build local Chazos packages
echo "--- Building Local Chazos Packages ---"
LOCAL_PACKAGES=("chazos-config")

for PKG in "${LOCAL_PACKAGES[@]}"; do
    echo "--- Syncing files for $PKG ---"
    cp chazos_profile/airootfs/etc/skel/.config/sway/chazos.conf chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/etc/skel/.config/sway/minimal-kiosk chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/etc/skel/.config/kitty/kitty.conf chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/etc/skel/.config/waybar/config.jsonc chazos_pkg/chazos-config/waybar-config.jsonc
    cp chazos_profile/airootfs/etc/skel/.config/waybar/style.css chazos_pkg/chazos-config/waybar-style.css
    cp chazos_profile/airootfs/etc/skel/.config/waybar/top.jsonc chazos_pkg/chazos-config/waybar-top.jsonc
    cp chazos_profile/airootfs/etc/skel/.config/waybar/bottom.jsonc chazos_pkg/chazos-config/waybar-bottom.jsonc
    cp chazos_profile/airootfs/etc/skel/.config/fish/config.fish chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/usr/local/bin/chazos-install chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/usr/local/bin/chazos-welcome chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/usr/local/bin/gui chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/etc/profile.d/nvidia-wayland.sh chazos_pkg/chazos-config/
    cp chazos_profile/airootfs/etc/mkinitcpio.conf.d/nvidia.conf chazos_pkg/chazos-config/

    echo "--- Processing local $PKG ---"
    cd "$HOME/workspace/chazos/chazos_pkg/$PKG"
    
    echo "Building $PKG..."
    makepkg -sf --noconfirm
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
