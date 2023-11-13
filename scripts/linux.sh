#!/bin/bash

# Install script to configure the agent on Linux nodes
# This script is intended to be used with the Puppet Enterprise Getting Started VM
set -e

echo "Installing Puppet agent..."
if [ -x "/opt/puppetlabs/bin/puppet" ]; then
  echo "WARNING: Puppet agent is already installed. Re-install, re-configuration, or upgrade not supported and might fail."
fi

# Check if hostnamectl command is available
if command -v hostnamectl &> /dev/null; then
    # Use hostnamectl to set the hostname
    sudo hostnamectl set-hostname ${hostname}
else
    # Fallback to using the hostname command
    sudo hostname ${hostname}
fi

curl -k "https://${pe_server}:8140/packages/current/install.bash" | bash -s --

/opt/puppetlabs/bin/puppet config set environment "${environment}" --section agent

echo "Finished with Puppet agent installation."
