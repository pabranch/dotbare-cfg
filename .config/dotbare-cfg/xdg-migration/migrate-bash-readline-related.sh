#!/usr/bin/env bash
# shellcheck shell=bash

# Copy legacy Bash/Readline files to XDG locations without overwriting files
# that already exist at the destination.
set -u

copy_entry() {
	local source=$1 destination=$2 child

	[ -e "$source" ] || [ -L "$source" ] || return 0
	if [ -d "$source" ] && [ ! -L "$source" ]; then
		if [ -e "$destination" ] && [ ! -d "$destination" ]; then
			printf 'skip (destination is not a directory): %s\n' "$destination" >&2
			return 0
		fi
		mkdir -p "$destination" || return
		for child in "$source"/* "$source"/.[!.]* "$source"/..?*; do
			[ -e "$child" ] || [ -L "$child" ] || continue
			copy_entry "$child" "$destination/${child##*/}" || return
		done
		return 0
	fi

	if [ -e "$destination" ] || [ -L "$destination" ]; then
		printf 'skip (destination exists): %s\n' "$destination"
		return 0
	fi
	mkdir -p "$(dirname -- "$destination")" && cp -pP "$source" "$destination"
}

copy_entry "$HOME/.inputrc" "$HOME/.config/readline/inputrc"
copy_entry "$HOME/.bash_history" "$HOME/.local/state/bash/history"
copy_entry "$HOME/.lesshst" "$HOME/.cache/lesshst"
