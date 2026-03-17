#!/bin/bash
set -e

# Find all shell scripts in the repository
# Including those in chazos_configs/bin/ and other subdirectories
SCRIPTS=$(find . -name "*.sh" -not -path "./chazos_pkg/*")

# Add scripts without extension in bin directories
BIN_SCRIPTS=$(find chazos_configs/bin -type f)

ALL_SCRIPTS="$SCRIPTS $BIN_SCRIPTS"

echo "Running shellcheck on $(echo "$ALL_SCRIPTS" | wc -w) files..."
# shellcheck disable=SC2086
shellcheck $ALL_SCRIPTS
echo "ShellCheck passed!"
