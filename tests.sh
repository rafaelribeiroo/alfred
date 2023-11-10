#!/usr/bin/env zsh

declare -A c=(
    [WHITE]='\033[1;37m'  # 0
    [RED]='\033[31;1m'  # 1
    [GREEN]='\033[1;32m'  # 2
    [CYAN]='\033[1;36m'  # 3 CYAN
    [END]='\e[0m'  # 5 Sem mudança
    [YELLOW]='\033[1;33m'
)

show() {

    echo -e ${c[WHITE]}"${1}"${c[END]}

    # Don't sleep if 2ø parameter contains 1
    [[ "${2}" -ne 1 ]] && take_a_break || return 0

}

take_a_break() {

    # O s é desnecessário, mas nas conferências eles solicitam
    sleep 3s

}

declare -A f=(
    [srcs]=/etc/apt/sources.list
    [srcs_list]=/etc/apt/sources.list.d/
    [bashrc]=~/.bashrc
    [zshrc]=~/.zshrc
    [null]=/dev/null
    [ble]=~/.local/share/blesh/ble.sh
    [user_dirs]=~/.config/user-dirs.dirs
    [try]=/workspace/alfred/try
    [config]=/etc/minidlna.conf


    [exec]=/opt/sublime_text/sublime_text
)

milliseconds_to_duration() {

    jq -r '.lyrics.lines[].startTimeMs' lyrics.json
    jq -r '.lyrics.lines[].words' lyrics.json

    local mins secs msec
    local tmp=$1
    (( mins = tmp / 60000, tmp %= 60000, secs = tmp / 1000, msec = tmp % 1000 ))
    printf "%02d:%02d.%03d\n" "$mins" "$secs" "$msec"

}

if [[ $(md5sum --check <<< "AFDEBB91F2BF42C9B491BAFD517C0A49 ${f[exec]}" 2> "${f[null]}" | grep --no-messages 'OK') ]]; then

    # https://gist.github.com/maboloshi/feaa63c35f4c2baab24c9aaf9b3f4e47
    [[ $(xxd -postscript -seek 3813874 -len 4 "${f[exec]}") =~ 55415741 ]] \
        && echo 003A31F2: 48 31 C0 C3 | sudo xxd -revert - "${f[exec]}"

    [[ $(xxd -postscript -seek 3773319 -len 5 "${f[exec]}") =~ e8080e1200 ]] \
        && echo 00399387: 90 90 90 90 90 | sudo xxd -revert - "${f[exec]}"

    [[ $(xxd -postscript -seek 3773341 -len 5 "${f[exec]}") =~ e8f20d1200 ]] \
        && echo 0039939D: 90 90 90 90 90 | sudo xxd -revert - "${f[exec]}"

    [[ $(xxd -postscript -seek 3821104 -len 7 "${f[exec]}") =~ 554156534189f6 ]] \
        && echo 003A4E30: 48 31 C0 48 FF C0 C3 | sudo xxd -revert - "${f[exec]}"

    [[ $(xxd -postscript -seek 3812994 -len 1 "${f[exec]}") =~ 41 ]] \
        && echo 003A2E82: C3 | sudo xxd -revert - "${f[exec]}"

    [[ $(xxd -postscript -seek 3721712 -len 1 "${f[exec]}") =~ 55 ]] \
        && echo 0038C9F0: C3 | sudo xxd -revert - "${f[exec]}"

fi
