#!/usr/bin/env bash
set -euo pipefail

usage() {
	echo "Usage: $0 --axis <x|y>" >&2
	exit 1
}

axis=""
while [[ $# -gt 0 ]]; do
	case $1 in
	--axis)
		axis=$2
		shift 2
		;;
	*) usage ;;
	esac
done

[[ $axis == x || $axis == y ]] || usage

var="@layout_save_${axis}"

saved=$(tmux show -wv "$var" 2>/dev/null || true)

if [[ -n $saved ]]; then
	# restore: unset first, then apply — minimises window where a second
	# invocation could read a stale value while layout is mid-transition
	tmux set -wu "$var"
	tmux select-layout "$saved" ||
		tmux display-message "toggle-layout: failed to restore $var"
else
	current=$(tmux display -p '#{window_layout}')
	tmux set -w "$var" "$current"
	if [[ $axis == x ]]; then
		tmux resize-pane -x 100%
	else
		tmux resize-pane -y 100%
	fi
fi
