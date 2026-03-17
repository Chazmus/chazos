# Implementation Plan: Hyprland Migration and Retro-TUI Welcome

## Phase 1: Preparation and Scaffolding [checkpoint: a33d0f2]
- [x] Task: Install Hyprland and related dependencies on the development host for testing. (4262c6a)
- [x] Task: Create a basic Hyprland configuration file (`hyprland.conf`) in `chazos_configs/hyprland/`. (8859076)
- [x] Task: Conductor - User Manual Verification 'Phase 1: Preparation and Scaffolding' (Protocol in workflow.md) (a33d0f2)

## Phase 2: Hyprland Migration [checkpoint: a9c63e4]
- [x] Task: Write functional tests for Hyprland keybindings and window management. (f4ca4c3)
- [x] Task: Implement keybindings and window rules in `hyprland.conf`. (dff7525)
- [x] Task: Configure Nvidia-specific environment variables for Hyprland. (069cbbf)
- [x] Task: Conductor - User Manual Verification 'Phase 2: Hyprland Migration' (Protocol in workflow.md) (a9c63e4)

## Phase 3: Retro-TUI Welcome Experience [checkpoint: 9a68e70]
- [x] Task: Design ASCII art banners for the welcome screen. (6229972)
- [x] Task: Write functional tests for the `chazos-welcome` script (e.g., exit code, output format). (c0e9638)
- [x] Task: Implement the `chazos-welcome` script with text-based animations in `chazos_configs/bin/`. (63f1702)
- [x] Task: Configure Hyprland to launch Kitty with the `chazos-welcome` script on startup. (f0496f6)
- [x] Task: Conductor - User Manual Verification 'Phase 3: Retro-TUI Welcome Experience' (Protocol in workflow.md) (9a68e70)

## Phase 4: Packaging and ISO Integration
- [x] Task: Update the `PKGBUILD` in `chazos_pkg/chazos-config/` to include Hyprland and the welcome script. (8746ef1)
- [x] Task: Update `chazos_profile/packages.x86_64` to replace `sway` with `hyprland` and dependencies. (30e9a1c)
- [x] Task: Build the updated `chazos-config` package and refresh the local repository. (db1b571)
- [x] Task: Build the ISO and verify the Hyprland migration in QEMU. (b084459)
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Packaging and ISO Integration' (Protocol in workflow.md)
