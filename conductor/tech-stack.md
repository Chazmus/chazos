# Tech Stack: Chazos

## 1. Operating System & Base
- **Distribution:** Arch Linux (custom ISO built with `archiso`).
- **Package Management:** `pacman` (with a local custom repository for internal and AUR packages).
- **Helper Tools:** `yay` (AUR helper).

## 2. Display & Window Management
- **Display Protocol:** Wayland.
- **Window Manager:** **Hyprland** (replacing Sway for dynamic, modern tiling).
- **Driver Support:** Nvidia proprietary drivers (pre-configured for Wayland compatibility).

## 3. Terminal & Shell
- **Primary Terminal:** Kitty (high-performance, GPU-accelerated).
- **Default Shell:** Fish (interactive-focused).
- **Scripting:** Bash (for system management and build scripts).

## 4. TUI & CLI Utilities
- **Navigation & Search:** `fzf`, `ripgrep`, `zoxide`.
- **System Monitoring:** `btop`.
- **File Management:** `eza`, `dust`, `lazygit`.
- **Viewer/Pager:** `bat`.

## 5. Build & Deployment
- **ISO Generation:** `mkarchiso` (via custom `build.sh`).
- **Configuration Bundling:** PKGBUILD (for the `chazos-config` package).
- **CI/CD:** GitHub Actions (for automated ISO builds).

## 6. Testing & Validation
- **Linting:** `shellcheck`.
- **Package Integrity:** `namcap`.
- **Integration Testing:** Headless QEMU tests (via `tests/integration.sh`).
