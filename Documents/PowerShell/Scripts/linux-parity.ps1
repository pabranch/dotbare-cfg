# A minimalist set of "Linux" commands for PowerShell
#
# Only create this sort of thing if you repeatedly find yourself trying to use
# it. It is better to learn the way to do it with PS if possible w/ a one-liner

# Uncomment to test `which` function
#
#function git { Write-Output "Fake git" }
#Set-Alias git 'C:\Program Files\Git\cmd\git.exe'
#echo @echo Fake Git > "$HOME\bin\git.cmd"
#$env:PATH = "$HOME\bin;$env:PATH"
#
# Expected output
#
# PS C:\Users\perry> which git
# alias: git → C:\Program Files\Git\cmd\git.exe
# PS C:\Users\perry> which -a git
# alias: git → C:\Program Files\Git\cmd\git.exe
# function: git
# C:\Users\perry\bin\git.cmd
# C:\Program Files\Git\cmd\git.exe

function which {
    param (
        [Parameter(Position = 0)]
        [string]$Command,

        [Alias('a')]
        [switch]$All
    )

    if (-not $Command) {
        Write-Output "Usage: which [-a] <command>"
        return
    }

    $result = Get-Command $Command -ErrorAction SilentlyContinue

    if (-not $result) {
        Write-Output "$Command not found"
        return
    }

    if ($All) {
        $results = Get-Command -All $Command -ErrorAction SilentlyContinue
    } else {
        # scalar-safe because foreach (auto-wraps)
        $results = $result
    }

    foreach ($r in $results) {
      switch ($r.CommandType) {
          'Alias'     { "alias: $($r.Name) → $($r.Definition)" }
          'Function'  { "function: $($r.Name)" }
          'Application' { $r.Source }
          default     { "$($r.CommandType.ToString().ToLower()): $($r.Source)" }
      }
    }
}

function shell {
    param (
        [switch]$Login
    )

    if ($Login) {
        # Simulates `exec $SHELL -l`: starts a fresh shell and exits
        & (Get-Process -Id $PID).Path
        exit
    } else {
        # Equivalent to `. ~/.bashrc`: reloads current shell config
        . $PROFILE
    }
}
