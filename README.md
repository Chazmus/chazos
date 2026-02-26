# Chazos

A terminal-first, TTY-based Arch Linux distribution.

## Core Philosophy
Chazos is designed for users who live in the terminal but occasionally need GUI applications. Instead of a persistent Desktop Environment, Chazos uses a transient Sway session to host single GUI applications (like IntelliJ or Firefox) full-screen, returning you to the TTY immediately upon closing the app.

## Key Features
- **Base:** Arch Linux
- **GUI Wrapper:** `gui <command>` launches applications in a minimal Sway kiosk.
- **Hardware:** Automated Nvidia detection and configuration.
- **Networking:** NetworkManager enabled by default.

## Local Testing
Requires `archiso` and `qemu`:
```bash
./test-iso.sh
```

## CI/CD
Built automatically via GitHub Actions. Download the latest ISO from the 'Actions' tab artifacts.