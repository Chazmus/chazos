# Chazos OS Components Research

This document outlines the essential components for a modern operating system that are typically manually configured in Arch Linux. For Chazos, we prioritize **Terminal User Interfaces (TUI)** and **Command Line Interfaces (CLI)** to align with the "Terminal-as-OS" philosophy.

## 1. Notification System
Essential for system alerts, battery warnings, and application feedback.
*   **Mako (Recommended):** A lightweight notification daemon for Wayland. Highly configurable via a simple text file.
*   **Fnott:** Keyboard-driven, lightweight notification daemon for Wayland.
*   **Dunst:** The classic choice, though originally for X11, it works well on Wayland via `xwayland`.

## 2. Application Launcher / Command Runner
Sway currently uses `dmenu`, but more modern Wayland-native options exist.
*   **Fuzzel (Recommended):** Wayland-native, extremely fast, and supports icons.
*   **Bemenu:** A Wayland-native `dmenu` replacement.
*   **Wofi:** A Rofi-like launcher for Wayland.
*   **TUI Option:** A custom `fzf` script that scans `.desktop` files and launches them via `swaymsg exec`.

## 3. Bluetooth Management
*   **Bluetui (Recommended):** A modern TUI for managing Bluetooth connections.
*   **Bluetoothctl:** The standard CLI tool (part of `bluez-utils`). Functional but less "discoverable" than a TUI.
*   **Blueman:** GUI-based, but includes `blueman-applet` for tray integration.

## 4. Audio Management
*   **Pulsemixer (Recommended):** A robust TUI for PulseAudio/PipeWire. Excellent for managing levels and switching outputs.
*   **Ncpamixer:** An ncurses-based mixer similar to `pavucontrol` but in the terminal.
*   **Pamixer:** A CLI tool for volume control, ideal for binding to keyboard shortcuts.

## 5. Network Management
*   **Nmtui (Recommended):** The built-in TUI for NetworkManager. It is standard, stable, and easy to use.
*   **Iwctl:** The CLI for `iwd`, very clean and modern if not using NetworkManager.

## 6. General Settings / "Control Center"
Since Sway/Arch lacks a unified "Settings" app, Chazos can implement a "Chazos Control Center".
*   **Implementation:** A custom TUI built with **`gum`** or **`fzf`**.
*   **Features:**
    *   Appearance (Sway/Waybar/Kitty themes)
    *   Display settings (scaling, rotation via `wlr-randr`)
    *   Power settings (idle timeouts)
    *   System updates (`pacman` / AUR helper)

## 7. File Management
*   **Yazi (Recommended):** A modern, blazing-fast TUI file manager written in Rust with image preview support.
*   **Ranger:** The classic Python-based TUI file manager with Vim-like bindings.
*   **Lf:** A simpler, faster alternative to Ranger written in Go.

## 8. Screen Locking & Power Management
*   **Swaylock-effects:** A fork of `swaylock` with added aesthetic features like blurring.
*   **Swayidle:** Manages idle events (locking the screen, turning off displays).
*   **Brightnessctl:** Simple CLI for managing screen and keyboard backlight.

## 9. System Monitoring
*   **Btop (Recommended):** A beautiful, high-performance system monitor.
*   **Bottom (btm):** A cross-platform graphical process/system monitor.

## 10. Clipboard Management
*   **Wl-clipboard:** The base CLI tools for copy/paste in Wayland.
*   **Clipman:** A basic clipboard manager for Wayland.
*   **TUI Integration:** Use `fzf` to pick from clipboard history.

---

## Proposed Chazos "OS Experience" Shortcuts
To maintain the "Zellij" feel, we should integrate these into Sway modes:

*   **Super+s (System Mode):**
    *   `b`: Launch **Bluetui**
    *   `n`: Launch **Nmtui**
    *   `a`: Launch **Pulsemixer**
    *   `c`: Launch **Chazos Control Center** (Custom TUI)
    *   `u`: Check for System Updates
