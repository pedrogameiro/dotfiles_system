#!/bin/bash

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

main() {
    local a
    echo 'Link dotfiles? [y/n]'; read a
    if [[ "$a" =~ ^(yes|y|Y)$ ]]; then
        find root -type d -printf '%P\0' | xargs -I% -0 mkdir -p "/%"
        find root \( -type f -o -type l \) -printf '%P\0' | xargs -0 -I% ln -vTsf "$PWD/root/%" "/%"
    fi
}

main "${@}"
