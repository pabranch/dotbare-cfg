# shellcheck shell=bash
# library - do not execute
# portable shell runtime helpers

# Cross-platform realpath fallback
realpath_fallback() {
	local target="$1"
	local dir file
	target="${target%/}"

	if [ -d "$target" ]; then
		(cd "$target" 2>/dev/null && pwd -P)
		return
	fi

	dir=$(dirname -- "$target")
	file=$(basename -- "$target")
	(cd "$dir" 2>/dev/null && echo "$(pwd -P)/$file")
}

# Robust script directory resolution
get_script_dir() {
	local source="${BASH_SOURCE[1]}"
	while [ -L "$source" ]; do
		local dir
		dir=$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)
		source="$(readlink "$source")"
		[[ $source != /* ]] && source="$dir/$source"
	done
	realpath_fallback "$(dirname "$source")"
}

# Platform detection (returns one of: linux, macos, msys, cygwin)
detect_platform() {
	local platform="${OSTYPE:-$(uname -s)}"
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
