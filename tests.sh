#!/usr/bin/env bash

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

    # Se passar 1, não "dorme"
    [[ "${2}" -ne 1 ]] && take_a_break

}

take_a_break() {

    # O s é desnecessário, mas nas conferências eles solicitam
    sleep 3s

}

e=(
    $'\360\237\232\252'  #  0 (porta): exit
    $'\360\237\216\250'  #  1 (pintor): bash colorful
    $'\360\237\216\247'  #  2 (headphone): deezloader
    $'\360\237\214\211'  #  3 (paisagem): dualmonitor
    $'\360\237\220\231'  #  4 (polvo): git
    $'\360\237\214\215'  #  5 (globo): chrome
    $'\360\237\223\266'  #  6 (gráfico): conky
    $'\360\237\232\200'  #  7 (foguete): heroku
    $'\360\237\231\210'  #  8 (macaco vendado): hide devices
    $'\360\237\215\277'  #  9 (pipoca): minidlna
    $'\360\235\223\235'  # 10 (n): nvidia
    $'\360\237\220\230'  # 11 (elefante): postgres
    $'\360\237\220\215'  # 12 (cobra): py libraries/upgrade
    $'\360\237\224\244'  # 13 (letras): sublime
    $'\360\237\220\247'  # 14 (pinguim): system upgrade
    $'\360\237\247\262'  # 15 (imã): tmate
    $'\360\237\222\216'  # 16 (diamante): usefull programs
    $'\360\237\222\274'  # 17 (maleta): workspace
    $'\360\237\220\213'  # 18 (baleia): all
    $'\360\237\224\245'  # 19 (fogo): some men...
    $'\360\237\231\212'  # 20 (macaco calado): password
    $'\360\237\246\207'  # 21 (morcego): why do we fall...
    $'\360\237\223\267'  # 22 (câmera): flameshot
)

logo=(
    " █████╗ ██╗     ███████╗██████╗ ███████╗██████╗"
    "██╔══██╗██║     ██╔════╝██╔══██╗██╔════╝██╔══██╗"
    "███████║██║     █████╗  ██████╔╝█████╗  ██║  ██║"
    "██╔══██║██║     ██╔══╝  ██╔══██╗██╔══╝  ██║  ██║"
    "██║  ██║███████╗██║     ██║  ██║███████╗██████╔╝"
    "╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝╚══════╝╚═════╝ "
)

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

[[ ! $(grep 'Linux x64' ~/Downloads/gabr) ]] \
    && echo n || echo encontrado

menu() {

    show "${c[RED]}=======================================================" 1

    for line in "${!logo[@]}"; do
        show "    ${c[RED]}${logo[${line}]}" 1
        
    done

    show "${c[RED]}=======================================================" 1
    show "${c[RED]}[ 00 ] ${c[WHITE]}EXIT ${e[0]}" 1
    show "${c[RED]}[ 01 ] ${c[WHITE]}BASH COLORFUL ${e[1]}" 1
    show "${c[RED]}[ 02 ] ${c[WHITE]}DEEZLOADER ${e[2]}" 1
    show "${c[RED]}[ 03 ] ${c[WHITE]}DUAL MONITOR SETUP ${e[3]}" 1
    show "${c[RED]}[ 04 ] ${c[WHITE]}GIT/GITHUB ${e[4]}" 1
    show "${c[RED]}[ 05 ] ${c[WHITE]}GOOGLE CHROME ${e[5]}" 1
    show "${c[RED]}[ 06 ] ${c[WHITE]}CONKY ${e[6]}" 1
    show "${c[RED]}[ 07 ] ${c[WHITE]}FLAMESHOT ${e[22]}" 1
    show "${c[RED]}[ 08 ] ${c[WHITE]}HEROKU ${e[7]}" 1
    show "${c[RED]}[ 09 ] ${c[WHITE]}HIDE WINDOWS DEVICES ${e[8]}" 1
    show "${c[RED]}[ 10 ] ${c[WHITE]}MINIDLNA ${e[9]}" 1
    show "${c[RED]}[ 11 ] ${c[WHITE]}NVIDIA DRIVER ${e[10]}" 1
    show "${c[RED]}[ 12 ] ${c[WHITE]}POSTGRES ${e[11]}" 1
    show "${c[RED]}[ 13 ] ${c[WHITE]}PY LIBRARIES ${e[12]}" 1
    show "${c[RED]}[ 14 ] ${c[WHITE]}PY UPGRADE ${e[12]}" 1
    show "${c[RED]}[ 15 ] ${c[WHITE]}SUBLIME TEXT ${e[13]}" 1
    show "${c[RED]}[ 16 ] ${c[WHITE]}SYSTEM UPGRADE ${e[14]}" 1
    show "${c[RED]}[ 17 ] ${c[WHITE]}TMATE ${e[15]}" 1
    show "${c[RED]}[ 18 ] ${c[WHITE]}USEFULL PROGRAMS ${e[16]}" 1
    show "${c[RED]}[ 19 ] ${c[WHITE]}WORKSPACE ${e[17]}" 1
    show "${c[RED]}[ 20 ] ${c[WHITE]}ALL ${e[18]}" 1
    show "${c[RED]}=======================================================" 1

    read -n 2 -p $'\033[1;31m[    ]\033[m\033[4D' escolha && echo

    show "${c[RED]}––––––––––––––––––– ${c[YELLOW]}YOUR CHOICE: ${c[GREEN]}${escolha} ${c[RED]}–––––––––––––––––––" 1

    package=('git-cola')

    linen='-----------------------------------------'
    linei='------------------------------------------'

    show "\n${c[YELLOW]}${package^^} ${c[WHITE]}${linen:${#package}} [INSTALLING]\n" 1

    show "${c[RED]}––––––––––––––––––––––– ${c[YELLOW]}END ${c[GREEN]}${escolha} ${c[RED]}––––––––––––––––––––––––" 1

}

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
