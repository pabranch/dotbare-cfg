echo "-> ${PWD}/.profile"

case "${SHELL}" in
  *"bash"*) [ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc ;;
  *) ;;
esac

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
PATH="/usr/local/opt/findutils/libexec/gnubin:$PATH"
