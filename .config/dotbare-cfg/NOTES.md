# Project Assessment Notes

Observations from the 2026-07-10 review that do not require implementation tasks or additions to `AGENTS.md`.

## Strengths to Preserve

- The repository is compact enough to understand without a configuration framework.
- Common configuration and platform-specific initialization have a clear intended separation.
- The tmux/Vim navigation model is coherent and documented.
- `.PERRY.md` and `.config/dotbare-cfg/AGENTS.md` provide high-signal operational guidance for coding agents.
- Optional command integrations are generally guarded by command-existence checks.
- `.bashrc.local` and `.vimrc.local` provide useful local override points.
- Shell runtime helpers are sensibly extracted into `.local/lib/runtime.sh`.
- Git workflow favors disciplined commits and `--force-with-lease` after history rewrites.
- SSH legacy RSA allowances are scoped to the `teacup` host rather than enabled globally.
- The package inventories and their diff/update aliases provide useful state tracking even before restoration is automated.

## Review Results

- The working tree was clean and `main` matched `origin/main` at review time.
- All reviewed Bash files passed `bash -n`.
- `.vimrc` completed a headless startup test successfully in the current environment.
- ShellCheck and shfmt findings are recorded as actionable TODO plans rather than reproduced here.
- `.tmux.conf` has had the most recent churn; changes there deserve isolated startup tests.

## Tmux Configuration & Pi Compatibility

- **Extended Keys:** `set -g extended-keys on` and `set -g extended-keys-format csi-u` forward modifier keys (`Shift+Enter`, `Ctrl+Enter`) properly to interactive tools like `pi`.
- **Compatibility:** `extended-keys-format csi-u` requires tmux 3.5+. (falls back to `xterm`/`modifyOtherKeys`). Requires terminal emulator support (Ghostty, Kitty, WezTerm, iTerm2, Alacritty, Windows Terminal).
- **Keybindings:** `C-M-z` and `M-z` both toggle zoom
- **Continuum:** Boot automation (`@continuum-boot`) is omitted to avoid startup delays

