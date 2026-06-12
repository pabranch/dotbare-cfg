@echo off
setlocal
for %%A in (%*) do (
  if /I "%%~A"=="-C" goto :call_git_direct
  if /I "%%~A"=="clone" goto :call_git_direct
)
git rev-parse --git-dir >NUL 2>&1
if %errorlevel% NEQ 0 (
  if exist "%USERPROFILE%\.cfg" (
    if /I NOT "%CD%"=="%USERPROFILE%" (
      echo  -- not git repo; using cfg instead --
    )
    git --git-dir="%USERPROFILE%\.cfg" --work-tree="%USERPROFILE%" %*
    goto :EOF
  )
)
:call_git_direct
git %*
endlocal
