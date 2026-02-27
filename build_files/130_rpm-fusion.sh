#!/bin/bash

set -ouex pipefail

echo "::group:: === installing rpmfusion repos ==="
dnf5 install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
  -y
echo "::endgroup::"

echo "::group:: === installing steam ==="
dnf5 install -y steam
echo "::endgroup::"

