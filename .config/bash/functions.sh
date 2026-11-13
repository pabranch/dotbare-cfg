# shellcheck shell=bash

init-git() {
	if [ "$#" -gt 1 ]; then
		echo 'Usage: init-git [directory]' >&2
		return 2
	fi

	local directory="${1:-.}"
	if [ -e "$directory/.git" ] || [ -L "$directory/.git" ] ||
		[ "$(git -C "$directory" rev-parse --is-bare-repository 2>/dev/null)" = true ]; then
		echo "init-git: repository already exists: $directory" >&2
		return 1
	fi

	git init -- "$directory" &&
		git -C "$directory" config --local core.ignorecase false &&
		git -C "$directory" commit --allow-empty -m 'First!' &&
		git -C "$directory" tag first
}

manage_alias() {
	local name="$1"
	local command="$2"
	local alias_def

	# If command is provided, define it temporarily to get its formatted definition
	if [ -n "$command" ]; then
		# Capture the supplied command now, matching the alias being persisted.
		# shellcheck disable=SC2139
		alias "$name=$command"
	fi

	# Get the official alias definition from the shell
	alias_def=$(alias "$name" 2>/dev/null)

	if [ -z "$alias_def" ]; then
		echo "Error: Alias '$name' is not defined."
		return 1
	fi

	# Remove existing definition from ~/.config/bash/aliases.sh if it exists
	# We search for the specific alias name definition line
	if grep -q "^alias $name=" ~/.config/bash/aliases.sh; then
		# Use a temporary file to handle sed portability between Linux/macOS
		grep -v "^alias $name=" ~/.config/bash/aliases.sh >~/.config/bash/aliases.sh.tmp
		mv ~/.config/bash/aliases.sh.tmp ~/.config/bash/aliases.sh
		echo "Updating alias '$name' in ~/.config/bash/aliases.sh..."
	else
		echo "Adding alias '$name' to ~/.config/bash/aliases.sh..."
	fi

	# Append the definition to ~/.config/bash/aliases.sh
	echo "$alias_def" >>~/.config/bash/aliases.sh
}

# Add an existing directory to a colon-separated variable without duplicates.
# Existing empty entries are preserved, but no new empty entries are added.
_add_path() {
	if [ "$#" -ne 3 ] || [[ ! "$2" =~ ^[a-zA-Z_][a-zA-Z0-9_]*$ ]] ||
		[[ "$2" == __path_* ]]; then
		echo 'Usage: append_path|prepend_path VARIABLE directory (VARIABLE must not start with __path_)' >&2
		return 2
	fi

	local __path_mode="$1" __path_name="$2" __path_directory="$3" __path_value
	if [[ "$__path_directory" == *:* ]]; then
		echo 'Path entries cannot contain colons.' >&2
		return 2
	fi
	[ -d "$__path_directory" ] || return 1

	__path_value="${!__path_name-}"
	[[ ":$__path_value:" == *":$__path_directory:"* ]] && return 0

	if [ -z "$__path_value" ]; then
		printf -v "$__path_name" '%s' "$__path_directory"
	elif [ "$__path_mode" = append ]; then
		printf -v "$__path_name" '%s' "$__path_value:$__path_directory"
	else
		printf -v "$__path_name" '%s' "$__path_directory:$__path_value"
	fi
}

append_path() {
	_add_path append "$@"
}

prepend_path() {
	_add_path prepend "$@"
}
