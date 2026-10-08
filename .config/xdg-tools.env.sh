# shellcheck shell=sh
# Tool-specific XDG relocations.
# Sourced from ~/.profile (login shells) and ~/.bashrc (interactive shells).
#
# Only variables whose target directories already exist / are moved belong
# here. Big relocations are listed commented-out at the bottom and should be
# uncommented as each tool's directory is moved (step 4 of the migration).

# --- moved in step 3 -------------------------------------------------------

# readline (was ~/.inputrc)
INPUTRC="$HOME/.config/readline/inputrc"
export INPUTRC

# bash history (was ~/.bash_history)
HISTFILE="$HOME/.local/state/bash/history"
export HISTFILE

# less history (was ~/.lesshst)
LESSHISTFILE="$HOME/.cache/lesshst"
export LESSHISTFILE

# --- XDG_RUNTIME_DIR fallback ---------------------------------------------
# The spec defines no default. systemd/display managers set it; bare
# sessions (startx, tmux, cron) do not.
if [ -z "${XDG_RUNTIME_DIR:-}" ]; then
	XDG_RUNTIME_DIR="/tmp/runtime-$(id -u)"
	export XDG_RUNTIME_DIR
	[ -d "$XDG_RUNTIME_DIR" ] || mkdir -p "$XDG_RUNTIME_DIR"
	chmod 700 "$XDG_RUNTIME_DIR" 2>/dev/null || true
fi

# --- step 4 (big moves): uncomment each after moving its directory ---------
# export CARGO_HOME="$HOME/.local/share/cargo"
# export RUSTUP_HOME="$HOME/.local/share/rustup"
# export GNUPGHOME="$HOME/.local/share/gnupg"
# export BUN_INSTALL="$HOME/.local/share/bun"
# export BUNDLE_USER_HOME="$HOME/.local/share/bundle"
# export ANSIBLE_HOME="$HOME/.local/share/ansible"
# export DOTNET_CLI_HOME="$HOME/.local/share/dotnet"
# export NUGET_PACKAGES="$HOME/.local/share/nuget/packages"
# export PARALLEL_HOME="$HOME/.local/share/parallel"
# export npm_config_cache="$HOME/.cache/npm"
# export NPM_CONFIG_USERCONFIG="$HOME/.config/npm/npmrc"
# export PI_CODING_AGENT_DIR="$HOME/.config/pi"
# export PI_CODING_AGENT_SESSION_DIR="$HOME/.local/share/pi/sessions"
# export CLAUDE_CONFIG_DIR="$HOME/.config/claude"
export TMUX_PLUGIN_MANAGER_PATH="$HOME/.local/share/tmux/plugins"
