@test "'which' with no arguments prints usage" {
  run pwsh -NoLogo -NoProfile -NonInteractive -Command @'
    . "'"$parityScript"'"
    which
'@

  [ "$status" -eq 0 ]
  [[ "$output" == "Usage: which [-a] <command>" ]]
}

@test "'which git' returns expected match" {
  run pwsh -NoLogo -NoProfile -NonInteractive -Command @'
    function git { "Fake git function" }
    Set-Alias git "C:\\Program Files\\Git\\cmd\\git.exe"
    . "'"$parityScript"'"
    which git
'@

  [ "$status" -eq 0 ]
  [[ "$output" == *"alias: git → C:\\Program Files\\Git\\cmd\\git.exe"* ]]
}

@test "first entry from 'which -a' matches 'which'" {
  run pwsh -NoLogo -NoProfile -NonInteractive -Command @'
    $env:HOME = "'"$testHome"'"
    $env:PATH = "$env:HOME\\bin;$env:PATH"

    function git { "Fake git function" }
    Set-Alias git "C:\\Program Files\\Git\\cmd\\git.exe"
    . "'"$parityScript"'"

    $first = which git
    $all = which -a git
    "$first`n--`n$all"
'@

  [ "$status" -eq 0 ]
  first_line=$(echo "$output" | head -n1)
  all_first_line=$(echo "$output" | awk '/^--$/ {getline; print}' | head -n1)
  [ "$first_line" = "$all_first_line" ]
}
