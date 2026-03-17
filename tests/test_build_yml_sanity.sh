#!/bin/bash
# Shell-based sanity check for build.yml

FILE=".github/workflows/build.yml"
FAILED=0

# 1. Check for sudo in dependencies
if grep -A 5 "name: Install dependencies" "$FILE" | grep -q "sudo"; then
    echo "Success: 'sudo' found in Install dependencies step."
else
    echo "Failure: 'sudo' not found in Install dependencies step."
    FAILED=1
fi

# 2. Check pacman-key sequence
# We want to see --init and --populate BEFORE -Syu
init_line=$(grep -n "pacman-key --init" "$FILE" | head -n 1 | cut -d: -f1)
populate_line=$(grep -n "pacman-key --populate" "$FILE" | head -n 1 | cut -d: -f1)
syu_line=$(grep -n "pacman -Syu" "$FILE" | head -n 1 | cut -d: -f1)

if [[ -z "$init_line" || -z "$populate_line" || -z "$syu_line" ]]; then
    echo "Failure: One of the pacman commands is missing."
    FAILED=1
else
    if [[ "$init_line" -lt "$syu_line" && "$populate_line" -lt "$syu_line" ]]; then
        echo "Success: pacman-key commands are before pacman -Syu."
    else
        echo "Failure: pacman-key commands must be before pacman -Syu."
        FAILED=1
    fi
fi

# 3. Check for chazos-config build step
if grep -q "Build chazos-config" "$FILE"; then
    echo "Success: 'Build chazos-config' step found."
else
    echo "Failure: 'Build chazos-config' step not found."
    FAILED=1
fi

# 4. Check for correct sed command
# It should use | as delimiter because $(pwd) contains /
if grep -q "sed -i \"s|{{PWD}}|" "$FILE"; then
    echo "Success: Correct sed delimiter used."
else
    echo "Failure: Incorrect sed delimiter used or command missing."
    FAILED=1
fi

exit $FAILED
