# fix for screen readers
if grep -Fqa 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi

if [[ $(tty) == "/dev/tty1" ]]; then
    # Run the automated script handler (handles script= parameter)
    if command -v chazos-automated-script >/dev/null 2>&1; then
        chazos-automated-script
    fi
    
    # Automatically start the Chazos GUI session
    # This will start Hyprland.
    exec gui kitty
fi
