# Project Context: Chazos

## Goal
Build a specialized Arch Linux ISO that operates entirely from the TTY, using Sway only as a transient wrapper for GUI applications.

## Guiding Principles
1. **Terminal First:** The TTY is the primary interface. No Display Manager.
2. **Transient GUI:** Sway should only exist as long as the GUI app it is wrapping.
3. **Nvidia Compatibility:** Must support Nvidia proprietary drivers dynamically without breaking Intel/AMD support.
4. **Automation:** The build process is offloaded to GitHub Actions.

## Technical Specifics
- **Profile Path:** `chazos_profile/`
- **Custom Repo:** Local repository in `chazos_profile/custom_repo` used to inject AUR packages like `yay-bin`.
- **Launcher:** `/usr/local/bin/gui`
- **Kiosk Config:** `/etc/skel/.config/sway/minimal-kiosk`