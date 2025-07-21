Import-Module gsudoModule

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -Colors @{ Command = 'Cyan'; Operator = 'Yellow' }

Set-PSReadLineKeyHandler -Key Tab -Function Complete

function Upgrade-Apps-Elevated {
      gsudo powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "C:\Path\To\Upgrade-Apps.ps1"
}

Set-Alias upgrade-elevated Upgrade-Apps-Elevated

. "$HOME\Documents\PowerShell\Scripts\linux-parity.ps1"
. "$HOME\Documents\PowerShell\Scripts\Set-WindowsTheme.ps1"

# vvvvvv to organize/cleanup vvvvvv

# perhaps use `where` defined in linux-parity to see if zoxide is available
Invoke-Expression (& { (zoxide init powershell | Out-String) })
