#!/usr/bin/env bash

# Change Windows theme: Light or Dark
set_windows_theme() {
	local theme="$1"
	local restart="${2:-false}"

	if [[ "$theme" != "Light" && "$theme" != "Dark" ]]; then
		echo "❌ Invalid theme. Use 'Light' or 'Dark'."
		return 1
	fi

	local value="0"
	[[ "$theme" == "Light" ]] && value="1"

	echo "🖼️ Switching Windows theme to $theme..."

	reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v SystemUsesLightTheme /t REG_DWORD /d "$value" /f >/dev/null
	reg add "HKCU\\Software\\Microsoft\\Windows\\CurrentVersion\\Themes\\Personalize" /v AppsUseLightTheme /t REG_DWORD /d "$value" /f >/dev/null

	if [[ "$restart" == "true" ]]; then
		echo "🔁 Restarting Explorer shell..."
		taskkill /f /im explorer.exe >/dev/null
		start explorer.exe
	fi

	echo "✅ Theme applied."
}

# Example usage:
# set_windows_theme Dark true
# set_windows_theme Light
