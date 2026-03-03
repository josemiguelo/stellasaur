# services

Systemd service units that are installed into the image at build time. The `Containerfile` copies these into `/usr/lib/systemd/user/` (or the appropriate systemd path), and the build orchestrator (`build_files/00_build.sh`) enables them.

## How it works

Each `.service` file defines a systemd unit. Services reference executable scripts located in `system_files/usr/bin/`. The service unit defines *when* and *how* the script runs (triggers, dependencies, restart policy), while the script itself contains the actual logic.

When adding or modifying a service, check both the `.service` file here and its corresponding script in `system_files/usr/bin/`.

## Adding a new service

1. Create a `.service` file in this directory following standard [systemd unit file format](https://www.freedesktop.org/software/systemd/man/latest/systemd.unit.html).
2. Place the executable script it references in `system_files/usr/bin/`.
3. Ensure the script is enabled during the build by adding the appropriate `systemctl enable` call in `build_files/00_build.sh`.
4. User services (per-login) use `WantedBy=default.target`. System services (boot-time) use `WantedBy=multi-user.target`.
