# Plan: Cross-Platform Common Configuration

## Goal

Make the boundary between portable `main` configuration and platform branches explicit and safe.

## Implementation

1. Inventory commands and options in `.bashrc`, `.profile`, `.vimrc`, and `.tmux.conf` that differ among GNU/Linux, macOS, MSYS, Cygwin, and WSL.
2. Address the unconditional GNU `ls --ignore` alias in `.bashrc`; move it to platform initialization or select supported options dynamically.
3. Audit fixed executable and installation paths such as `/usr/bin/lesspipe`, Homebrew prefixes, `/bin/bash`, and Linuxbrew FZF.
4. Keep common behavior in shared files and put true platform differences in `.local/lib/init-<platform>.sh`.
5. Document whether platform branches are deployment branches or merely historical overlays. Avoid relying on an implicit branch patch for basic shell startup.
6. Preserve useful optional-command guards and local override files.

## Validation

- Source configuration in isolated environments representing each supported platform where practical.
- At minimum, add mocked command/path tests for unavailable platforms.
- Confirm `main` does not invoke known unsupported options before platform-specific initialization can correct them.
