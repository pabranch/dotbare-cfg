# How I like to do things

Here's where I'll describe how I manage my home directories. In particular, I'll
figure out common directories and cross-platform details. It'll be nice to have
a place to put general notes.

The [initial setup](#initial-setup) is found a the bottom of these instructions.

## Style guidelines

- Use objective categories when creating directory structures. Things like date, source, or security requirments. Use tags and that sort of thing for subjective categorization.

### Git

Commit Prefix Reference for my DOTFILES

| Prefix | Environment             | Description |
|--------|-------------------------|-------------|
| `GB$`  | Git Bash                | Changes are Git Bash specific |
| `PS>`  | PowerShell              | Changes are PowerShell specific |
| `WSL`  | Windows Subsystem Linux | Changes are WSL specific |
| *(none)* | Global Compatibility  | Changes are cross-shell compatible |


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

Perhaps this is a good place to capture some AI Agent prompts.

## Initial setup

[Instructions](.config/dotbare-cfg/README.md)

Keep this the final section of the file as it really only matters once. Discuss
how to approach updates.
