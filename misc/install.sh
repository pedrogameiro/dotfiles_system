#!/bin/bash

main() {
    for f in "${@}"; do
        local ddir=$(realpath "$f"); ddir=$(dirname ${ddir##*root})
        local sdir=$(realpath "$f"); sdir=$(dirname ${sdir})
        local fname=$(basename "$f")

        mkdir -p "$ddir"
        ln -vTsf "$sdir/$fname" "$ddir/$fname"
    done
}

main "${@}"
