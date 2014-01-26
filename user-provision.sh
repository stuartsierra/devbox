#!/usr/bin/env bash

# User-level provisioning for Ubuntu 12.04 (Precise Pangolin)
#
# This script should run as a normal non-root user.

set -e

if [[ -e /vagrant ]]; then
    SOURCES=/vagrant
else  # for packer
    SOURCES=/tmp
fi
source "$SOURCES/provision-functions.sh"

install_lein
install_dotfiles
