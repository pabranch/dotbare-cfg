# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'

	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

# explicitly load git completion since it is lazy loaded normally
if [ -f /usr/share/bash-completion/completions/git ]; then
	. /usr/share/bash-completion/completions/git
elif [ -f /etc/bash-completion.d/git ]; then
	. /etc/bash-completion.d/git
fi

### Customizations ###

# vim all the things
set -o vi
export EDITOR=vim
export VISUAL=vim

_is_command() {
	command -v "$1" >/dev/null
}

# bare git repo for dotfile management and fuzzy command args
if [ -f ~/.dotbare/dotbare.plugin.bash ]; then
	source ~/.dotbare/dotbare.plugin.bash
	alias dotbare="~/.dotbare/dotbare"
	alias cfg=dotbare
	alias gfz='dotbare --git'
else
	alias cfg='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
fi

# cuz lazy/typos
g() {
	if ([[ "$@" != *"-C"* && "$@" != *" clone "* ]] &&
		! git rev-parse --git-dir >/dev/null 2>&1 &&
		_is_command cfg); then
		[[ "$PWD" != "$HOME" ]] && echo "  -- not git repo; using cfg instead --" >&2
		cfg "$@"
	else
		git "$@"
	fi
}

# enable git completion for g and cfg
if type __git_complete &>/dev/null; then
	__git_complete g __git_main
	__git_complete cfg __git_main
fi

# quit-if-one-screen,ignore-case,RAW ctrl chars,quit-at-eof,no-init
# https://explainshell.com/explain?cmd=less+-FiReX
export LESS=-FiReX

# setup brew if installed
if _is_command brew; then
	brew_prefix=$(brew --prefix)
elif [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
	brew_prefix='/home/linuxbrew/.linuxbrew'
fi
if [[ -n "$brew_prefix" ]]; then
	eval "$(${brew_prefix}/bin/brew shellenv)"
	# only update once every 24 hours
	export HOMEBREW_AUTO_UPDATE_SECS=86400
fi

# Dynamically create 'outdated' alias for available package managers
outdated_cmd=""
if _is_command brew; then
	outdated_cmd+='echo "-> brew ..."; brew update >/dev/null && brew outdated'
	alias brewed='sort <(brew leaves; brew list --cask)'
fi
if _is_command apt; then
	[[ -n "$outdated_cmd" ]] && outdated_cmd+='; '
	outdated_cmd+='echo "-> apt ..."; sudo apt-get update >/dev/null && sudo apt list --upgradeable'
fi
if _is_command scoop; then
	[[ -n "$outdated_cmd" ]] && outdated_cmd+='; '
	outdated_cmd+='echo "-> scoop ..."; scoop update --all >/dev/null && scoop status'
	alias scooped='scoop list | awk '\''NR>4&&NF{print $1}'\'''
fi
if _is_command winget; then
	[[ -n "$outdated_cmd" ]] && outdated_cmd+='; '
	outdated_cmd+='echo "-> winget ..."; winget.exe source update >/dev/null && winget.exe upgrade --include-unknown'
	alias wingot='winget.exe ls | grep "winget$"'
fi
if [[ -n "$outdated_cmd" ]]; then
	alias outdated="$outdated_cmd"
else
	alias outdated='echo "No supported package manager found."'
fi

# Set up fzf key bindings and fuzzy completion
_is_command fzf && eval "$(fzf --bash)"

# cd w/ memory
if _is_command zoxide; then
	eval "$(zoxide init bash)"
	alias cd=z
	alias cdi=zi
fi

if _is_command bat; then
	alias cat='bat -p'
fi

if _is_command fastfetch; then
	alias about='fastfetch'
fi

# OS specific config
OS="${OS:-$(uname -o)}"
case $OS in
Msys) alias ls='ls --ignore={NTUSER.DAT,ntuser.dat}*' ;;
esac

# git-bash chokes on paths with mise activate
if [[ ! $OS = "Msys" ]] && _is_command mise; then
	eval "$(mise activate bash)"
fi

if _is_command docker; then
	alias dkr=docker
fi

if _is_command podman; then
	alias pdm=podman
	if ! _is_command docker; then
		alias docker=podman
		alias dkr=podman
	fi
fi

#  run last to override any previous aliases, variables, etc
if [[ -r "$HOME/.bashrc.local" ]]; then
	source "$HOME/.bashrc.local"
fi

# vvvvv to be organized vvvvv

alias lal='ls -Al'
alias lla='lal' # duplicated for muscle memory/typo tolerance
alias md='mkdir'
alias rd='rmdir'
alias cls='clear'
alias all-brewed='sort -u <(cat ~/.config/dotbare-cfg/all-brewed; brewed) | tee ~/.config/dotbare-cfg/all-brewed'
