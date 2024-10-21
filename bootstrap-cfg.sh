set -o vi
cd ~
### from README
git init --bare $HOME/.cfg --initial-branch=$(hostname)

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg config --local status.showUntrackedFiles no
echo "alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc

cfg remote add origin ssh://git@github.com/pabranch/dotbare-cfg
cfg remote update
cfg reset origin/main
mkdir -p ${HOME}/.cfg-backup &&
  cfg status -s 2>&1 |
  awk '/^[ AMUD][ AMU]/{print $2}' |
  xargs -I{} cp ${HOME}/{} ${HOME}/.cfg-backup/{}
ls -Al .cfg-backup
cfg status
