#!/bin/bash

set -ouex pipefail

echo "::group:: === installing display-brightness-ddcutil extension ==="
glib-compile-schemas --strict "/usr/share/gnome-shell/extensions/display-brightness-ddcutil@themightydeity.github.com/schemas/"
echo "::endgroup::"
