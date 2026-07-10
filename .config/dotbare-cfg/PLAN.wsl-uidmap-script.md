# Plan: Proper WSL uidmap Script

## Goal

Turn `.config/dotbare-cfg/wsl-uidmap-podman.sh` from a two-line command note into a safe, self-describing script.

## Implementation

1. Add a Bash shebang, strict mode, and a short purpose comment.
2. Detect that the script is running in an apt-based WSL environment before using `sudo`.
3. Use noninteractive-safe package commands where appropriate and avoid unnecessary updates when the package is already installed.
4. Print the operation before requesting elevation.
5. Decide whether the file should be executable; set its Git mode consistently.
6. If it is intended only as documentation, rename or move it instead of presenting it as an executable script.

## Validation

- Run `shellcheck`, `shfmt -d`, and `bash -n`.
- Test detection paths without changing packages, then test installation in a disposable WSL environment.
