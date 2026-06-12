Import-Module gsudoModule

Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -Colors @{ Command = 'Cyan'; Operator = 'Yellow' }

Set-PSReadLineKeyHandler -Key Tab -Function Complete

# UTF-8 for native command output and input
if ([Console]::OutputEncoding.CodePage -ne 65001) { chcp 65001 > $null }
[Console]::InputEncoding  = [System.Text.UTF8Encoding]::new($false)
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new($false)
$OutputEncoding = [Console]::OutputEncoding

. "$HOME\Documents\PowerShell\Scripts\Set-WindowsTheme.ps1"

# vvvvvv to organize/cleanup vvvvvv

# perhaps use `where` defined in linux-parity to see if zoxide is available
Invoke-Expression (& { (zoxide init powershell | Out-String) })
