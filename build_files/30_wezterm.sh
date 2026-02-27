#!/bin/bash

set -ouex pipefail

echo "::group:: ===$(basename "$0")==="
dnf5 copr enable -y wezfurlong/wezterm-nightly
dnf5 install -y wezterm
echo "::endgroup::"