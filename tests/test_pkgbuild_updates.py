import os

def test_pkgbuild_updated():
    pkgbuild_path = "chazos_pkg/chazos-config/PKGBUILD"
    assert os.path.exists(pkgbuild_path), f"PKGBUILD NOT found at {pkgbuild_path}."

    with open(pkgbuild_path, 'r') as f:
        content = f.read()

    # Check for Hyprland dependencies
    # Hyprland depends on some things that might need to be explicitly listed
    # but at least 'hyprland' should be in depends if we want it bundled or as a dependency.
    # Actually, chazos-config should depend on hyprland.
    assert "hyprland" in content, f"Hyprland dependency NOT found in {pkgbuild_path}."

    # Check for new source files
    required_sources = [
        "hyprland.conf",
        "banner.txt",
        "chazos-welcome",
    ]
    for src in required_sources:
        assert src in content, f"Source '{src}' NOT found in {pkgbuild_path}."

    # Check for installation commands in package()
    required_installs = [
        "hyprland.conf",
        "banner.txt",
        "chazos-welcome",
    ]
    for inst in required_installs:
        assert inst in content, f"Installation command for '{inst}' NOT found in {pkgbuild_path}."

if __name__ == "__main__":
    try:
        test_pkgbuild_updated()
        print("[PASS] PKGBUILD is updated with Hyprland and welcome assets.")
    except AssertionError as e:
        print(f"[FAIL] {e}")
        exit(1)
