# Chazos Shell Configuration
# This is a basic .zshrc to ensure the root account has a functional shell environment.

# Load some defaults
autoload -Uz compinit
compinit

# Set history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Set prompt
PROMPT='%F{cyan}%n%f@%F{blue}%m%f %F{yellow}%~%f %# '
