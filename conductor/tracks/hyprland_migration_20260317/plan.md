# Implementation Plan: Hyprland Migration and Retro-TUI Welcome

## Phase 1: Preparation and Scaffolding
- [x] Task: Install Hyprland and related dependencies on the development host for testing. (4262c6a)
- [x] Task: Create a basic Hyprland configuration file (`hyprland.conf`) in `chazos_configs/hyprland/`. (8859076)
- [ ] Task: Conductor - User Manual Verification 'Phase 1: Preparation and Scaffolding' (Protocol in workflow.md)

## Phase 2: Hyprland Migration
- [ ] Task: Write functional tests for Hyprland keybindings and window management.
- [ ] Task: Implement keybindings and window rules in `hyprland.conf`.
- [ ] Task: Configure Nvidia-specific environment variables for Hyprland.
- [ ] Task: Conductor - User Manual Verification 'Phase 2: Hyprland Migration' (Protocol in workflow.md)

## Phase 3: Retro-TUI Welcome Experience
- [ ] Task: Design ASCII art banners for the welcome screen.
- [ ] Task: Write functional tests for the `chazos-welcome` script (e.g., exit code, output format).
- [ ] Task: Implement the `chazos-welcome` script with text-based animations in `chazos_configs/bin/`.
- [ ] Task: Configure Hyprland to launch Kitty with the `chazos-welcome` script on startup.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: Retro-TUI Welcome Experience' (Protocol in workflow.md)

## Phase 4: Packaging and ISO Integration
- [ ] Task: Update the `PKGBUILD` in `chazos_pkg/chazos-config/` to include Hyprland and the welcome script.
- [ ] Task: Update `chazos_profile/packages.x86_64` to replace `sway` with `hyprland` and dependencies.
- [ ] Task: Build the updated `chazos-config` package and refresh the local repository.
- [ ] Task: Build the ISO and verify the Hyprland migration in QEMU.
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Packaging and ISO Integration' (Protocol in workflow.md)
