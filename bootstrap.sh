#!/usr/bin/env bash
cd "$(dirname "$0")"

# so far I've installed: git, curl, wget, vim

# First build poudriere
# cd /usr/ports/ports-mgmt/poudriere && make -DBATCH install
cp etc/poudriere.conf /usr/local/etc/
cp etc/poudriere.d/packages-default /usr/local/etc/poudriere.d/

mkdir -p /usr/local/etc/pkg/repos
cp etc/pkg/repos/Local.conf /usr/local/etc/pkg/repos/

# Create a jail for poudriere if not already exists
if ! poudriere jail -lnq | grep --quiet '^142x64$'; then
  poudriere jail -c -j 142x64 -v 14.2-RELEASE
fi

# Crate ports tree if not already exists
if ! poudriere ports -lnq | grep --quiet '^default$'; then
  poudriere ports -c -p default
fi

# Now build all of the packages listed in "packages-default" file
poudriere bulk -j 142x64 -p default -f /usr/local/etc/poudriere.d/packages-default

pkg install tmux neovim zsh sudo htop gnome