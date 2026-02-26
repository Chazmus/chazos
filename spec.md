# Specification: Custom Terminal-First Arch Linux Distribution

## 1. Project Overview

* **Base System:** Arch Linux.
* **Build Tool:** `archiso` (using the `releng` profile as a starting point).
* **Core Philosophy:** A completely terminal-first, TTY-based operating system. There is no persistent Desktop Environment or Display Manager.
* **GUI Handling (The "Invisible Window Manager"):** GUI applications are launched from the TTY via a wrapper script. This script spawns a highly minimal, transient `sway` Wayland session tailored specifically to run that single application (like IntelliJ or Firefox) full-screen. When the application is closed, Sway instantly terminates, returning the user seamlessly to the TTY.

## 2. Core Package List (`packages.x86_64`)

The following packages must be included in the `archiso` build:

* **Base System:** `base`, `linux`, `linux-firmware`, `systemd`, `neovim`, `polkit`.
* **Networking:** `networkmanager`.
* **Display / GUI Wrapper:** `sway`, `wayland`, `xorg-xwayland`, `kitty` (or Alacritty/Foot).
* **Nvidia Support:** `nvidia-dkms`, `nvidia-utils`, `egl-wayland`.

## 3. System Configuration (`airootfs` Overlays)

### A. Automated Networking

Enable NetworkManager to start automatically on boot without user configuration.

* **Action:** Create a systemd symlink in the `airootfs` directory.
* **Target:** `/etc/systemd/system/multi-user.target.wants/NetworkManager.service` pointing to `/usr/lib/systemd/system/NetworkManager.service`.

### B. Nvidia Compatibility & Hardware Acceleration

Ensure the OS can boot and run Sway with proprietary Nvidia drivers without breaking compatibility with AMD/Intel systems.

1. **Early Module Loading:**
    * **File:** `/etc/mkinitcpio.conf.d/nvidia.conf`
    * **Content:** `MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)`
2. **Dynamic Environment Variables:**
    * **File:** `/etc/profile.d/nvidia-wayland.sh` (Must be executable).
    * **Content:** A bash script that uses `lspci` to detect an Nvidia GPU. If detected, it must export the following variables:
        * `WLR_NO_HARDWARE_CURSORS=1`
        * `LIBVA_DRIVER_NAME=nvidia`
        * `XDG_SESSION_TYPE=wayland`
        * `GBM_BACKEND=nvidia-drm`
        * `__GLX_VENDOR_LIBRARY_NAME=nvidia`

### C. The GUI Wrapper System

1. **The Launcher Script:**
    * **File:** `/usr/local/bin/gui` (Executable).
    * **Function:** Accepts an application command as an argument (e.g., `gui intellij`), launches Sway using a specific minimal configuration file, and passes the application command to Sway to execute immediately.
2. **The Minimal Sway Config:**
    * **File:** `/etc/skel/.config/sway/minimal-kiosk`
    * **Function:** Disables the status bar, window borders, and workspace switching. Forces the launched application to be full-screen. Crucially, monitors the PID of the launched application and terminates the Sway session (`swaymsg exit`) the moment the application closes.

## 4. Bootloader Configuration (ISO Boot Menu)

Configure the `systemd-boot` entries on the live ISO to offer a standard boot and a dedicated Nvidia boot.

* **Default Entry:** Standard Arch ISO boot parameters.
* **Nvidia Entry:** Clone the default entry and append the following kernel parameters to force proprietary drivers: `nvidia-drm.modeset=1 nvidia_drm.fbdev=1 nouveau.modeset=0`.
