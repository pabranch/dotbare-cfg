# Plan: Tmux Plugin Bootstrap Diagnostics

## Goal

Make tmux plugin-manager installation failures visible and actionable without breaking unrelated tmux configuration.

## Implementation

1. Review the current `if`/`if-shell` bootstrap commands at the bottom of `.tmux.conf`.
2. Use a shallow clone where compatible and avoid retrying when the destination is already valid.
3. Capture clone and plugin-install output in a predictable log under the configuration or state directory.
4. Display a concise tmux message on failure that points to the log; do not silently append only a generic message to `~/tmux-errors.log`.
5. Handle partial destination directories so a failed first clone does not permanently prevent retries.
6. Keep plugin-manager initialization at the bottom of the file.

## Validation

- Use an isolated tmux server and temporary home/plugin directory.
- Test missing Git, invalid remote, failed plugin installation, partial directories, and successful initialization.
- Confirm active tmux sessions are never touched by tests.
