# Project Context: Chazos

## Goal
Build a specialized Arch Linux ISO where Sway is configured to mimic Zellij's modal workflow, providing a terminal-centric OS experience that boots directly into Kitty.

## Guiding Principles
1. **Zellij-as-OS:** Sway acts as a system-wide multiplexer, using modes to manage panes and tabs.
2. **Terminal Hub:** Kitty is the primary interface, launched automatically on boot within Sway.
3. **Modal Interface:** Implement a 'mode' system (Super+P for pane, Super+T for tab, etc.) to mimic Zellij's shortcuts.
4. **Nvidia Compatibility:** Must support Nvidia proprietary drivers dynamically without breaking Intel/AMD support.
5. **Automation:** The build process is offloaded to GitHub Actions.

## Technical Specifics
- **Profile Path:** `chazos_profile/`
- **Custom Repo:** Local repository in `chazos_profile/custom_repo` used to inject AUR packages like `yay-bin`.
- **Primary Terminal:** Kitty
- **Kiosk Config:** `/etc/skel/.config/sway/chazos.conf` (formerly minimal-kiosk)