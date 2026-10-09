# Plan: Portable Vim Startup

## Goal

Keep `.vimrc` usable on a fresh machine and across supported platforms without hiding actionable failures.

## Implementation

1. Guard `colorscheme codedark` with an availability check. Decide whether a missing theme should trigger installation, a warning, or a fallback colorscheme.
2. Replace the hard-coded Linuxbrew FZF runtime path with discovery based on `brew --prefix fzf`, standard install locations, or an environment/local override.
3. Set `/bin/bash` only when it exists, or derive a suitable shell while preserving the workaround for Vim temporary-file errors.

## Done

- The `vim-tmux-navigator` clone URL now uses HTTPS instead of SSH.
- Clone failures are surfaced with readable `:messages` output without aborting `.vimrc` sourcing.
- Plugin bootstrap already skips network work once the destination directory exists.

## Validation

- Test the current file in isolated temporary homes with the theme, FZF, Bash, Git, and network access absent in turn.
- Capture `:messages` and verify startup continues with useful diagnostics.
- Verify navigation still works both inside and outside tmux.
