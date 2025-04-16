case "${SHELL}" in
  *"bash"*) [ -r ${HOME}/.bashrc ] && . ${HOME}/.bashrc ;;
  *) ;;
esac
