# Agent Instructions

High-signal details for AI agents working in this (dotbare-cfg) repository.

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

## Vim Configuration
- `.vimrc` bootstraps `vim-tmux-navigator` with a shallow clone into `~/.vim/pack/plugins/start/vim-tmux-navigator` when that directory is absent.
- Clone failures must not abort the rest of `.vimrc`. Capture stderr along with stdout, use `systemlist()`, and report each line with `echomsg` under `ErrorMsg` highlighting.
- Set `encoding` and `scriptencoding` near the top of `.vimrc`, before Vim interprets non-ASCII characters such as the symbols used by `listchars`.
- Test startup changes against the current working copy in an isolated temporary directory. Redirect the plugin destination there, alter the clone command to force failures when needed, launch Vim with `-Nu`, and capture `:messages`. Do not require the user to copy `.vimrc` into `$HOME` or remove their installed plugins.

## Tmux Navigation
- Unprefixed `Ctrl-h/j/k/l` uses `vim-tmux-navigator` to move among Vim splits and tmux panes. `pi` is intentionally absent from `@vim_navigator_pattern`, so it does not consume these unprefixed navigation keys.
- Prefix followed by `Ctrl-h/j/k/l` explicitly sends the corresponding key to the active application, providing an escape hatch for applications that need to receive it directly.

## Branch and Push Workflow
- Default to working on `main`; assume changes are cross-platform unless Perry explicitly identifies them as macOS-specific.
- Put macOS-specific changes on `macos`, which must remain rebased onto `origin/main`.
- After pushing an update to `origin/main`, rebase `macos` onto the updated `main` and push it with `--force-with-lease` so `origin/macos` remains current.
- Never use an unconditional force push.
- Do not push commits or rewritten branches until the user explicitly asks.

## Shell Quality Standards
- **Linting:** All shell scripts (`.bashrc`, `.local/lib/*.sh`, etc.) must pass `shellcheck`. Use `# shellcheck shell=bash` at the top of sourced scripts.
- **Formatting:** Keep scripts formatted with `shfmt`.
