# stellasaur

A custom [bootc](https://github.com/bootc-dev/bootc) image that integrates Cosmic DE into Bluefin

## Repository structure

### `build_files/`

Scripts that run during the container image build. It installs packages, creates files and set services up, etc.

### `ujust/`

Custom [ujust](https://just.systems/) recipes for post-install setup: install flatpaks, set steam up, ssh, dotfiles, etc.

### `post-install-checker/`

A systemd user service that runs on first graphical login. 

## How to use it

For using on a fresh installation, execute the following commands:

```bash
sudo bootc switch ghcr.io/josemiguelo/stellasaur:43
systemctl reboot
```

## post-installation

Execute after login:

```bash
ujust do-post-install
```
