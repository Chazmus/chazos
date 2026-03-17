import os
import re

def test_hyprland_startup_welcome():
    config_path = "chazos_configs/hyprland/hyprland.conf"
    assert os.path.exists(config_path), f"Hyprland config NOT found at {config_path}."

    with open(config_path, 'r') as f:
        config_content = f.read()

    # Define the required startup command
    # We want to launch kitty executing chazos-welcome
    required_startup = r"exec-once\s*=\s*\$term\s*--hold\s*chazos-welcome"

    assert re.search(required_startup, config_content), f"Required startup command '{required_startup}' NOT found in {config_path}."

if __name__ == "__main__":
    try:
        test_hyprland_startup_welcome()
        print("[PASS] Hyprland startup welcome command exists.")
    except AssertionError as e:
        print(f"[FAIL] {e}")
        exit(1)
