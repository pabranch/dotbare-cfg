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
git init --bare $HOME/.cfg --initial-branch=$(hostname | tr [:upper:] [:lower:])

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
echo "$(alias cfg)" >> $HOME/.bashrc
cfg config --local status.showUntrackedFiles no
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

```
# if you just want to use everything from the repo
cfg restore .
```

## Homebrew

Install [brew](https://brew.sh) for consistent tooling.

```
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh \
  -o install-brew.sh
chmod +x install-brew.sh
sudo ls >/dev/null    # prime sudo for use in the install
NONINTERACTIVE=1 ./install-brew.sh
```

### Usage

## Vim setup

Install basic dark mode.
```
mkdir -p ~/.vim/pack/themes/start
cd ~/.vim/pack/themes/start
git clone https://github.com/tomasiser/vim-code-dark
cd -
```
Should be enabled in `.vimrc` already. If not, add `colorscheme codedark` to use.
