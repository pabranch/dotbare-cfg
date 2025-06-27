# shellcheck shell=bash
# library - source only
# portable shell runtime helpers

# Platform detection (returns one of: linux, macos, msys, cygwin)
detect_platform() {
	local platform="${OSTYPE:-$(uname -s)}"
	# normalize to all lowercase
	platform="${platform,,}"
	case "$platform" in
	msys* | mingw*) echo 'msys' ;;
	cygwin*) echo 'cygwin' ;;
	darwin*) echo 'macos' ;;
	linux*) echo 'linux' ;;
	*)
		echo "${BASH_SOURCE[*]}: WARNING - unknown platform '$platform'" >&2
		echo "$platform"
		;;
	esac
}

# run all commands in a file if it exists
# should fail if it is not a file or readable!
_source_if_exists() {
	local filename=${1?no filename specified}
	[ -e $filename ] && . $filename
}

# check if command exists
_is_command() {
	local commandname=${1?no command specified}
	command -v "$commandname" >/dev/null
}

# Dynamically create 'outdated' alias for available package managers
_outdated() {
	local outdated_cmd=""
	if _is_command brew; then
		outdated_cmd+='echo "-> brew ..."; brew update-if-needed &>/dev/null \
      && brew outdated'
		alias brewed='sort <(brew leaves; brew list --cask)'
		alias all-brewed='cat ~/.config/dotbare-cfg/all-brewed'
		alias diff-brewed='diff <(brewed) <(all-brewed)'
		alias update-all-brewed='tf=$(mktemp); sort -u <(all-brewed; brewed) >$tf; \
      mv $tf ~/.config/dotbare-cfg/all-brewed; unset tf'
	fi
	if _is_command apt; then
		[[ -n $outdated_cmd ]] && outdated_cmd+='; '
		outdated_cmd+='echo "-> apt ..."; sudo apt-get update &>/dev/null && sudo apt list --upgradeable'
	fi
	if _is_command scoop; then
		[[ -n $outdated_cmd ]] && outdated_cmd+='; '
		outdated_cmd+='echo "-> scoop ..."; scoop update --all &>/dev/null && scoop status'
		alias scooped='scoop list | awk '\''NR>4&&NF{print $1}'\'''
		alias all-scooped='cat ~/.config/dotbare-cfg/all-scooped'
		alias diff-scooped='diff <(scooped) <(all-scooped)'
		alias update-all-scooped='tf=$(mktemp); sort -u <(all-scooped; scooped) >$tf; mv $tf ~/.config/dotbare-cfg/all-scooped; unset tf'
	fi
	if _is_command winget; then
		[[ -n $outdated_cmd ]] && outdated_cmd+='; '
		outdated_cmd+='echo "-> winget ..."; winget.exe source update &>/dev/null && winget.exe upgrade --include-unknown'
		alias wingot='winget.exe ls | grep "winget$"'
		alias all-wingot='cat ~/.config/dotbare-cfg/all-wingot'
		alias diff-wingot='diff <(wingot) <(all-wingot)'
		alias update-all-wingot='tf=$(mktemp); sort -u <(all-wingot; wingot) >$tf; mv $tf ~/.config/dotbare-cfg/all-wingot; unset tf'
	fi
	if [[ -n $outdated_cmd ]]; then
		alias outdated="$outdated_cmd"
	else
		alias outdated='echo "No supported package manager found."'
		return 1
	fi
}
