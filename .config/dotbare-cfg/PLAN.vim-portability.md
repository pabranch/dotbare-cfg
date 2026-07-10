# Plan: Portable Vim Startup

## Goal

Keep `.vimrc` usable on a fresh machine and across supported platforms without hiding actionable failures.

## Implementation

1. Guard `colorscheme codedark` with an availability check. Decide whether a missing theme should trigger installation, a warning, or a fallback colorscheme.
2. Replace the hard-coded Linuxbrew FZF runtime path with discovery based on `brew --prefix fzf`, standard install locations, or an environment/local override.
3. Set `/bin/bash` only when it exists, or derive a suitable shell while preserving the workaround for Vim temporary-file errors.
4. Review the SSH-only `vim-tmux-navigator` clone URL. Retain it if SSH access is a prerequisite; otherwise consider HTTPS or configurable transport.
5. Preserve current clone failure behavior: capture stderr, display readable lines, and continue sourcing `.vimrc`.
6. Avoid unnecessary network work after the plugin has been installed.

## Validation

- Test the current file in isolated temporary homes with the theme, FZF, Bash, Git, and network access absent in turn.
- Capture `:messages` and verify startup continues with useful diagnostics.
- Verify navigation still works both inside and outside tmux.
