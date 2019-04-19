#!/bin/bash

[ -f "/etc/arch-release" ] || exit 0

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

install_pkgs() {
    >&2 echo 'Error: Sorry, archlinux not supported (yet).'
}

install_pikaur() {
	cd $(mktemp -d)
    pacman -S --needed base-devel git
	git clone 'https://aur.archlinux.org/pikaur.git'
	cd pikaur
	makepkg -fsri
}

main() {
    local a
    echo 'Install pikaur? [y/n]'; read a
    if [[ "$a" =~ ^(yes|y|Y)$ ]]; then
        install_pikaur
    fi
    echo 'Install necessary packages? [y/n]'; read a
    if [[ "$a" =~ ^(yes|y|Y)$ ]]; then
        install_pkgs
    fi
    echo 'Link dotfiles? [y/n]'; read a
    if [[ "$a" =~ ^(yes|y|Y)$ ]]; then
        find root -type d -printf '%P\0' | xargs -I% -0 mkdir -p "/%"
        find root -type f -printf '%P\0' | xargs -0 -I% ln -vTsf "$PWD/root/%" "/%"
    fi
}

main "${@}"
