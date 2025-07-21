function Check-SoftLink {
    param (
      [string]$LinkPath
    )

    # Gather FileInfo and reparse attributes
    $info = Get-Item -Path $LinkPath -Force

    if ($info.Attributes -match 'ReparsePoint') {
        Write-Host "🔗 '$LinkPath' is a symbolic link."
        Write-Host "Target: $($info.Target)"
        Write-Host "LinkType: $($info.LinkType)"
    } else {
        Write-Host "⚠️ '$LinkPath' is not a symbolic link."
    }
}

# change in src dir
