# Manage dotfiles

Simple dotfile management based on instructions from a
[tutorial](https://www.atlassian.com/git/tutorials/dotfiles) by Nicola Paolucci.
See his [cfg](https://github.com/durdn/cfg) repo for updates.

Consider using [dotbare](https://github.com/kazhala/dotbare#readme) cli for
long-term environments. Provides more features and "fuzzy" commands for any
Git repo.

## Initialize bare Git repo

Create bare repo and setup `cfg` alias to manage it.
```
git init --bare $HOME/.cfg --initial-branch=$(hostname)

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
cfg config --local status.showUntrackedFiles no
echo "alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc
```

### Link to remote repo if desired

Add this repo as the `origin` remote. Fetch latest and move the local branch to
the `main` remote branch.
```
cfg remote add origin ssh://git@github.com/pabranch/dotbare-cfg
cfg remote update
cfg reset origin/main
```

### Backup conflicting dotfiles as desired

```
mkdir -p ${HOME}/.cfg-backup &&
  cfg status -s 2>&1 |
  awk '/^[ AMUD][ AMU]/{print $2}' |
  xargs -I{} cp ${HOME}/{} ${HOME}/.cfg-backup/{}
ls -Al .cfg-backup
cfg status
```
**TODO**
[ ] figure out what conflict letters make sense for each column

### Usage
