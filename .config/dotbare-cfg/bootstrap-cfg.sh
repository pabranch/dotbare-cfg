#!/bin/bash

set -e
shopt -s expand_aliases

#set -x; trap 'set +x' EXIT

cd ~
### from README
git init --bare $HOME/.cfg --initial-branch=$(hostname | tr [:upper:] [:lower:])

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo "$(alias cfg)" >> $HOME/.bashrc

cfg config --local status.showUntrackedFiles no

cfg remote add origin ssh://git@github.com/pabranch/dotbare-cfg
cfg remote update
cfg reset origin/main
mkdir -p ${HOME}/.cfg-backup &&
  cfg status -s 2>&1 |
  awk '/^[ AMUD][ AMU]/{print $2}' |
  xargs -I{} cp ${HOME}/{} ${HOME}/.cfg-backup/{}
ls -Al .cfg-backup
cfg status

printf "\nUse 'cfg restore .' to reset the config files\n"
