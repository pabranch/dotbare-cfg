# Plan: Safe Bootstrap Backups

## Goal

Make `.config/dotbare-cfg/bootstrap-cfg.sh` reliably back up every conflicting tracked path before configuration is restored.

## Implementation

1. Reproduce the current failure with a disposable `HOME` containing a nested conflict such as `.config/starship.toml`.
2. Replace line-oriented parsing of `cfg status -s` with a NUL-delimited Git command that safely handles spaces, unusual characters, deletions, and renames.
3. For every source path, create its parent directory beneath `$HOME/.cfg-backup` before copying it.
4. Preserve file metadata and handle directories or symbolic links intentionally; document the chosen behavior.
5. Do not overwrite an earlier backup silently. Either use a timestamped backup root or define and document another collision policy.
6. Ensure failures stop the bootstrap before any destructive restore/reset step.
7. Extract backup logic into testable functions if that makes isolated testing simpler.

## Validation

- Run in a temporary `HOME`; never test destructively against the real home directory.
- Cover nested paths, spaces, symlinks, deleted paths, and an empty conflict set.
- Run `shellcheck`, `shfmt -d`, and `bash -n` on the final script.
