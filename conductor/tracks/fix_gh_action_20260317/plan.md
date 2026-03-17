# Implementation Plan: Fix Failing GitHub Action

## Phase 1: Correct Configuration & Cleanup
This phase focuses on correcting the repository paths and cleaning up the `profiledef.sh` permissions to satisfy `mkarchiso`'s requirements.

- [ ] Task: Correct repository path in `chazos_profile/pacman.conf`
    - [ ] Update `Server = file://{{PWD}}/custom_repo` to `Server = file://{{PWD}}/chazos_profile/custom_repo`
- [ ] Task: Cleanup `chazos_profile/profiledef.sh` permissions
    - [ ] Remove `["/root/.automated_script.sh"]="0:0:755"`
    - [ ] Remove entries for files installed via `chazos-config` (`chazos-install`, `chazos-welcome`, `gui`, `nvidia-wayland.sh`, `99-chazos-iso.conf`)
    - [ ] Ensure only files existing in `chazos_profile/airootfs/` are listed.
- [ ] Task: Verify `profiledef.sh` consistency
    - [ ] Run a script to check that all files in `profiledef.sh` exist in `chazos_profile/airootfs/`.
- [ ] Task: Conductor - User Manual Verification 'Correct Configuration & Cleanup' (Protocol in workflow.md)

## Phase 2: Update GitHub Action Workflow
This phase focuses on updating `build.yml` to correctly set up the environment and build all necessary packages.

- [ ] Task: Update `build.yml` to include `sudo` and correct `pacman-key` sequence
    - [ ] Add `sudo` to the dependency installation step.
    - [ ] Move `pacman-key --init` and `--populate archlinux` to before `pacman -Syu`.
- [ ] Task: Update `build.yml` to build `chazos-config`
    - [ ] Add a step to build the `chazos-config` package from `chazos_pkg/chazos-config`.
    - [ ] Add the built `chazos-config` package to the custom repository using `repo-add`.
- [ ] Task: Correct `sed` command in `build.yml`
    - [ ] Ensure it correctly replaces `{{PWD}}` in `chazos_profile/pacman.conf`.
- [ ] Task: Conductor - User Manual Verification 'Update GitHub Action Workflow' (Protocol in workflow.md)

## Phase 3: Verification & Finalization
This phase focuses on verifying the fixes by triggering the GitHub Action.

- [ ] Task: Trigger GitHub Action and monitor build
    - [ ] Push changes and check the Action status.
- [ ] Task: Verify ISO artifact
    - [ ] Ensure the artifact is generated and contains the expected configurations.
- [ ] Task: Conductor - User Manual Verification 'Verification & Finalization' (Protocol in workflow.md)
