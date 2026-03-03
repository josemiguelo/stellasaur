# ujust

[Just](https://just.systems/) recipes for user-level setup. These are meant to be run after the OS image is installed, not during the container build.

## How it works

1. On first graphical login, a systemd user service clones this repo to the local filesystem.
2. `60-custom.just` is installed into the image at build time and imports `custom.just` from the cloned repo.
3. The user runs `ujust do-post-install` to execute all setup recipes.

`custom.just` is the main recipe file. It imports all other recipe files and defines the `do-post-install` recipe that runs them in order. Read `custom.just` to see the current list and execution order.

## Adding a new recipe

1. Create a new file `<name>.just` in this directory.
2. Add an `import` line in `custom.just`.
3. If it should run during post-install, add it to the `do-post-install` recipe in `custom.just`.
4. Use `[group('Post Install')]` to group it with other post-install recipes.
5. Recipes should be idempotent — safe to run multiple times without side effects.

## Important notes

- `60-custom.just` references a hardcoded repo path. That path matches where the post-install service clones the repo. If one changes, the other must too.
- Some recipes contain personal config values (email, username, dotfiles repo). These are intentional for this personal image.
- Recipes run as the logged-in user, not root.
