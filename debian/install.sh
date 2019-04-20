#!/bin/bash

grep "ID=debian" /etc/os-release &>/dev/null || exit 0

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

install_pkgs() {
    pkgs=()
    apt-get install "${pkgs[@]}"
}

main() {
    local a
    echo 'Install necessary packages[y/n]'; read a
    if [[ "$a" =~ ^(yes|y|Y)$ ]]; then
        install_pkgs
    fi

    echo 'Link dotfiles? [y/n]'; read a
    if [[ "$a" =~ ^(yes|y|Y)$ ]]; then
        find root -type d -printf '%P\0' | xargs -I% -0 mkdir -p "/%"
        find root \( -type f -o -type l \) -printf '%P\0' | xargs -0 -I% ln -vTsf "$PWD/root/%" "/%"
    fi
}

main "${@}"
