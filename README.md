# Chazos

A Zellij-inspired terminal OS built on Arch Linux.

## Core Philosophy
Chazos is designed for terminal-first users who want a multiplexer-like experience at the OS level. Instead of a traditional Desktop Environment or a bare TTY, Chazos uses Sway as a thin, modal wrapper that mimics the workflow of Zellij. It boots directly into a Kitty terminal and provides a modal interface for managing windows and workspaces.

## Key Features
- **Base:** Arch Linux
- **Modal Workflow:** Sway modes configured for Zellij-like shortcuts (Super+P for panes, Super+T for tabs).
- **Terminal Hub:** Boots directly into a high-performance Kitty terminal session.
- **Hardware:** Automated Nvidia detection and configuration.
- **Networking:** NetworkManager enabled by default.

## Local Testing
Requires `archiso` and `qemu`:
```bash
./test-iso.sh
```

## CI/CD
Built automatically via GitHub Actions. Download the latest ISO from the 'Actions' tab artifacts.