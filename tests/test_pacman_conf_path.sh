#!/bin/bash
# Test if pacman.conf has the correct custom repository path

grep -q "Server = file://{{PWD}}/chazos_profile/custom_repo" chazos_profile/pacman.conf
if [ $? -eq 0 ]; then
    echo "Test Passed: Custom repo path is correct."
    exit 0
else
    echo "Test Failed: Custom repo path is incorrect."
    exit 1
fi
