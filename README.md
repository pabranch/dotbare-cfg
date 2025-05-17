# How I like to do things

Here's where I'll describe how I manage my home directories. In particular, I'll
figure out common directories and cross-platform details. It'll be nice to have
a place to put general notes.

## Next?

- CLI prompt, look and feel, prioritize differentiating "where you are", e.g.
  linux, windows, mac os, local vs remote
- Font
- PowerShell

```
Set-PSReadLineOption -EditMode Vi
```

## Notes


```
# must use 127.0.0.1 for Windows
glances -w -B 127.0.0.1
```

Turns out `scoop` largely matches `brew` including app names. Some minor mapping
will be needed, but it needs to be very simple. Add `scoop status` to `outdated`
alias.

Perhaps this is a good place to capture some AI Agent prompts.

## Initial setup

[Instructions](.config/dotbare-cfg/README.md)

Keep this the final section of the file as it really only matters once. Discuss
how to approach updates.
