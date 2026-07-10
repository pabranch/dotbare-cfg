# Plan: Automated Configuration Validation

## Goal

Provide one repeatable command, and optionally CI, for detecting broken shell, Vim, and tmux configuration.

## Implementation

1. Add a validation script under `.config/dotbare-cfg` that discovers the intended tracked files rather than relying on an undocumented local list.
2. Run `shellcheck`, `shfmt -d`, and `bash -n` for shell configuration.
3. Test `.vimrc` using the current working copy and an isolated temporary directory. Redirect plugin destinations and avoid changing installed plugins or the real home directory.
4. Validate `.tmux.conf` with an isolated tmux socket/server and temporary environment; do not affect active sessions.
5. Report skipped optional checks clearly when a required tool is unavailable, and distinguish skips from failures.
6. Ensure temporary files and servers are cleaned up on success, failure, and interruption.
7. Document the command in the repository README. Consider adding a GitHub Actions workflow after the local command is stable.

## Validation

- The command succeeds on the supported baseline.
- Deliberately introduce one shell, Vim, and tmux error in turn and verify each is detected.
- Confirm the working tree and user configuration remain untouched after execution.
