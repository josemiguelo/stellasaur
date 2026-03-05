# stellasaur

A custom [bootc](https://github.com/bootc-dev/bootc) image that integrates my personal tooling into [Bluefin DX](https://projectbluefin.io/) (Universal Blue). Two variants are built: a standard `bluefin-dx` image and an Nvidia variant (`bluefin-dx-nvidia-open`).

## Repository structure

For a detailed overview of the project architecture, conventions, and repository layout, see [`llms.txt`](llms.txt) and [`AGENTS.md`](AGENTS.md). Each subdirectory also has its own `README.md` with specifics.

## How to use it

For using on a fresh installation, execute the following commands to use the default dx image:

```bash
sudo bootc switch ghcr.io/josemiguelo/stellasaur:latest
systemctl reboot
```


Use this if you want to use the dx-nvidia image:
```bash
sudo bootc switch ghcr.io/josemiguelo/stellasaur-nvidia:latest
systemctl reboot
```

## post-installation

Execute after login:

```bash
ujust do-post-install
```


## Why the name stellasaur?

Bluefin has a [dinosaur naming tradition](https://docs.projectbluefin.io/dinosaurs) for its custom images. This project originally used the [Cosmic desktop environment](https://system76.com/cosmic/), and the name *stellasaur* comes from that — a nod to *stellar* (as in cosmic/space) combined with the requisite dinosaur suffix.

## Todos

- install postman
- install scrcpy
- install dbeaver
- install azure-cli
