#!/usr/bin/env bash
# shellcheck shell=bash

# Copy the legacy Git configuration to its native XDG location without
# overwriting an existing destination.
set -u

source=$HOME/.gitconfig
destination=$HOME/.config/git/config

if [ -e "$source" ] || [ -L "$source" ]; then
	if [ -e "$destination" ] || [ -L "$destination" ]; then
		printf 'skip (destination exists): %s\n' "$destination"
	else
		mkdir -p "$(dirname -- "$destination")" && cp -pP "$source" "$destination"
	fi
fi
