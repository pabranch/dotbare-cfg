# ~/.profile: executed by the command interpreter for login shells.
# shellcheck shell=sh
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
	# include .bashrc if it exists
	if [ -e "$HOME/.bashrc" ]; then
		. "$HOME/.bashrc"
	fi
fi

# set PATH to include any of user's private bin directories
for bindir in bin .local/bin; do
	PATH="$HOME/$bindir:$PATH"
done

if command -v about >/dev/null 2>&1; then
	about
fi

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

##
# Your previous /Users/perry/.profile file was backed up as /Users/perry/.profile.macports-saved_2026-09-14_at_15:37:46
##

# MacPorts Installer addition on 2026-09-14_at_15:37:46: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

