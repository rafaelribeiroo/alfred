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
    [gtk_theme_gnome]=/org/gnome/desktop/interface/gtk-theme
    [meslo]=~/.fonts/Meslo.zip/
    [int_brave]=./try.json
    [inter]="${HOME}"/.postman/InterceptorBridge/InterceptorBridge
    [int_chrome]=~/.config/google-chrome/NativeMessagingHosts/com.postman.postmanapp.json
)

name=(
    'MASTER WAYNE'
    'MASTER BRUCE'
    'MR. WAYNE'
    'MR. BRUCE'
)

random=$(shuf --input-range 1-${#name[@]} --head-count 1)

boilerplate() {

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

    jq -r '.lyrics.lines[].startTimeMs' lyrics.json
    jq -r '.lyrics.lines[].words' lyrics.json
    awk "BEGIN {print 38740/86400000}"

    milliseconds_to_duration () {
        local mins secs msec
        local tmp=$1
        (( mins = tmp / 60000, tmp %= 60000, secs = tmp / 1000, msec = tmp % 1000 ))
        printf "%02d:%02d.%03d\n" "$mins" "$secs" "$msec"
    }


}

# show "${c[RED]}=======================================================" 1
# https://stackoverflow.com/a/41212803/5465165

# [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] .*GNOME

# [[ getent group sudo | grep "${USER}" ]] \
#     && echo estou || echo n estou

# f+=(
#     [get_dock]=/apps/docky-2/Docky/DockController/ActiveDocks
# )

# if [[ $(xrandr --query | grep --count --word-regexp connected) -eq 2 ]] ; then

# get_dock=$(gconftool --get "${f[get_dock]}" | sed 's/[][]//g')

# a=("${(@s/,/)get_dock}")
# echo $a[2]
# for (( iterator=1; iterator<=${#a}; iterator++ )); do
#     echo $iterator
#     echo passei
# done
