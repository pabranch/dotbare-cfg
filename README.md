# How I like to do things

Here's where I'll describe how I manage my home directories. In particular, I'll
figure out common directories and cross-platform details. It'll be nice to have
a place to put general notes.

The [initial setup](#initial-setup) is found at the bottom of these instructions.

## Style guidelines

- Use objective categories when creating directory structures. Things like date,
  source, or security requirements. Use tags and that sort of thing for
  subjective categorization.
- Create a `benchmark` directory for any benchmarking tools

### Git

Commit prefix reference for the dotfiles repo lives in
[`~/.agents/perry/dotfiles.md`](.agents/perry/dotfiles.md) — same prefixes for
human and agent commits.


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
