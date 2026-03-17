#!/bin/bash
set -e

# Run namcap on the PKGBUILD
if command -v namcap &> /dev/null; then
    echo "Running namcap on chazos-config/PKGBUILD..."
    namcap chazos_pkg/chazos-config/PKGBUILD
else
    echo "Warning: 'namcap' not found. Skipping package checks."
    exit 0
fi

# Check if the package exists and run namcap on it
PKG_FILE=$(find chazos_pkg/chazos-config -name "*.pkg.tar.zst" | head -n 1)
if [ -n "$PKG_FILE" ]; then
    echo "Running namcap on $PKG_FILE..."
    namcap "$PKG_FILE"
else
    echo "Warning: No package file found to check. Run makepkg first if you want to check the package integrity."
fi
