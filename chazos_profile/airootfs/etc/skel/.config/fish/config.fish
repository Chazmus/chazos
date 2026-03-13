# Chazos - The "Terminal-as-OS" Fish Config

# Disable the default greeting
set -g fish_greeting ""

# Environment variables
set -gx EDITOR nvim
set -gx VISUAL nvim

# Aliases for our power-tools
if command -v eza > /dev/null
    alias ls='eza --icons --group-directories-first'
    alias ll='eza -l --icons --group-directories-first'
    alias la='eza -a --icons --group-directories-first'
    alias lt='eza --tree --icons'
end

if command -v bat > /dev/null
    alias cat='bat --style=plain'
end

if command -v btop > /dev/null
    alias top='btop'
end

if command -v zoxide > /dev/null
    zoxide init fish | source
end

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../../'

# Chazos Welcome message
if status is-interactive
    # We can launch the welcome script or just a message
    # chazos-welcome
end
