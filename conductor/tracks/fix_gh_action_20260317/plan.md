# Implementation Plan: Fix Failing GitHub Action

## Phase 1: Correct Configuration & Cleanup [checkpoint: 3495732]
This phase focuses on correcting the repository paths and cleaning up the `profiledef.sh` permissions to satisfy `mkarchiso`'s requirements.

- [x] Task: Correct repository path in `chazos_profile/pacman.conf` c07839b
    - [ ] Update `Server = file://{{PWD}}/custom_repo` to `Server = file://{{PWD}}/chazos_profile/custom_repo`
- [x] Task: Cleanup `chazos_profile/profiledef.sh` permissions b585b5d
    - [ ] Remove `["/root/.automated_script.sh"]="0:0:755"`
    - [ ] Remove entries for files installed via `chazos-config` (`chazos-install`, `chazos-welcome`, `gui`, `nvidia-wayland.sh`, `99-chazos-iso.conf`)
    - [ ] Ensure only files existing in `chazos_profile/airootfs/` are listed.
- [x] Task: Verify `profiledef.sh` consistency b585b5d
    - [ ] Run a script to check that all files in `profiledef.sh` exist in `chazos_profile/airootfs/`.
- [x] Task: Conductor - User Manual Verification 'Correct Configuration & Cleanup' (Protocol in workflow.md)

## Phase 2: Update GitHub Action Workflow [checkpoint: 01b2027]
This phase focuses on updating `build.yml` to correctly set up the environment and build all necessary packages.

- [x] Task: Update `build.yml` to include `sudo` and correct `pacman-key` sequence 13e6118
    - [ ] Add `sudo` to the dependency installation step.
    - [ ] Move `pacman-key --init` and `--populate archlinux` to before `pacman -Syu`.
- [x] Task: Update `build.yml` to build `chazos-config` e46d64b
    - [ ] Add a step to build the `chazos-config` package from `chazos_pkg/chazos-config`.
    - [ ] Add the built `chazos-config` package to the custom repository using `repo-add`.
- [x] Task: Correct `sed` command in `build.yml` e46d64b
    - [ ] Ensure it correctly replaces `{{PWD}}` in `chazos_profile/pacman.conf`.
- [x] Task: Conductor - User Manual Verification 'Update GitHub Action Workflow' (Protocol in workflow.md)

## Phase 3: Verification & Finalization
This phase focuses on verifying the fixes by triggering the GitHub Action.

- [ ] Task: Trigger GitHub Action and monitor build
    - [ ] Push changes and check the Action status.
- [ ] Task: Verify ISO artifact
    - [ ] Ensure the artifact is generated and contains the expected configurations.
- [ ] Task: Conductor - User Manual Verification 'Verification & Finalization' (Protocol in workflow.md)
