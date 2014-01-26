#!/usr/bin/env bash

# Provisioning script for Ubuntu 12.04 "Precise Pangolin"
#
# This script should run as root.

set -ev

# Wait for Ubuntu cloud-init to set up package repositories
sleep 20

if [[ -e /vagrant ]]; then
    SOURCES=/vagrant
else  # for packer
    SOURCES=/tmp
fi

source "$SOURCES/provision-functions.sh"

### PACKAGES

update_apt_daily

install_package openjdk-6-jdk  # before any other Java-dependent things
install_package openjdk-7-jdk

install_package ack-grep
install_package apg
install_package aptitude
install_package build-essential
install_package curl
install_package erlang
install_package git
install_package imagemagick
install_package libevent-dev
install_package maven
install_package ncurses-dev
install_package ngrep
install_package python-software-properties
install_package ruby
install_package subversion
install_package texinfo
install_package tree
install_package unzip
install_package uuid
install_package wodim  # replaces cdrecord
install_package zile
install_package zip

install_emacs24

install_tmux "$SOURCES/tmux-1.8.tar.gz"
install_truecrypt "$SOURCES/truecrypt-linux-x64.tar.gz"

### Users

## create_user YOURNAMEHERE "$SOURCES/my_authorized_keys"
create_user pair "$SOURCES/pair_authorized_keys"

## add_sudoer_nopasswd YOURNAMEHERE
add_sudoer_nopasswd pair

## su -l -c "/bin/bash $SOURCES/user-provision.sh" YOURNAMEHERE 
su -l -c "/bin/bash $SOURCES/user-provision.sh" pair
