#!/bin/bash

set -ouex pipefail

echo "::group:: ===$(basename "$0")==="

# NOTE: this script assumes ddcutil is already installed and available in the system

echo "Configuring i2c-dev kernel module to load on boot..."
if ! grep -q "i2c-dev" /etc/modules-load.d/ddcutil.conf 2>/dev/null; then
  echo "i2c-dev" | tee /etc/modules-load.d/ddcutil.conf >/dev/null
  echo "Configured i2c-dev kernel module to load on boot."
else
  echo "i2c-dev kernel module already configured to load on boot."
fi

echo "Creating udev rules for ddcutil permissions..."
UDEV_RULES_FILE="/etc/udev/rules.d/50-ddcutil-i2c.rules"
EXPECTED_RULE_CONTENT='SUBSYSTEM=="i2c-dev", GROUP="i2c", MODE="0660"'

if ! grep -q -F "$EXPECTED_RULE_CONTENT" "$UDEV_RULES_FILE" 2>/dev/null; then
  echo "Creating udev rules for ddcutil permissions..."
  cat <<EOF | tee "$UDEV_RULES_FILE" >/dev/null
# udev rules for ddcutil
# Gives all members of the 'i2c' group read/write access to i2c devices
SUBSYSTEM=="i2c-dev", GROUP="i2c", MODE="0660"
EOF
  echo "Created udev rules for ddcutil."
else
  echo "udev rules for ddcutil already exist."
fi

echo "Ensuring 'i2c' group exists..."
groupadd -f i2c
echo "Created 'i2c' group."

echo "::endgroup::"
