#!/bin/bash

set -e
shopt -s expand_aliases

#set -x; trap 'set +x' EXIT

cd ~

# Initialize bare Git repository if it doesn't already exist
if [ ! -d "$HOME/.cfg" ]; then
  git init --bare "$HOME/.cfg" --initial-branch=$(hostname | tr 'A-Z' 'a-z')
fi

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Only append alias to .bashrc if it isn't already present
if ! grep -q "alias cfg=" "$HOME/.bashrc" 2>/dev/null; then
  echo "alias cfg='git --git-dir=\$HOME/.cfg/ --work-tree=\$HOME'" >> "$HOME/.bashrc"
fi

cfg config --local status.showUntrackedFiles no

# Set or update remote origin gracefully
cfg remote add origin ssh://git@github.com/pabranch/dotbare-cfg 2>/dev/null || \
  cfg remote set-url origin ssh://git@github.com/pabranch/dotbare-cfg

cfg remote update
cfg reset origin/main

# Backup any existing conflicting dotfiles
mkdir -p "${HOME}/.cfg-backup" &&
  cfg status -s 2>&1 |
  awk '/^[ AMUD][ AMU]/{print $2}' |
  xargs -I{} cp "${HOME}/{}" "${HOME}/.cfg-backup/{}"

ls -Al .cfg-backup
cfg status

printf "\nUse 'cfg restore .' to reset the config files\n"
