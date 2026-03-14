# Chazos: The Terminal-as-OS Multiplexer

Chazos is a specialized Arch Linux distribution where the window manager (Sway) is configured to behave like a system-wide terminal multiplexer (mimicking Zellij's modal workflow). It boots directly into a high-performance terminal (Kitty), making the entire OS feel like a single, cohesive terminal environment.

## 📋 Key Features
- **Modal Workflow:** Uses Sway "modes" (Super+P for Pane, Super+T for Tab) to provide a Zellij-like interface for managing windows and workspaces.
- **Terminal Hub:** Boots directly into Kitty, which serves as the primary interface for all system interactions.
- **Modern CLI Stack:** Includes a curated set of modern tools (`fzf`, `ripgrep`, `eza`, `bat`, `btop`, `zoxide`, `dust`, `lazygit`, `yay`).
- **Nvidia Support:** Pre-configured for Nvidia proprietary drivers with Wayland compatibility.

## 🏗️ Project Structure
- `chazos_configs/`: **The Source of Truth.** All core configuration files (Sway, Kitty, Waybar, etc.) are managed here.
- `chazos_pkg/`: Contains the `PKGBUILD` for our internal `chazos-config` package, which bundles the files from `chazos_configs/`.
- `chazos_profile/`: The Archiso profile directory.
    - `airootfs/`: Files specific to the Live ISO environment (e.g., installer scripts, ISO-only startup configs).
    - `custom_repo/`: A local pacman repository used to store our internal packages and AUR binaries.
    - `packages.x86_64`: List of packages included in the ISO.
- `build.sh`: Script to generate the final ISO using `mkarchiso`.
- `update-custom-repo.sh`: Script to build internal packages and refresh the local repository database.

## 🛠️ How it Works
Chazos uses a **Package-First Configuration** strategy. Instead of copying raw files into the ISO, all configurations are bundled into an Arch Linux package (`chazos-config`).

1. **Configuration:** Edits are made in the `chazos_configs/` directory.
2. **Packaging:** `update-custom-repo.sh` syncs these configs into a package and builds it into the local `custom_repo`.
3. **Build:** `build.sh` runs `mkarchiso`, which pulls `chazos-config` from the local repo and installs it into the ISO image.
4. **Installation:** The `chazos-install` script ensures that the installed system also has the `custom_repo` and `chazos-config` package, keeping the installed OS perfectly in sync with the ISO.

## 🚀 Building and Testing
1. **Refresh Packages:**
   ```bash
   ./update-custom-repo.sh
   ```
2. **Build the ISO:**
   ```bash
   ./build.sh
   ```
3. **Test in QEMU:**
   ```bash
   ./test-iso.sh
   ```

---
*Built with Archiso and a passion for the command line.*
