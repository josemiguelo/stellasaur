# disk_config

TOML configuration files for [bootc-image-builder](https://github.com/osbuild/bootc-image-builder). These define how the container image is converted into bootable disk images or installer ISOs.

## How it works

When building a bootable image (via `just build-qcow2`, `just build-iso`, etc.), bootc-image-builder reads the appropriate TOML config to determine disk layout, filesystem options, and installer behavior. The `Justfile` maps each build target to a specific config file — read the Justfile to see which config is used for each image type.

## Config types

- **Disk configs** define partition layout and filesystem requirements for direct disk images (qcow2, raw).
- **ISO configs** include Anaconda kickstart scripts that run during installation. These typically execute `bootc switch --mutate-in-place` to point the installer at the published container image. They also control which Anaconda installer modules are enabled or disabled.

## Adding or modifying configs

Configs follow the [bootc-image-builder TOML format](https://github.com/osbuild/bootc-image-builder). When adding a new config, also add a corresponding build recipe in the `Justfile` that references it.
