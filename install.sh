#!/bin/bash

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

main() {
    local a

    echo 'Search whole system for broken links? [y/n]'; read a
    if [[ "$a" =~ ^(yes|y|Y)$ ]]; then
        echo 'Searching for broken links'
        find "/" -xtype l -ok rm '{}' \;
    fi

    for sys in "archlinux" "debian" "common"; do
        echo -e "\t >$sys<"
        "./$sys/install.sh"
    done
}

main "${@}"

