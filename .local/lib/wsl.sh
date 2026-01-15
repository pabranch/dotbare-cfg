# shellcheck shell=bash
# shellcheck disable=SC2016 # no expression expansion in single-quotes
# library - source only

alias powershell='/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe'

get-winenv ()
{
  if command -v wslpath >/dev/null; then
    WINUSER=$(powershell -Command 'echo $env:USERNAME' | tr -d '\r');
    WINHOME=$(wslpath "$(powershell -Command 'echo $env:USERPROFILE' | tr -d '\r')")
    export WINUSER WINHOME
  else
    echo "No wslpath command found"
  fi
}
get-winenv

alias code='"$WINHOME/AppData/Local/Programs/Microsoft VS Code/bin/code"'
alias wsl='/mnt/c/windows/system32/wsl.exe'

wsl-reboot () {
  local distros=(
    $(wsl -l -q --running | iconv -f UTF-16LE -t UTF-8 | tr -d '\r' | tr -d '\r')
  )
  if [ ${#distros[@]} -eq 1 ]; then
    # Reboot the only running distro
    echo "Rebooting the current WSL distro: ${distros[0]}"
    wsl -t "${distros[0]}"
  elif [ ${#distros[@]} -gt 1 ]; then
    # Prompt the user to choose a distro to reboot
    echo "Multiple distros running. Please choose the distro to reboot."
    select option in "${distros[@]}"; do
      if [ -n "$option" ]; then
        echo "Rebooting the selected WSL distro: $option"
        wsl -t "$option"
        break
      else
        echo "Invalid selection. Please try again."
      fi
    done
  else
    echo "No running WSL distros found."
  fi
}
