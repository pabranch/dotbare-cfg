# Plan: Consolidate Bootstrap Documentation

## Goal

Eliminate drift between `.config/dotbare-cfg/README.md` and `bootstrap-cfg.sh` while keeping setup understandable and auditable.

## Implementation

1. Treat the tested bootstrap script as the authoritative implementation.
2. Update the README to explain prerequisites, invocation, effects, backup location, collision policy, and recovery rather than duplicating every command.
3. Keep manual commands only where they are useful for troubleshooting or auditing the script.
4. Align repository URLs, quoting, branch behavior, and restore instructions.
5. Explain that the bare repository hides untracked files and that new files must be explicitly added.
6. Clarify whether bootstrap should reset to `origin/main`, a host branch, or a selected platform branch.
7. Remove the existing TODO item only after the documentation and script agree.

## Validation

- Follow the README from a disposable home directory.
- Confirm every documented command matches actual script behavior.
- Ask a fresh reader to identify what will be overwritten, backed up, and restored before running it.
