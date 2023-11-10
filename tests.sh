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


cd /opt/sublime_text || exit
md5sum -c <<<"7038C3B1CC79504602DA70599D4CCCE9  sublime_text" || exit
echo 00415013: 48 31 C0 C3          | sudo xxd -r - sublime_text
echo 00409037: 90 90 90 90 90       | sudo xxd -r - sublime_text
echo 0040904F: 90 90 90 90 90       | sudo xxd -r - sublime_text
echo 00416CA4: 48 31 C0 48 FF C0 C3 | sudo xxd -r - sublime_text
echo 00414C82: C3                   | sudo xxd -r - sublime_text
echo 003FA310: C3                   | sudo xxd -r - sublime_text
cd -

