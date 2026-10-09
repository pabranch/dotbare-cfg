# XDG Migration (Completed)

These migration instructions have been applied on `main`. They are kept as
historical reference, not as pending work.

| Area             | Canonical location                          |
|------------------|---------------------------------------------|
| Bash / Readline  | `.config/readline/inputrc`                  |
| Git              | `.config/git/config`                        |
| Vim state        | `.local/state/vim/viminfo`                  |
| Vim packages     | `.local/share/vim/pack/`                    |
| Tmux config      | `.config/tmux/`                             |
| Tmux plugins     | `.local/share/tmux/plugins`                 |

The `*.yaml` files describe the original migrations (with pre-move source
paths), and `launch.sh` was the runner. Do not re-run them against a home
directory that has already migrated.
