# How I like to do things

Here's where I'll describe how I manage my home directories. In particular, I'll
figure out common directories and cross-platform details. It'll be nice to have
a place to put general notes.

The [initial setup](#initial-setup) is found a the bottom of these instructions.

## Style guidelines

- Use objective categories when creating directory structures. Things like date,
  source, or security requirments. Use tags and that sort of thing for
  subjective categorization.

### Git

Commit Prefix Reference for my DOTFILES

| Prefix | Environment             | Description |
|--------|-------------------------|-------------|
| `GB$`  | Git Bash                | Changes are Git Bash specific |
| `PS>`  | PowerShell              | Changes are PowerShell specific |
| `WSL`  | Windows Subsystem Linux | Changes are WSL specific |
| *(none)* | Global Compatibility  | Changes are cross-shell compatible |


## Next?

See the [TODO list](.config/dotbare-cfg/TODO.md) for upcoming tasks and ideas.

## Notes

```
# must use 127.0.0.1 for Windows
glances -w -B 127.0.0.1
```

```powershell
Set-PSReadLineOption -EditMode Vi
```

Perhaps this is a good place to capture some AI Agent prompts.

## Initial setup

[Instructions](.config/dotbare-cfg/README.md)

Keep this the final section of the file as it really only matters once. Discuss
how to approach updates.
