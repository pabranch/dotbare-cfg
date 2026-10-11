#!/usr/bin/env bash
set -euo pipefail

config_home="${XDG_CONFIG_HOME:-$HOME/.config}"
target="$config_home/pi"
legacy="$HOME/.pi/agent"

mkdir -p "$config_home"

if [[ -L "$legacy" ]]; then
  if [[ "$legacy" -ef "$target" ]]; then
    echo "Pi config is already at $target"
    exit 0
  fi
  echo "Error: $legacy is a symlink to a different location; leaving it unchanged." >&2
  exit 1
fi

if [[ -e "$target" && ! -d "$target" ]]; then
  echo "Error: $target exists and is not a directory." >&2
  exit 1
fi

if [[ -d "$legacy" ]]; then
  if [[ -e "$target" ]]; then
    echo "Error: both $legacy and $target exist; resolve the config conflict first." >&2
    exit 1
  fi
  mv "$legacy" "$target"
elif [[ ! -d "$target" ]]; then
  mkdir -p "$target"
fi

mkdir -p "$HOME/.pi"
ln -s "$target" "$legacy"
echo "Pi config is now at $target"
