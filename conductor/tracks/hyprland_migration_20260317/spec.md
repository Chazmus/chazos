# Specification: Hyprland Migration and Retro-TUI Welcome

## 1. Goal
Migrate the window manager from Sway to Hyprland and implement a system-wide retro-TUI aesthetic, starting with a custom welcome screen and animations.

## 2. Requirements
- **Hyprland Migration:**
    - Replace Sway with Hyprland as the default compositor.
    - Replicate existing keybindings (or adapt to Hyprland style).
    - Ensure Nvidia proprietary drivers work correctly with Hyprland.
- **Retro-TUI Welcome:**
    - Create a `chazos-welcome` script that displays ASCII art and a brief animation.
    - The welcome screen should boot directly into Kitty.
- **Packaging:**
    - Update `chazos-config` package to include Hyprland and the new welcome assets.
    - Update the ISO build profile (`packages.x86_64`).

## 3. Success Criteria
- The ISO boots successfully into a Hyprland session.
- The retro-TUI welcome screen is displayed upon initial login.
- Keybindings are functional and intuitive.
- The `chazos-config` package correctly installs all Hyprland and TUI assets.
