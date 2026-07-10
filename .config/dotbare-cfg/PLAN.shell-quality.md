# Plan: Shell Quality Compliance

## Goal

Make tracked shell files satisfy the standards documented in `AGENTS.md`.

## Implementation

1. Run `shellcheck` over `.bashrc`, `.profile`, `.local/lib/*.sh`, `.tmux/scripts/*.sh`, and shell scripts under `.config/dotbare-cfg`.
2. Add an appropriate shebang or `# shellcheck shell=bash` directive to `.profile` and `.config/dotbare-cfg/wsl-uidmap-podman.sh`.
3. Quote the hostname command substitution in `bootstrap-cfg.sh` and use portable character classes with `tr`.
4. Replace the `.bashrc` `A && B || C` construct with an explicit conditional.
5. Add narrowly scoped ShellCheck suppressions only for deliberate dynamic sourcing that cannot be resolved statically.
6. Run `shfmt` and review every formatting change before applying it.
7. Avoid changing runtime behavior while performing lint-only cleanup.

## Validation

- `shellcheck` exits successfully for every tracked shell file.
- `shfmt -d` produces no output.
- `bash -n` succeeds for every Bash file.
- Start an isolated interactive shell to detect sourcing regressions.
