# Specification: Fix Failing GitHub Action

## Overview
The GitHub Action for building the Chazos ISO is failing due to multiple issues:
1. Path mismatches in `chazos_profile/pacman.conf` for the custom repository.
2. Missing `chazos-config` package in the build container.
3. `mkarchiso` errors caused by `profiledef.sh` referencing files that do not exist in the `airootfs/` directory.
4. CI setup issues (sudo, pacman keys).

## Functional Requirements
- Correct the `Server` path in `chazos_profile/pacman.conf` to point to `file://{{PWD}}/chazos_profile/custom_repo`.
- Update `build.yml` to:
    - Install `sudo` in the build container.
    - Initialize and populate `pacman-key` BEFORE `pacman -Syu`.
    - Build `chazos-config` package from `chazos_pkg/chazos-config` and add it to the custom repository.
    - Correct the `sed` command to handle the repository path.
- Cleanup `chazos_profile/profiledef.sh`:
    - Remove permission entries for files that are installed via the `chazos-config` package (e.g., `chazos-install`, `chazos-welcome`, `gui`, `nvidia-wayland.sh`, `99-chazos-iso.conf`).
    - Remove permission entries for files that are missing from `airootfs/` (e.g., `/root/.automated_script.sh`).
    - Keep only permissions for files actually present in `chazos_profile/airootfs/`.

## Functional Goals
- The ISO should successfully build and be uploaded as an artifact in GitHub Actions.
- The build process should be robust and work from a clean checkout.

## Acceptance Criteria
- [ ] GitHub Action "Build Chazos ISO" completes successfully.
- [ ] `chazos-iso` artifact is generated and available for download.
- [ ] `chazos-config` is built and included in the ISO correctly.
- [ ] `profiledef.sh` no longer causes `mkarchiso` to fail.

## Out of Scope
- Adding new features to the ISO.
- Major refactoring of the test suite.
