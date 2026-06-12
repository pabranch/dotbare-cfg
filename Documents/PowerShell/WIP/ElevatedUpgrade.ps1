function Upgrade-Apps-Elevated {
      gsudo powershell -NoLogo -NoProfile -ExecutionPolicy Bypass -File "C:\Path\To\Upgrade-Apps.ps1"
}

Set-Alias upgrade-elevated Upgrade-Apps-Elevated
