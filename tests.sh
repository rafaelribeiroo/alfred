#!/usr/bin/env zsh

declare -A e=(
    [door]=$'\360\237\232\252'
    [leo]=$'\360\237\246\201'
    [headphone]=$'\360\237\216\247'
    [landscape]=$'\360\237\214\211'
    [octopus]=$'\360\237\220\231'
    [globe]=$'\360\237\214\215'
    [camera]=$'\360\237\223\267'
    [rocket]=$'\360\237\232\200'
    [blind_monkey]=$'\360\237\231\210'
    [popcorn]=$'\360\237\215\277'
    [n]=$'\360\235\223\235'
    [elephant]=$'\360\237\220\230'
    [snake]=$'\360\237\220\215'
    [moon]=$'\360\237\214\230'
    [ruby]=$'\342\231\246\357\270\217'
    [letters]=$'\360\237\224\244'
    [magnet]=$'\360\237\247\262'
    [diamond]=$'\360\237\222\216'
    [suitcase]=$'\360\237\222\274'
    [paint]=$'\360\237\216\250'
    [whale]=$'\360\237\220\213'
    [flame]=$'\360\237\224\245'
    [silent_monkey]=$'\360\237\231\212'
    [bat]=$'\360\237\246\207'
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
    [file-ogg]=~/Downloads/manias.ogg
    [path-ogg]=/usr/share/mint-artwork/sounds/manias.ogg
    [login-file]=/org/cinnamon/sounds/login-file
)

name=(
    'MASTER WAYNE'
    'MASTER BRUCE'
    'MR. WAYNE'
    'MR. BRUCE'
)

random=$(shuf -i 0-$((${#name[@]}-1)) -n 1)


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

    : "xrandr --output $EXTERN2 --mode 1920x1080
   xrandr --output $EXTERN1 --mode 1920x1080
   xrandr --output $EXTERN1 --left-of $EXTERN2
   xrandr --output $EXTERN1 --primary
"
declare -a l=(
    'https://docs.google.com/uc?export=download&id=1gQQ6Xj2egQBZW9xugCK02NSnQEQPjE3V'
)

dconf write "${f[login-file]}" "'${f[path-ogg]}'"

curl --location --output "${f[ogg]}" --create-dirs "${l[0]}"
apt install docky
    sudo gconftool-2 --type Boolean --set /apps/docky-2/Docky/Items/DockyItem/ShowDockyItem False
    # Armazenando o docky ativo na var active
    active=$(gconftool-2 --get /apps/docky-2/Docky/DockController/ActiveDocks | sed 's/.*\[\([^]]*\)\].*/\1/g')
    # Configs pro docky ficar sobreposto a qualquer janela
    sudo gconftool --type string --set /apps/docky-2/Docky/Interface/DockPreferences/$active/Autohide 'UniversalIntellihide'
    sudo gconftool --type bool --set /apps/docky-2/Docky/Interface/DockPreferences/$active/FadeOnHide True
    sudo gconftool --type int --set /apps/docky-2/Docky/Interface/DockPreferences/$active/FadeOpacity 1
    # Temas
    sudo gconftool --type string --set /apps/docky-2/Docky/Services/ThemeService/Theme 'Smoke'
    sudo gconftool --type bool --set /apps/docky-2/Docky/Interface/DockPreferences/$active/ThreeDimensional True
    sudo gconftool --type bool --set /apps/docky-2/Docky/Interface/DockPreferences/$active/ZoomEnabled True
    sudo gconftool --type int --set /apps/docky-2/Docky/Interface/DockPreferences/$active/ZoomPercent 2
    sudo gconftool --type string --set /apps/docky-2/Docky/Interface/DockPreferences/$active/IconSize '50'
    sudo gconftool --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/$active/Plugins '[Clippy,Clock]'
    sudo gconftool --type string --set /apps/docky-2/Docky/Interface/DockPreferences/$active/Position 'Bottom'


}

# show "${c[RED]}=======================================================" 1

# zsh convention, anything after a ? is used as the prompt string
# https://superuser.com/questions/555874/zsh-read-command-fails-within-bash-function-read1-p-no-coprocess
# read -k 2 $'?\033[1;31m[    ]\033[m\033[4D' choice

declare -a d=(
    ~/.oh-my-zsh  # 1
)

if [[ -d "${d[1]}" ]]; then

    echo exists

else

    echo not

fi
