import os
import re

def test_hyprland_keybindings_exist():
    config_path = "chazos_configs/hyprland/hyprland.conf"
    assert os.path.exists(config_path), f"Hyprland config NOT found at {config_path}."

    with open(config_path, 'r') as f:
        config_content = f.read()

    # Define the required keybindings
    required_keybindings = [
        r"bind\s*=\s*\$mainMod,\s*RETURN,\s*exec,\s*\$term",
        r"bind\s*=\s*\$mainMod,\s*Q,\s*killactive",
        r"bind\s*=\s*\$mainMod,\s*M,\s*exit",
    ]

    for kb in required_keybindings:
        assert re.search(kb, config_content), f"Required keybinding '{kb}' NOT found in {config_path}."

def test_hyprland_modal_system_logic():
    # This is a placeholder for testing the submaps (modes)
    # The requirement is to replicate Sway's modal workflow.
    config_path = "chazos_configs/hyprland/hyprland.conf"
    with open(config_path, 'r') as f:
        config_content = f.read()

    # The current config is basic, so we expect these to FAIL initially.
    required_modes = [
        r"submap\s*=\s*pane",
        r"submap\s*=\s*tab",
    ]

    for mode in required_modes:
        assert re.search(mode, config_content), f"Required mode '{mode}' NOT found in {config_path}."

if __name__ == "__main__":
    try:
        test_hyprland_keybindings_exist()
        print("[PASS] Hyprland keybindings exist.")
        test_hyprland_modal_system_logic()
        print("[PASS] Hyprland modal system exists.")
    except AssertionError as e:
        print(f"[FAIL] {e}")
        exit(1)
