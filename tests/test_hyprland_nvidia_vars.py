import os
import re

def test_hyprland_nvidia_vars():
    config_path = "chazos_configs/hyprland/hyprland.conf"
    assert os.path.exists(config_path), f"Hyprland config NOT found at {config_path}."

    with open(config_path, 'r') as f:
        config_content = f.read()

    # Define the required Nvidia environment variables
    required_vars = [
        r"env\s*=\s*LIBVA_DRIVER_NAME,nvidia",
        r"env\s*=\s*XDG_SESSION_TYPE,wayland",
        r"env\s*=\s*__GLX_VENDOR_LIBRARY_NAME,nvidia",
        r"env\s*=\s*WLR_NO_HARDWARE_CURSORS,1",
    ]

    for var in required_vars:
        assert re.search(var, config_content), f"Required Nvidia var '{var}' NOT found in {config_path}."

if __name__ == "__main__":
    try:
        test_hyprland_nvidia_vars()
        print("[PASS] Hyprland Nvidia environment variables exist.")
    except AssertionError as e:
        print(f"[FAIL] {e}")
        exit(1)
