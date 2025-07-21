function Set-WindowsTheme {
    param (
        [ValidateSet("Light", "Dark")]
        [string]$Theme,
        [switch]$RestartShell
    )

    $registryPath = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize'
    $lightValue = if ($Theme -eq 'Light') { 1 } else { 0 }

    # Update theme preferences
    Set-ItemProperty -Path $registryPath -Name SystemUsesLightTheme -Value $lightValue
    Set-ItemProperty -Path $registryPath -Name AppsUseLightTheme -Value $lightValue
    Write-Host "Theme switched to $Theme mode."

    if ($RestartShell.IsPresent) {
        Write-Host "Restarting Explorer shell..."
        Stop-Process -Name explorer -Force
        Start-Process explorer.exe
    }
}

# Example usage:
# Set-WindowsTheme -Theme Dark -RestartShell
