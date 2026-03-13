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
Requires `archiso` and `qemu-desktop`:
```bash
./test-iso.sh
```

## Local Building

### Updating Custom Packages (yay)
If you want to ensure the latest version of `yay` is baked into the ISO, run this helper script first:
```bash
./update-custom-repo.sh
```

To build a fresh Chazos ISO on an Arch Linux host, you will need `archiso` installed:

```bash
sudo pacman -S archiso
```

### Build Process
The build process requires root privileges and approximately 15GB of free space in your working directory.

   ```bash
   ```

2. **Start the build script:**
   ```bash
   ./build.sh
   ```

The final ISO will be placed in the `out/` directory.

## CI/CD
Built automatically via GitHub Actions. Download the latest ISO from the 'Actions' tab artifacts.