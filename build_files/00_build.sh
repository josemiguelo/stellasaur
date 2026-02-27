#!/bin/bash

set -ouex pipefail

/ctx/10_general-packages.sh
/ctx/20_dev-tools.sh
/ctx/30_wezterm.sh
/ctx/40_vscode.sh
/ctx/50_antigravity.sh
/ctx/60_cosmic-de.sh
/ctx/70_firefox.sh
/ctx/80_onepassword.sh
/ctx/90_google-chrome.sh
/ctx/100_slack.sh
/ctx/110_teams.sh
/ctx/120_sublime.sh
/ctx/130_rpm-fusion.sh
/ctx/140_set-ddcutil-up.sh

echo "::group:: === enabling services ==="
systemctl enable podman.socket
systemctl enable /usr/lib/systemd/user/post-install-checker.service
systemctl enable /usr/lib/systemd/user/custom-groups.service
echo "::endgroup::"

dnf5 clean all
echo "🚀 Installation complete!"
