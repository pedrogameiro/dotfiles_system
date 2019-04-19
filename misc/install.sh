#!/bin/bash

for file in "${@}"; do
    dotfile="$(realpath "$file")"
    sysfile="/${dotfile##*root/}"
    mkdir -p "$(dirname "$sysfile")"
    mkdir -vTsf "$dotfile" "$sysfile"
done
