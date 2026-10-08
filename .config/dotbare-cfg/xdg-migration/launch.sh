#!/usr/bin/env bash
# shellcheck shell=bash

set -u

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
repo_root=$(cd -- "$script_dir/../../.." && pwd)
base_branch=xdg-migration-instructions

printf '%s\n' \
	'1) Bash / Readline' \
	'2) Git' \
	'3) Vim' \
	'4) Tmux' \
	'5) Quit'

read -r -p 'Select a migration [1-5]: ' choice

case $choice in
1)
	migration=bash-readline
	branch=migrate-bash-readline
	;;
2)
	migration=git
	branch=migrate-git
	;;
3)
	migration=vim
	branch=migrate-vim
	;;
4)
	migration=tmux
	branch=migrate-tmux
	;;
5)
	exit 0
	;;
*)
	printf 'Invalid selection.\n' >&2
	exit 2
	;;
esac

instruction=".config/dotbare-cfg/xdg-migration/$migration.yaml"
prompt='Implement this migration from the current worktree state. Commit the changes on this branch. Do not push.'

if git -C "$repo_root" show-ref --verify --quiet "refs/heads/$branch"; then
	exec wt -C "$repo_root" switch "$branch" -x pi -- -p "@$instruction" "$prompt"
fi

exec wt -C "$repo_root" switch --create --base "$base_branch" "$branch" \
	-x pi -- -p "@$instruction" "$prompt"
