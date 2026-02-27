# fix for screen readers
if grep -Fqa 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi

if [[ $(tty) == "/dev/tty1" ]]; then
    ~/.automated_script.sh
    # Automatically start the Chazos GUI session
    # This will start Sway with our Zellij-like config.
    exec gui kitty
fi
