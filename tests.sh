#!/usr/bin/env bash

declare -A c=(
    [WHITE]='\033[1;37m'  # 0
    [RED]='\033[31;1m'  # 1
    [GREEN]='\033[1;32m'  # 2
    [CYAN]='\033[1;36m'  # 3 CYAN
    [END]='\e[0m'  # 5 Sem mudança
)

show() {

    echo -e ${c[WHITE]}"${1}"${c[END]}

    # Se passar 1, não "dorme"
    [[ "${2}" -eq 1 ]] || take_a_break

}

take_a_break() {

    # O s é desnecessário, mas nas conferências eles solicitam
    sleep 3s

}

# usefull files
declare -A u=(
    [askpass]=/lib/cryptsetup/askpass
    [bashrc]=~/.bashrc
    [gtk_theme]=/org/cinnamon/desktop/interface/gtk-theme
    [mimeapps]=~/.config/mimeapps.list
    [null]=/dev/null
    [public_ssh]=~/.ssh/id_rsa.pub
    [user_dirs]=~/.config/user-dirs.dirs
    [srcs]=/etc/apt/sources.list
    [srcs_list]=/etc/apt/sources.list.d
)

#show "${c[RED]}=======================================================" 1

# psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='postgres'"

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
