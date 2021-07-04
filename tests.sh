#!/usr/bin/env zsh

declare -a e=(
    $'\360\237\232\252'  #  0 (door): exit
    $'\360\237\216\250'  #  1 (colors): bash colorful
    $'\360\237\216\247'  #  2 (headphone): deezloader
    $'\360\237\214\211'  #  3 (landscape): dualmonitor
    $'\360\237\220\231'  #  4 (octopus): git
    $'\360\237\214\215'  #  5 (globe): chrome
    $'\360\237\223\267'  #  6 (camera): flameshot
    $'\360\237\232\200'  #  7 (rocket): heroku
    $'\360\237\231\210'  #  8 (blindfolded monkey): hide devices
    $'\360\237\215\277'  #  9 (popcorn): minidlna
    $'\360\235\223\235'  # 10 (n): nvidia
    $'\360\237\220\230'  # 11 (elephant): postgres
    $'\360\237\220\215'  # 12 (snake): python
    $'\360\237\214\230'  # 13 (moon): reduce eye strain
    $'\360\237\224\244'  # 14 (letters): sublime
    $'\360\237\247\262'  # 15 (magnet): tmate
    $'\360\237\222\216'  # 16 (diamond): usefull programs
    $'\360\237\222\274'  # 17 (suitcase): workspace
    $'\360\237\220\213'  # 18 (whale): all
    $'\360\237\224\245'  # 19 (fire): some men...
    $'\360\237\231\212'  # 20 (silent monkey): password
    $'\360\237\246\207'  # 21 (bat): why do we fall...
    $'\342\231\246\357\270\217'  # 22: (red diamond): ruby
)

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
    [null]=/dev/null
    [ble]=~/.local/share/blesh/ble.sh
    [user_dirs]=~/.config/user-dirs.dirs
    [try]=/workspace/alfred/try

    [rat_page]=/tmp/rat_search
)

#vim ~/.bashrc

work() {

    read -p $'\033[1;37mSIR, ? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then



            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    xrandr --output $EXTERN2 --mode 1920x1080
    xrandr --output $EXTERN1 --mode 1920x1080
    xrandr --output $EXTERN1 --left-of $EXTERN2
    xrandr --output $EXTERN1 --primary

}

# show "${c[RED]}============================================================="
