#!/usr/bin/env bash

# Check and cache Developer Mode status
_check_dev_mode() {
	if [[ -n "$WINDOWS_DEVELOPER_MODE" ]]; then
		if [[ "$WINDOWS_DEVELOPER_MODE" == "0" ]]; then
			echo "❌ Developer Mode is DISABLED."
		else
			echo "✅ Developer Mode is ENABLED."
		fi
	fi

	local output
	output=$(reg query "HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\AppModelUnlock" /v AllowDevelopmentWithoutDevLicense 2>/dev/null)

	if [[ "$output" =~ "0x1" ]]; then
		echo "✅ Developer Mode is ENABLED."
		export WINDOWS_DEVELOPER_MODE=1
		return 0
	else
		echo "❌ Developer Mode is DISABLED."
		echo "ℹ️ To enable: go to Settings → For Developers → toggle 'Developer Mode'"
		export WINDOWS_DEVELOPER_MODE=0
		return 1
	fi
}

_setup_git_symlink_support() {
	# Check Developer Mode if not already cached
	if [[ -z "$WINDOWS_DEVELOPER_MODE" ]]; then
		_check_dev_mode || {
			echo "❌ Skipping: Developer Mode is not enabled."
			return 1
		}
	elif [[ "$WINDOWS_DEVELOPER_MODE" != "1" ]]; then
		echo "❌ Skipping: Developer Mode is disabled."
		return 1
	fi

	# Check MSYS mode
	if [[ "$MSYS" != *winsymlinks:native* ]]; then
		echo "❌ Skipping: MSYS is not set to use native symlinks."
		echo "💡 Run: export MSYS=winsymlinks:native"
		return 1
	fi

	# Set global Git config
	git config --global core.symlinks true
	echo "✅ Git global config updated: core.symlinks = true"
}

# 🧪 Check link target details using fsutil
_check_link() {
	local path="$1"
	if [[ -z "$path" ]]; then
		echo "❌ Usage: _check_link <file-or-dir>"
		return 1
	fi

	fsutil reparsepoint query "$path" 2>&1
}

# 🔗 Symlink creation with Developer Mode enforcement
_ln() {
	if [[ -z "$WINDOWS_DEVELOPER_MODE" ]]; then
		_check_dev_mode || return 1
	elif [[ "$WINDOWS_DEVELOPER_MODE" != "1" ]]; then
		echo "⚠️ Developer Mode is NOT enabled. Aborting symlink creation."
		return 1
	fi

	command \\ln "$@"
}

# Example usage note
# _ln target.txt linkname.txt
# _check_link linkname.txt

alias ln=_ln
alias check-link=_check-link
