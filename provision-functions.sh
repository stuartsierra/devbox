#!/usr/bin/env bash

# Functions for provisioning scripts on Ubuntu 12.04 (Precise Pangolin)

# Install an apt package if it is not already installed
function install_package {
    local package="$1"
    if ! ( dpkg-query -s "$package" | grep "install ok installed" ) &> /dev/null; then
        apt-get -yq install "$package"
    fi
}

# Update apt-get package lists if they have not been updated within
# the past 24 hours.
function update_apt_daily {
    local marker_file="/var/local/last_apt_update"
    if [ -e "$marker_file" ]; then
        last_update=`stat -c '%Y' "$marker_file"`
    else
        last_update=0
    fi
    local now=`date '+%s'`
    local yesterday=$(( $now - (60 * 60 * 24) ))
    if [[ $last_update -lt $yesterday ]]
    then
        apt-get -yq update
        touch "$marker_file"
    fi
}

# Note: requires console interaction for click-through license
function install_oracle_jdks {
    add-apt-repository ppa:webupd8team/java
    apt-get update
    apt-get install oracle-java6-installer
    apt-get install oracle-java7-installer
}

# Emacs 24 for Ubuntu 12.04: https://launchpad.net/~cassou/+archive/emacs
function install_emacs24 {
    if ! ( which emacs &> /dev/null ); then
        add-apt-repository -y ppa:cassou/emacs
        apt-get -yq update
        apt-get -yq install emacs24 emacs24-el emacs24-common-non-dfsg
    fi
}

# Create a user with membership in all the "admin" groups, with
# .ssh/authorized_keys.
function create_user {
    local username="$1"
    local authorized_keys_file="$2"
    if ! ( id "$username" &> /dev/null ); then
        useradd -m --shell /bin/bash --user-group \
            --groups adm,cdrom,sudo,dip,plugdev,admin \
            $username
        local ssh_dir="/home/$username/.ssh"
        mkdir -p "$ssh_dir"
        cp "$authorized_keys_file" "$ssh_dir/authorized_keys"
        chown -R "$username:$username" "$ssh_dir"
        chmod 0700 "$ssh_dir"
        chmod 0600 "$ssh_dir/authorized_keys"
    fi
}

# Install truecrypt from a platform-specific .tar.gz file passed as an
# argument.
function install_truecrypt {
    tarfile="$1"
    (
        cd /tmp
        tar xzf "$tarfile"
        mkdir -p /usr/local/bin
        chmod 0755 /usr/local/bin
        cp truecrypt /usr/local/bin/truecrypt
        chmod 0755 /usr/local/bin/truecrypt
        cp truecrypt-license.txt /usr/local/truecrypt-license.txt
    )
}

# Add user to a local /etc/sudoers.d file, allowing full sudo
# privileges without a password.
function add_sudoer_nopasswd {
    local user="$1"
    local sudoers_dir="/etc/sudoers.d"
    local sudoers_file="$sudoers_dir/local_users"
    mkdir -p "$sudoers_dir"
    echo "$user ALL=(ALL) NOPASSWD:ALL" >> "$sudoers_file"
    chmod 0440 "$sudoers_file"
}


######################################################################
### NORMAL USER PROVISIONING
###
### These functions should be run as a normal user.

function install_lein {
    if [ ! -e "$HOME/bin/lein" ]; then
        mkdir -p "$HOME/bin"
        wget -O "$HOME/bin/lein" \
            https://raw.github.com/technomancy/leiningen/stable/bin/lein
        chmod 0755 "$HOME/bin/lein"
        "$HOME/bin/lein" version
    fi
}

function install_dotfiles {
    if [ ! -e "$HOME/dotfiles" ]; then
        git clone https://github.com/stuartsierra/dotfiles.git "$HOME/dotfiles"
        "$HOME/dotfiles/install.sh"
    fi
}

function install_tmux {
    local tarfile="$1"
    (
        cd /tmp
        tar xzf "$tarfile"
        cd tmux-*
        ./configure
        make
        make install
    )
}
