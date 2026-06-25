# Agent Instructions

High-signal details for AI agents working in this repository.

## The `cfg` Bare Git Paradigm
- **Repo Structure:** This is a `dotfiles` repository managed via a bare Git repo at `$HOME/.cfg` with work-tree `$HOME`.
- **Untracked Files Hidden:** `status.showUntrackedFiles` is set to `no` on the bare repo. `cfg status` or `git status` in `$HOME` **will not show untracked files**.
  - **Action:** If adding a new file to the dotfiles config, you must stage/add it explicitly by absolute path (e.g., `cfg add ~/.tmux.conf`).
- **Git Alias Wrapper:** In the interactive shell, `g` falls back to `cfg` if not in a standard Git repository. When writing scripts or running commands, invoke `cfg` directly rather than standard `git`.

## Environment & Platform Architecture
- **Bash 4+ Requirement:** `detect_platform()` requires Bash version 4 or higher (relying on `${var,,}` and `BASH_VERSINFO`). It will fail on older versions (like default macOS Bash).
- **Platform Separation:**
  - Common configuration resides in `.bashrc`.
  - Platform-specific initialization should be placed in `~/.local/lib/init-<platform>.sh` (where `<platform>` is one of: `linux`, `macos`, `msys`, `cygwin`).
  - WSL-specific utilities reside in `~/.local/lib/wsl.sh`.
  - Windows PowerShell profile is stored at `.config/dotbare-cfg/Microsoft.PowerShell_profile.ps1`.

## Storing Package State
- Homebrew packages are tracked in `.config/dotbare-cfg/all-brewed`.
- Scoop packages are tracked in `.config/dotbare-cfg/all-scooped`.
- **Tracking commands (from `runtime.sh`):** Use the following aliases/functions to sync or diff state:
  - Brew: `diff-brewed`, `update-all-brewed`
  - Scoop: `diff-scooped`, `update-all-scooped`

## Shell Quality Standards
- **Linting:** All shell scripts (`.bashrc`, `.local/lib/*.sh`, etc.) must pass `shellcheck`. Use `# shellcheck shell=bash` at the top of sourced scripts.
- **Formatting:** Keep scripts formatted with `shfmt`.
