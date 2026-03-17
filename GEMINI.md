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
- **Configuration Source:** `chazos_configs/` (Source of truth for the `chazos-config` package)
- **Custom Repo:** Local repository in `chazos_profile/custom_repo` used to inject AUR packages and our internal `chazos-config` package.
- **Primary Terminal:** Kitty
- **Kiosk Config:** 
    - `/etc/skel/.config/sway/chazos.conf` (Installed via `chazos-config` package)
    - `/etc/sway/config.d/99-chazos-iso.conf` (ISO-only startup override for the welcome message)

    ## Testing & Quality Assurance
    1. **Static Analysis:** `shellcheck` is used to lint all scripts in `chazos_configs/bin/`, `build.sh`, and other system scripts.
    2. **Package Validation:** `namcap` is used to verify the integrity and structure of the `chazos-config` package.
    3. **Pre-build Hook:** `build.sh` automatically runs all tests via `tests/run-all.sh` before generating the ISO.
    4. **Integration Testing:**
    - `tests/verify.sh`: Internal verification script for checking system state (Sway, Kitty, Configs).
    - `tests/integration.sh`: Headless QEMU runner that uses a local HTTP server and `script=` kernel parameter to automate ISO verification.
    - `05-chazos-test.conf`: Dedicated bootloader entry in `chazos_profile/efiboot/loader/entries/` for automated testing.