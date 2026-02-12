#!/bin/bash

set -ouex pipefail

dnf5 clean all

######################
## GENERAL PACKAGES ##
######################
echo "::group:: Install general packages"
GENERAL_PACKAGES=(
  "vlc"
  "konsole"
  "okular"
  "dbus-devel"
  "dnf-command(copr)"
)
dnf5 install -y "${GENERAL_PACKAGES[@]}"
echo "::endgroup::"

###############
## DEV TOOLS ##
###############
echo "::group:: Install development tools"
dnf5 install -y @development-tools
DEV_PACKAGES=(
  "zlib-devel"
  "bzip2-devel"
  "readline-devel"
  "sqlite"
  "sqlite-devel"
  "openssl-devel"
  "xz-devel"
  "libffi-devel"
  "findutils"
  "tk-devel"
  "libzstd-devel"
  "autoconf"
  "gcc"
  "rust"
  "patch"
  "libyaml-devel"
  "gdbm-devel"
  "ncurses-devel"
  "perl-FindBin"
)
echo "Installing dev packages ${#DEV_PACKAGES[@]} ..."
dnf5 install -y "${DEV_PACKAGES[@]}"
echo "::endgroup::"

#############
## WEZTERM ##
#############
echo "::group:: Install wezterm"
dnf5 copr enable -y wezfurlong/wezterm-nightly
dnf5 install -y wezterm
echo "::endgroup::"

############
## VSCODE ##
############
echo "::group:: Install vscode"
rpm --import https://packages.microsoft.com/keys/microsoft.asc &&
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" |
  tee /etc/yum.repos.d/vscode.repo >/dev/null
dnf5 install -y code
echo "::endgroup::"

#################
## ANTIGRAVITY ##
#################
echo "::group:: Install antigravity"
tee /etc/yum.repos.d/antigravity.repo <<EOF
[antigravity-rpm]
name=Antigravity RPM Repository
baseurl=https://us-central1-yum.pkg.dev/projects/antigravity-auto-updater-dev/antigravity-rpm
enabled=1
gpgcheck=0
EOF
dnf5 makecache
dnf5 install -y antigravity
echo "::endgroup::"

###############
## COSMIC DE ##
###############
echo "::group:: Install COSMIC Desktop"
dnf5 install -y @cosmic-desktop-environment
echo "COSMIC desktop installed successfully"
echo "::endgroup::"

echo "::group:: Configure Display Manager"
systemctl disable cosmic-greeter || true
systemctl enable gdm
echo "Display manager configured"
echo "::endgroup::"

echo "::group:: Install Additional Utilities"
dnf5 install -y \
  xdg-desktop-portal-cosmic
echo "Additional utilities installed"
echo "::endgroup::"

#############
## FIREFOX ##
#############
echo "::group:: Install firefox"
dnf5 config-manager setopt fedora-cisco-openh264.enabled=1
dnf5 install -y firefox --allowerasing
echo "::endgroup::"

###############
## 1PASSWORD ##
###############
echo "::group:: Install 1password"
curl -fsSL https://downloads.1password.com/linux/keys/1password.asc -o /tmp/1password.asc
rpm --import /tmp/1password.asc --import https://downloads.1password.com/linux/keys/1password.asc
dnf5 config-manager addrepo \
  --id=1password \
  --set=name="1Password Stable Channel" \
  --set=baseurl="https://downloads.1password.com/linux/rpm/stable/\$basearch" \
  --set=enabled=1 \
  --set=gpgcheck=1 \
  --set=repo_gpgcheck=1 \
  --set=gpgkey="file:///tmp/1password.asc"

mkdir -p /var/opt/1Password
ln -sf /var/opt/1Password /opt/1Password

dnf5 makecache --repo=1password
dnf5 install -y 1password
echo "::endgroup::"

###################
## GOOGLE CHROME ##
###################
echo "::group:: Install google chrome"
dnf5 install -y fedora-workstation-repositories
dnf5 config-manager setopt google-chrome.enabled=1
dnf5 install -y google-chrome-stable
echo "::endgroup::"

###########
## SLACK ##
###########
echo "::group:: Install slack"
rpm --import https://packagecloud.io/slacktechnologies/slack/gpgkey
cat <<'EOF' | tee /etc/yum.repos.d/slack.repo
[slack]
name=Slack
baseurl=https://packagecloud.io/slacktechnologies/slack/fedora/21/$basearch
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packagecloud.io/slacktechnologies/slack/gpgkey
sslverify=1
sslcacert=/etc/pki/tls/certs/ca-bundle.crt
metadata_expire=300
EOF
dnf5 -y --refresh makecache
dnf5 -y install slack
echo "::endgroup::"

###########
## TEAMS ##
###########
echo "::group:: Install teams-for-linux"
curl -1sLf -o /tmp/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
rpm --import /tmp/teams-for-linux.asc
curl -1sLf -o /etc/yum.repos.d/teams-for-linux.repo https://repo.teamsforlinux.de/rpm/teams-for-linux.repo
dnf5 -y install teams-for-linux
echo "::endgroup::"

#############
## SUBLIME ##
#############
echo "::group:: Install sublime-text"
rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
dnf5 config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
dnf5 makecache
dnf5 install -y sublime-text
echo "::endgroup::"

###############
## RPMFUSION ##
###############
echo "::group:: Install rpmfusion"
dnf5 install \
  https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
  https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
  -y
echo "::endgroup::"

###########
## STEAM ##
###########
echo "::group:: Install steam"
dnf5 install -y steam
echo "::endgroup::"

#### Example for enabling a System Unit File
systemctl enable podman.socket

dnf5 clean all
echo "🚀 Installation complete!"
