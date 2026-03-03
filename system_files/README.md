# system_files

Files and scripts that are copied directly into the image filesystem during the container build. The directory structure mirrors the target filesystem paths — for example, files under `usr/bin/` are installed to `/usr/bin/` in the image.

## How it works

The `Containerfile` uses `COPY` directives to place these files into the image. The directory structure here determines where each file ends up in the final OS. Scripts under `usr/bin/` are made executable during the build.

## Contents

- **`usr/bin/`**: Executable scripts used by systemd services or available as system commands. Each script is typically referenced by a corresponding `.service` file in the `services/` directory.
- **`usr/share/`**: Shared data files such as GNOME shell extensions. Some subdirectories here may be **git submodules** — check `.gitmodules` in the repo root before modifying anything under this path.

## Adding new files

1. Place the file in the directory structure that matches its target path in the filesystem.
2. If it's a new directory or path, add a corresponding `COPY` directive in the `Containerfile`.
3. If it's a script that needs to run via systemd, create a matching service unit in `services/`.
4. Executable scripts should not include a file extension when they are intended to be used as system commands.
