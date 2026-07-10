# Plan: Optional Package Restoration

## Goal

Complement the tracked Homebrew and Scoop package inventories with an explicit, reviewable restoration workflow.

## Implementation

1. Define whether `all-brewed` and `all-scooped` are exact desired state or an additive installation list.
2. Add dry-run commands that show missing packages without uninstalling extras.
3. Implement opt-in installation for available package managers; never install automatically during shell startup.
4. Separate platform/package-manager selection from package installation.
5. Preserve the existing `diff-*` and `update-all-*` workflows.
6. Document failure recovery and how casks or package-name differences are handled.

## Validation

- Test parsing and dry-run behavior with fixture lists.
- Test installation in a disposable environment where practical.
- Confirm no package changes occur without explicit user action.
