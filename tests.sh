#!/usr/bin/env bash

# systemctl list-unit-files --type service -all

: ' aumenta_valor() {
    if [[ ${1} -eq 1 ]]; then
        return 0
    elif [[ ${1} -eq 2 ]]; then
        return 1
    fi
}

aumenta_valor 1
if [[ "$?" -eq 0 ]]; then
    echo "Vim do if do aumenta_valor"
fi'
