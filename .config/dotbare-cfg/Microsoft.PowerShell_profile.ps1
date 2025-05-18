Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator Cursor
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -Colors @{ Command = 'Cyan'; Operator = 'Yellow' }

Set-PSReadLineKeyHandler -Key Tab -Function Complete
