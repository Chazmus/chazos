# Specification: Chazos - Zellij-inspired Arch Linux OS

## 1. Project Overview

* **Base System:** Arch Linux.
* **Build Tool:** `archiso` (using the `releng` profile as a starting point).
* **Core Philosophy:** A terminal-centric operating system where Sway acts as a system-wide multiplexer, mimicking the modal workflow of Zellij.
* **The Multiplexer (Sway):** Instead of a traditional desktop environment, Sway is configured to boot directly into a Kitty terminal. It uses a modal interface (e.g., Super+P for panes, Super+T for tabs) to manage windows and workspaces, providing a seamless terminal-first experience.

## 2. Core Package List (`packages.x86_64`)

The following packages must be included in the `archiso` build:

* **Base System:** `base`, `linux`, `linux-firmware`, `systemd`, `neovim`, `polkit`.
* **Networking:** `networkmanager`.
* **Multiplexer / Terminal:** `sway`, `wayland`, `xorg-xwayland`, `kitty`, `dmenu`.
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

### C. The Zellij-like Configuration

1. **The Multiplexer Config:**
    * **File:** `/etc/skel/.config/sway/chazos.conf`
    * **Function:** Configures Sway with a modal interface.
    * **Modes:**
        * **Pane Mode (Super+P):** For splitting, moving, and resizing panes.
        * **Tab Mode (Super+T):** For managing workspaces (tabs).
        * **Resize Mode (Super+R):** For fine-tuned window resizing.
2. **Auto-start:**
    * **File:** `/root/.zlogin` (or user equivalent)
    * **Action:** Automatically launches `sway -c /etc/skel/.config/sway/chazos.conf` on TTY1 login.

## 4. Bootloader Configuration (ISO Boot Menu)

Configure the `systemd-boot` entries on the live ISO to offer a standard boot and a dedicated Nvidia boot.

* **Default Entry:** Standard Arch ISO boot parameters.
* **Nvidia Entry:** Clone the default entry and append the following kernel parameters to force proprietary drivers: `nvidia-drm.modeset=1 nvidia_drm.fbdev=1 nouveau.modeset=0`.
