#!/usr/bin/env zsh

# curl --silent --output alfred.sh --create-dirs 'https://raw.githubusercontent.com/rafaelribeiroo/alfred/build/zsh-alfred.sh'

#======================#
# ALFRED, programa de provisionamento de distro linux.
#======================#

#======================#
# Autor: Rafael Ribeiro
# e-mail <pereiraribeirorafael@gmail.com>
# Versão: 3.7
#======================#

#======================#
linen='-----------------------------------------'
linei='------------------------------------------'
lineu='-------------------------------------------'
linec='--------------------------------------------'
lineh='----------------------------------------------'

# ${#string} returns length string
# ${#string[@]} returns array size
# $((above)) syntax to arithmetics math
name=(
    'MASTER WAYNE'
    'MASTER BRUCE'
    'MR. WAYNE'
    'MR. BRUCE'
)

# em computacao nao existe aleatoriedade verdadeira, apenas aproximacao. Para
# se ter a aleatoriedade, teria que ser explorado a fundo a entropia
random=$(shuf --input-range 1-${#name[@]} --head-count 1)

# Associative array
declare -A c=(
    [WHITE]='\033[1;37m'
    [RED]='\033[31;1m'
    [RED-BLINK]='\033[31;1;5m'
    [GREEN]='\033[1;32m'
    [YELLOW]='\033[1;33m'
    [CYAN]='\033[1;36m'
    [END]='\e[0m'
)

logo=(
    " █████╗ ██╗     ███████╗██████╗ ███████╗██████╗"
    "██╔══██╗██║     ██╔════╝██╔══██╗██╔════╝██╔══██╗"
    "███████║██║     █████╗  ██████╔╝█████╗  ██║  ██║"
    "██╔══██║██║     ██╔══╝  ██╔══██╗██╔══╝  ██║  ██║"
    "██║  ██║███████╗██║     ██║  ██║███████╗██████╔╝"
    "╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝╚══════╝╚═════╝ "
)

# Indexed array
# Graphemica.com / onlineutf8tools.com/convert-utf8-to-octal
declare -A e=(
    [door]=$'\360\237\232\252'
    [alexa]=$'\360\237\227\243'
    [leo]=$'\360\237\246\201'
    [headphone]=$'\360\237\216\247'
    [control]=$'\360\237\216\233'
    [landscape]=$'\360\237\214\211'
    [octopus]=$'\360\237\220\231'
    [globe]=$'\360\237\214\215'
    [camera]=$'\360\237\223\267'
    [rocket]=$'\360\237\232\200'
    [blind_monkey]=$'\360\237\231\210'
    [popcorn]=$'\360\237\215\277'
    [n]=$'\360\235\223\235'
    [elephant]=$'\360\237\220\230'
    [satellite]=$'\360\237\233\260'
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
    [screensaver]=$'\360\237\222\276'
)

# usefull files
declare -A f=(
    # cryptsetup dont works with asterisk anymore
    # [askpass]=/lib/cryptsetup/askpass
    [askpass]=systemd-ask-password
    [custom_gnome]=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
    [custom_cinnamon]=/org/cinnamon/desktop/keybindings/custom-list
    [zshrc]=~/.zshrc
    [enabled_applets]=/org/cinnamon/enabled-applets
    [gtk_theme]=/org/cinnamon/desktop/interface/gtk-theme
    [gtk_theme_gnome]=/org/gnome/desktop/interface/gtk-theme
    [locale]=/etc/default/locale
    [mimeapps]=~/.config/mimeapps.list
    [mimebkp]=~/.config/mimeapps.bkp
    [null]=/dev/null
    [os_release]=/etc/os-release
    [public_ssh]=~/.ssh/id_rsa.pub
    [tmp_tk]=/tmp/check_token
    [user_dirs]=~/.config/user-dirs.dirs
    [srcs]=/etc/apt/sources.list
    [srcs_list]=/etc/apt/sources.list.d/
    [ssh]=/tmp/check_connection
    [apt_history]=/var/log/apt/history.log
    [update]=/tmp/check_update
    [passwd]=/etc/passwd
)
#======================#

#======================#
check_distro() {

    source "${f[os_release]}"

    if [[ "${NAME}" != 'Linux Mint' ]]; then

        show "\n   ${e[bat]} ${c[RED]}WHY DO WE FALL ${name[random]}? ${e[bat]}\n${c[CYAN]}SO WE CAN LEARN TO PICK OURSELVES UP \n"

        show "${c[RED]}YOU MUST RUN AT GOTHAM FOR A BETTER EXPERIENCE ${c[GREEN]}\n\t\t(MINT)\n"

        read $'?\033[1;37mDID U WANNA CONTINUE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                check_source

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                # Após a invocação de outro chamado, ele não sai completamente
                # do loop, sendo necessário a invocação e a interrupção do msm
                close_menu && break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U WANNA CONTINUE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        check_source

    fi

}
#======================#

#======================#
check_pkg() {

    # installed
    if dpkg-query --status "${1}" &> "${f[null]}"; then

        return 0

    else

        # installed and available
        if apt-cache show "${1}" &> "${f[null]}"; then

            return 1

        # not installed/available
        else

            return 2

        fi

    fi

}
#======================#

#======================#
check_source() {

    f+=(
        [alfred]=/usr/share/icons/jenkins-128x128.png
    )

    local -a l=(
        'https://icon-icons.com/downloadimage.php?id=170552&root=2699/PNG/128/&file=jenkins_logo_icon_170552.png'  # 1
    )

    # If script is not being sourced
    if [[ "${BASH_SOURCE[0]}" -ef "${0}" ]]; then

        show "\n${c[RED-BLINK]}PLEASE, RUNS: source zsh-alfred.sh\n" 1 && exit

    else

        if [[ ! -e "${f[update]}" ]]; then

            clear && show "\nCHECKING TOTAL OF PACKAGES TO BE UPGRADED..."

            [[ ! -e "${f[alfred]}" ]] \
                && sudo curl --silent --location --output "${f[alfred]}" --create-dirs "${l[1]}"

            apt update 2>&- | tail -1 | awk {'print $1'} &> "${f[update]}"

            [[ $(cat "${f[update]}") -ge 50 ]] \
                && show "\nHOLY ${name[random]}! THERE'S MORE THAN FIFTY POSSIBLE TREATS...\nUPGRADING YOUR ${c[RED]}ARSENAL" \
                && upgrade

        fi

        clear && show "\n${c[RED]}===[${c[WHITE]} STARTING ${c[RED]}]===\n"

        clear && menu

    fi

}
#======================#

#======================#
check_ssh() {

    # Generate SSH keys silently. Ignore if exists
    # -N new_passphrase
    [[ ! -e "${f[public_ssh]}" ]] && yes "" | ssh-keygen -N "" &> "${f[null]}"

}
#======================#

#======================#
close_menu() {

    show "\n\t\t   ${c[RED]}FOR YOUR OWN SAKE,\n\t      ${c[CYAN]}THERE IS NO TURNING BACK...\n"

    [[ "${BASH_SOURCE[0]}" -ef "${0}" ]] && exit || return 0

}
#======================#

#======================#
show() {

    echo -e ${c[WHITE]}"${1}"${c[END]}

    # Don't sleep if 2ø argument exists (1)
    [[ "${2}" -ne 1 ]] && take_a_break || return 0

}
#======================#

#======================#
install_packages() {

    # $@: Trick to unpack all received values
    for package in "${@}"; do

        if check_pkg "${package}"; then

            echo && show "${c[GREEN]}${package:u} ${c[WHITE]}${linei:${#package}} [INSTALLED]"

        else

            if test "${?}" -eq 1; then

                echo && show "${c[YELLOW]}${package:u} ${c[WHITE]}${linen:${#package}} [INSTALLING]"

                sudo apt install --assume-yes "${package}" &> "${f[null]}"

                notify-send "Status from Alfred" "${package} was installed successfully" --icon="${f[alfred]}"

            fi

        fi

    done

}
#======================#

#======================#
install_pip(){

    for package in "$@"; do

        if [[ $(pip list 2>&- | grep --no-messages "${package}") ]]; then

            echo && show "${c[GREEN]}${package:u} ${c[WHITE]}${linei:${#package}} [INSTALLED]"

        else

            echo && show "${c[YELLOW]}${package:u} ${c[WHITE]}${linen:${#package}} [INSTALLING]"

            pip install --quiet --no-warn-script-location "${package}"

            notify-send "Status from Alfred" "${package} was installed successfully" --icon="${f[alfred]}"

        fi

    done

}
#======================#

#======================#
remove_useless() {

    sudo apt autoremove --yes &> "${f[null]}"

    sudo apt autoclean > "${f[null]}"

}
#======================#

#======================#
return_menu() {

    show "${c[RED]}\n\tWHAT IS THE POINT OF ALL THOSE PUSHUPS?\n ${c[CYAN]}\t  IF YOU CAN'T EVEN LIFT A BLOODY LOG"

    clear; menu

}
#======================#

#======================#
take_a_break() {

    # O s é desnecessário, mas nas conferências eles solicitam
    sleep 3s

}
#======================#

thatsallfolks() {

    unset d f l m

    show "\nOPERATION COMPLETED SUCCESSFULLY, ${name[random]}!\n"

    [[ "${1}" -ne 1 ]] && show "${c[RED]}––––––––––––––––––––––– ${c[YELLOW]}END ${c[GREEN]}${choice} ${c[RED]}––––––––––––––––––––––––" 1

}

#======================#
update() {

    # &> redirects stdout and stderr to file
    sudo apt update &> "${f[null]}"

}
#======================#

#======================#
uninstall_or_configure() {

    echo; show "${c[RED]}––––––––––––––––––– ${c[YELLOW]}YOUR CHOICE: ${c[GREEN]}${choice} ${c[RED]}–––––––––––––––––––" 1

    if [[ "${1}" ]]; then

        show "\n${c[GREEN]}${m[0]:u} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]:u}${c[WHITE]}!"

                return 0

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I COMEBACK TO STATUS QUO?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        "${2}" 1

        "${3}"

    fi

    show "INITIALIZING CONFIGS..."

    return 1

}
#======================#

#======================#
alexa_stuffs() {

    local -a d=(
        ~/.TRIGGERcmdData/  # 1
        ~/.nvm/  # 2
    )

    local -a m=(
        'triggercmdagent'  # 1
        'gawk'  # 2
        'nodejs'  # 3
        'minidlna'  # 4
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

    source "${f[user_dirs]}"

    f+=(
        [file]=/tmp/triggercmdagent_1.0.1_amd64.deb
        [agent]=/usr/lib/triggercmdagent/resources/app/src/agent.js
        [check_token]=/tmp/check_tk
        [cmds]=~/.TRIGGERcmdData/commands.json
        [pc_id]=~/.TRIGGERcmdData/computerid.cfg
        [daemon]=/usr/lib/triggercmdagent/resources/app/src/daemon.js
    )

    local -a l=(
        'https://s3.amazonaws.com/triggercmdagents/triggercmdagent_1.0.1_amd64.deb'  # 1
        'https://nodejs.org/en/'  # 2
        'https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh'  # 3
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"



                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n     I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_packages "${m[3]}"

        show "\n${c[YELLOW]}${m[1]:u} ${c[WHITE]}${linen:${#m[1]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[1]}"

        sudo dpkg --install "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    latest=$(curl --silent "${l[2]}" | grep data-version | head -1 | awk '{print $5}')

    local=$(apt version "${m[3]}")

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read $'?\033[1;37mSIR, SHOULD I UPGRADE NODEJS VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                [[ ! -d "${d[2]}" ]] \
                    && curl --output - "${l[3]}" | zsh

                [[ ! $(grep --no-messages '.nvm' "${f[zshrc]}") ]] \
                    && sudo tee "${f[zshrc]}" > "${f[null]}" <<< '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' \
                    && source "${f[zshrc]}"

                # nvm ls-remote
                nvm install "${latest}" &> "${f[null]}"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    if [[ ! -e "${f[pc_id]}" ]]; then

        echo; show "${c[RED]}SIR${c[WHITE]}, CREATE AN ACCOUNT IN https://www.triggercmd.com/user/auth/login\nAFTER THAT, COPY TOKEN FROM ${c[RED]}INSTRUCTIONS ${c[WHITE]} PANEL AND PASTE IN GUI SCREEN"

        ( nohup "${m[1]}" & ) &> "${f[check_token]}"

        for (( ; ; )); do

            take_a_break

            # node /usr/lib/triggercmdagent/resources/app/src/agent.js --console
            [[ $(grep --no-messages 'Now connected' "${f[check_token]}") ]] \
                && break || show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!"

        done

    fi

    [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
        && show "\nFIRST THINGS FIRST. DO U PASS THROUGH MINIDLNA?" \
        && minidlna_stuffs

    [[ ! $(grep --no-messages 'icarus' "${f[cmds]}") ]] \
        && sudo tee "${f[cmds]}" > "${f[null]}" <<< '[
  {"trigger":"Reboot","command":"shutdown -r","ground":"background","voice":"init seis","allowParams": "false"},
  {"trigger":"Shut down","command":"shutdown -n now","ground":"background","voice":"protocolo icarus","allowParams": "false"},
  {"trigger":"MiniDLNA Restart","command":"sudo service minidlna restart && sudo service minidlna force-reload","ground":"background","voice":"init tres","allowParams": "false"}
]'

    ( nohup node "${f[daemon]}" --run "${d[1]}" & ) &> "${f[null]}"

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
brave_stuffs() {

    local -a d=(
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org/  # 1
        /opt/brave.com/  # 2
        ~/.config/BraveSoftware/  # 3
        ~/.cache/BraveSoftware/  # 4
    )

    f+=(
        [gpg]=/etc/apt/trusted.gpg.d/brave-browser-release.gpg
        [ppa]=/etc/apt/sources.list.d/brave-browser-release.list
        [exe_1]=/usr/bin/brave-browser
        [exe_2]=/usr/bin/brave-browser-stable
    )

    local -a l=(
        'https://brave-browser-apt-release.s3.brave.com/brave-core.asc'  # 1
        'https://brave-browser-apt-release.s3.brave.com/'  # 2
    )

    local -a m=(
        'brave-browser'  # 1
        'apt-transport-https'  # 2
        'curl'  # 3
        'gnupg'  # 4
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" &> "${f[null]}"

                remove_useless

                sudo sed --in-place '/brave/d' "${d[1]}"*.json

                sudo sed --in-place '/brave/d' "${f[mimeapps]}"

                sudo rm --force --recursive "${d[2]}" "${d[3]}" "${d[4]}"

                sudo rm --force "${f[exe_1]}" "${f[exe_2]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep brave) ]] \
            && curl --silent "${l[1]}" | sudo apt-key --keyring "${f[gpg]}" add - &> "${f[null]}"

        [[ ! -e "${f[ppa]}" ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb [arch=amd64] ${l[2]} stable main" \
            && update

        # Dependencies
        install_packages "${m[2]}" "${m[3]}" "${m[4]}" "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    echo; read $'?\033[1;37mSIR, SHOULD I OPEN BRAVE? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            ( nohup "${m[1]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
deemix_stuffs() {

    local -a d=(
        /tmp/  # 1
        ~/Musicas\ Deemix/  # 2
        ~/.cache/thumbnails/fail  # 3
        ~/.config/deemix/  # 4
        ~/.config/deemix-gui/  # 5
    )

    f+=(
        [file]="${d[1]}"linux-x86_64-latest.deb
        [decrypt]=/etc/browser_cookie3_n.py
        [cookies]="${d[1]}"cookies
        [arl_value]="${d[4]}".arl
        [cfg]="${d[4]}"config.json
    )

    local -a l=(
        'https://download.deemix.workers.dev/gui/linux-x64-latest.deb'  # 1
        'https://raw.githubusercontent.com/rachpt/lanzou-gui/master/lanzou/browser_cookie3_n.py'  # 2
    )

    local -a m=(
        'deemix-gui'  # 1
        'xplayer'  # 2
        'certifi'  # 3
        'cffi'  # 4
        'chardet'  # 5
        'cryptography'  # 6
        'idna'  # 7
        'jeepney'  # 8
        'keyring'  # 9
        'lz4'  # 10
        'pbkdf2'  # 11
        'pyaes'  # 12
        'pycparser'  # 13
        'pycryptodome'  # 14
        'PyQt5'  # 15
        'PyQt5-sip'  # 16
        'PyQtWebEngine'  # 17
        'requests'  # 18
        'requests-toolbelt'  # 19
        'SecretStorage'  # 20
        'six'  # 21
        'urllib3'  # 22
        'lanzou-gui'  # 23
        'google-chrome-stable'  # 24
        'xsel'  # 25
        'gawk'  # 26
        'python-is-python3'  # 27
        'wheel'  # 28
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[26]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, WE MUST INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[26]}"

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[25]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" "${m[2]}" "${m[25]}" &> "${f[null]}"

                remove_useless

                pip uninstall --quiet "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}" "${m[18]}" "${m[19]}" "${m[20]}" "${m[21]}" "${m[22]}"

                sudo rm --force --recursive "${d[4]}" "${d[5]}"

                sudo rm --force "${f[decrypt]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # Dependencies
        install_packages "${m[2]}" "${m[25]}"

        show "\n${c[YELLOW]}${m[1]:u} ${c[WHITE]}${linen:${#m[1]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[1]}"

        sudo dpkg --install "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

        [[ ! $(dpkg --list | awk "/ii  ${m[27]}[[:space:]]/ {print }") ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH PYTHON?" \
            && python_stuffs

        echo; show "SIR, BEFORE PROCEED WE NEED TO GET YOUR ARL..."

        show "${c[GREEN]}\n        I${c[WHITE]}NSTALLING ${c[GREEN]}${m[23]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_pip "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[28]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}" "${m[18]}" "${m[19]}" "${m[20]}" "${m[21]}" "${m[22]}"

        if [[ ! -e "${f[decrypt]}" ]]; then

            show "\n${c[YELLOW]}${m[23]:u} ${c[WHITE]}${linen:${#m[23]}} [INSTALLING]"

            sudo wget --quiet "${l[2]}" --output-document "${f[decrypt]}"

        else

            show "\n${c[GREEN]}${m[23]:u} ${c[WHITE]}${linei:${#m[23]}} [INSTALLED]"

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ ! $(dpkg --list | awk "/ii  ${m[24]}[[:space:]]/ {print }") ]] \
        && show "\nFIRST THINGS FIRST. DO U PASS THROUGH CHROME?" \
        && chrome_stuffs

    while [[ ! -d "${d[4]}" ]]; do

        show "\nRESTARTING DEEMIX TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[1]}" & ) &> "${f[null]}"

        take_a_break

        sudo pkill "${m[1]}"

        take_a_break

    done

    if [[ ! -e "${f[arl_value]}" ]]; then

        for (( ; ; )); do

            python "${f[decrypt]}" &> "${f[cookies]}"

            [[ ! $(grep --no-messages 'Cookie arl' "${f[cookies]}") ]] \
                && show "\nDO U NEED TO LOG IN INTO DEEZER FROM CHROME BEFORE PROCEED" \
                && sleep 10s \
                && continue \
                || sudo tee --append "${f[arl_value]}" > "${f[null]}" <<< "$(grep --extended-regexp --only-matching 'Cookie arl=.{,192}' ${f[cookies]} | awk --field-separator== '{print $2}')" \
                && break

        done

    fi

    cat "${f[arl_value]}" | xsel --clipboard

    source "${f[user_dirs]}"

    [[ ! $(grep --no-messages 'alias cm' "${f[zshrc]}") ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
alias cm=\"rename 's/^(Dj|dj|mc|Mc)/\U$1/' ${XDG_MUSIC_DIR}/* && rename 's|AC_DC|ACDC|g' ${XDG_MUSIC_DIR}/* && rename 's/ \([A-a]o [V-v]ivo.*\)| \([L-l]ive.*\)//' ${XDG_MUSIC_DIR}/*\""

    [[ ! $(grep --no-messages 'autoCheckForUpdates' "${f[cfg]}") ]] \
        && sudo sed --in-place --null-data 's|}|},\n  "autoCheckForUpdates": true|1' "${f[cfg]}"

    sudo sed --in-place "s|\"downloadLocation\".*|\"downloadLocation\": \"${XDG_MUSIC_DIR}\",|g" "${f[cfg]}"

    sudo sed --in-place 's|"saveArtwork":.*|"saveArtwork": false,|g' "${f[cfg]}"

    sudo sed --in-place 's|"explicit":.*|"explicit": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"syncedLyrics":.*|"syncedLyrics": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"queueConcurrency":.*|"queueConcurrency": 50,|g' "${f[cfg]}"

    sudo sed --in-place 's|"maxBitrate":.*|"maxBitrate": "3",|g' "${f[cfg]}"

    sudo sed --in-place 's|"titleCasing":.*|"titleCasing": "start",|g' "${f[cfg]}"

    sudo sed --in-place 's|"syncedLyrics":.*|"syncedLyrics": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"artistCasing":.*|"artistCasing": "start",|g' "${f[cfg]}"

    sudo sed --in-place 's|"featuredToTitle":.*|"featuredToTitle": "1",|g' "${f[cfg]}"

    sudo sed --in-place 's|"removeAlbumVersion":.*|"removeAlbumVersion": true,|g' "${f[cfg]}"

    sudo sed --in-place "s|\"executeCommand\":.*|\"executeCommand\": \"zsh -c \$(cm) &> /dev/null\",|g" "${f[cfg]}"

    # In pt_BR language, deemix not recognizes ú from Músicas.
    if [[ $(echo "${LANG}" | awk --field-separator=. '{print $1}') = 'pt_BR' ]]; then

        [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

        sudo sed --in-place "s|\"downloadLocation\": \"${XDG_MUSIC_DIR}/deemix Music/\",|\"downloadLocation\": \"${d[2]}\",|g" "${f[cfg]}"

    fi

    [[ ! $(grep --no-messages '"albumTracknameTemplate": "%artist% - %title%"' "${f[cfg]}") ]] \
        && sudo sed --in-place 's|"albumTracknameTemplate": "%tracknumber% - %title%",|"albumTracknameTemplate": "%artist% - %title%",|g' "${f[cfg]}"

    [[ ! $(grep --no-messages 'alias ct' "${f[zshrc]}") ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
alias ct='rm --recursive --force ${d[3]}'"

    [[ -e "${f[file]}" ]] \
        && sudo rm --force "${f[file]}"

    curl --silent --location --output "${f[file]}" --create-dirs "${l[1]}"

    latest=$(dpkg-deb --info "${f[file]}" | grep 'Version' | awk '{print $2}')

    local=$(apt version "${m[1]}")

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read $'?\033[1;37mSIR, SHOULD I UPGRADE DEEMIX-GUI VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                sudo dpkg --install "${f[file]}" &> "${f[null]}"

                sudo rm --force "${f[file]}"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    echo; read $'?\033[1;37mSIR, SHOULD I OPEN DEEMIX? (CLIPBOARD CONTAINS ARL) \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            ( nohup "${m[1]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
docky_stuffs() {

    local -a d=(
        /tmp/  # 1
        ~/.local/share/cinnamon/applets/  # 2
        ~/.local/share/cinnamon/applets/separator2@zyzz  # 3
        ~/.local/share/cinnamon/applets/force-quit@cinnamon.org  # 4
        ~/.cinnamon/configs/calendar@cinnamon.org  # 5
    )

    local -a m=(
        'libgconf2.0-cil'  # 1
        'multiarch-support'  # 2
        'libgnome-keyring-common'  # 3
        'libgnome-keyring0:amd64'  # 4
        'libgnome-keyring1.0-cil'  # 5
        'docky'  # 6
        'gconf-editor'  # 7
        'brave-browser'  # 8
        'sublime-text'  # 9
        'telegram-desktop'  # 10
        'dconf-editor'  # 11
        'gconf-defaults-service'  # 12
    )

    f+=(
        [icons]=/apps/docky-2/Docky/Items/DockyItem/
        [theme]=/apps/docky-2/Docky/Services/ThemeService/Theme
        [dep1]=/tmp/libgconf2.0-cil_2.24.2-4_all.deb
        [dep2]=/tmp/multiarch-support_2.27-3ubuntu1_amd64.deb
        [dep3]=/tmp/libgnome-keyring-common_3.12.0-1build1_all.deb
        [dep4]=/tmp/libgnome-keyring0_3.12.0-1build1_amd64.deb
        [dep5]=/tmp/libgnome-keyring1.0-cil_1.0.0-5_amd64.deb
        [docky_run]=/tmp/docky_2.2.1.1-1_all.deb
        [forceqt]=~/.local/share/cinnamon/applets/force-quit@cinnamon.org.zip
        [separator2]=~/.local/share/cinnamon/applets/separator2@zyzz.zip
        [grouped]=~/.cinnamon/configs/grouped-window-list@cinnamon.org/2.json
        [panel_pos]=/org/cinnamon/panels-enabled
        [panel_size]=/org/cinnamon/panels-height
        [fix-broken]=/tmp/check_upgrade
        [gconf_d]=/tmp/gconf-editor_3.0.1-6_amd64.deb
        [tray_update]=/com/linuxmint/updates/hide-systray
        [timeshift]=/com/linuxmint/report/ignored-reports
    )

    local -a l=(
        'http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-sharp2/libgconf2.0-cil_2.24.2-4_all.deb'  # 1
        'http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1_amd64.deb'  # 2
        'http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring-common_3.12.0-1build1_all.deb'  # 3
        'http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring0_3.12.0-1build1_amd64.deb'  # 4
        'http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-keyring-sharp/libgnome-keyring1.0-cil_1.0.0-5_amd64.deb'  # 5
        'http://archive.ubuntu.com/ubuntu/pool/universe/d/docky/docky_2.2.1.1-1_all.deb'  # 6
        'https://cinnamon-spices.linuxmint.com/files/applets/separator2@zyzz.zip'  # 7
        'https://cinnamon-spices.linuxmint.com/files/applets/force-quit@cinnamon.org.zip'  # 8
        'http://ftp.de.debian.org/debian/pool/main/g/gconf-editor/gconf-editor_3.0.1-6_amd64.deb'  # 9
    )

    if [[ $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[6]:u} ${c[WHITE]}${linei:${#m[6]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[6]:u}${c[WHITE]}!\n"






                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[6]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # Dependencies
        if [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]]; then

            install_packages "${m[11]}" "${m[12]}"

            [[ $(dpkg --list | awk "/ii  ${m[7]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[7]:u} ${c[WHITE]}${linei:${#m[7]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[7]:u} ${c[WHITE]}${linen:${#m[7]}} [INSTALLING]" \
                && sudo wget --quiet "${l[9]}" --output-document "${f[gconf_d]}" \
                && sudo dpkg --install "${f[gconf_d]}" &> "${f[null]}"

        fi

        for (( iterator=1; iterator<=5; iterator++ )); do

            [[ $(dpkg --list | awk "/ii  ${m[iterator]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[iterator]:u} ${c[WHITE]}${linei:${#m[iterator]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[iterator]:u} ${c[WHITE]}${linen:${#m[iterator]}} [INSTALLING]" \
                && sudo wget --quiet "${l[iterator]}" --output-document "${f[dep${iterator}]}" \
                && sudo dpkg --install "${f[dep${iterator}]}" &> "${f[null]}"

        done

        unset iterator

        [[ ! -e "${f[docky_run]}" ]] \
            && show "\n${c[YELLOW]}${m[6]:u} ${c[WHITE]}${linen:${#m[6]}} [INSTALLING]" \
            && sudo wget --quiet "${l[6]}" --output-document "${f[docky_run]}"

        sudo dpkg --install "${f[docky_run]}" &> "${f[null]}"

        sudo apt --fix-broken --yes install &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    f+=(
        [get_dock]=/apps/docky-2/Docky/DockController/ActiveDocks
    )

    while [[ ! -d "${d[6]}" ]]; do

        show "\nRESTARTING DOCKY TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[6]}" & ) &> "${f[null]}"

        get_dock=$(gconftool --get "${f[get_dock]}" | sed 's/[][]//g')

        d+=(
           ~/.gconf/apps/docky-2/Docky/Interface/DockPreferences/"${get_dock}"  # 6
        )

        take_a_break

        sudo pkill "${m[6]}"

        take_a_break

    done

    f+=(
        [pref]=/apps/docky-2/Docky/Interface/DockPreferences/"${get_dock}"/
    )

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && gconftool --type bool --set "${f[icons]}"ShowDockyItem False \
        && gconftool --type bool --set "${f[pref]}"FadeOnHide True \
        && gconftool --type bool --set "${f[pref]}"ThreeDimensional True \
        && gconftool --type bool --set "${f[pref]}"ZoomEnabled True \
        && gconftool --type float --set "${f[pref]}"FadeOpacity 1 \
        && gconftool --type int --set "${f[pref]}"IconSize 50 \
        && gconftool --type int --set "${f[pref]}"ZoomPercent 2 \
        && gconftool --type list --list-type string --set "${f[pref]}"Plugins '[Clock]' \
        && gconftool --type list --list-type string --set "${f[pref]}"Launchers '[]' \
        && gconftool --type list --list-type string --set "${f[pref]}"SortList '[]' \
        && gconftool --type string --set "${f[pref]}"Autohide 'UniversalIntellihide' \
        && gconftool --type string --set "${f[theme]}" 'Transparent' \
        && gconftool --type string --set "${f[pref]}"Position 'Bottom' \
        && dconf write "${f[panel_pos]}" "['1:0:top']" \
        && dconf write "${f[panel_size]}" "['1:40']" \
        && dconf write "${f[tray_update]}" true \
        && dconf write "${f[timeshift]}" "['timeshift-no-setup']"

    # Adding double applets and organizing
    if [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]]; then

        [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != "${USER}" ]] \
            && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

        [[ ! -e "${f[separator2]}" && ! -d "${d[3]}" ]] \
            && wget --quiet "${l[7]}" --output-document "${f[separator2]}" \
            && unzip "${f[separator2]}" -d "${d[2]}" &> "${f[null]}" \
            && sudo rm --force "${f[separator2]}"

        [[ ! -e "${f[forceqt]}" && ! -d "${d[4]}" ]] \
            && wget --quiet "${l[8]}" --output-document "${f[forceqt]}" \
            && unzip "${f[forceqt]}" -d "${d[2]}" &> "${f[null]}" \
            && sudo rm --force "${f[forceqt]}"

        dconf write "${f[enabled_applets]}" "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:show-desktop@cinnamon.org:1', 'panel1:left:2:grouped-window-list@cinnamon.org:2', 'panel1:right:3:removable-drives@cinnamon.org:3', 'panel1:right:4:separator@cinnamon.org:4', 'panel1:right:5:separator@cinnamon.org:5', 'panel1:right:6:notifications@cinnamon.org:6', 'panel1:right:7:keyboard@cinnamon.org:7', 'panel1:right:8:separator@cinnamon.org:8', 'panel1:right:9:separator@cinnamon.org:9', 'panel1:right:10:force-quit@cinnamon.org:10', 'panel1:right:11:separator@cinnamon.org:11', 'panel1:right:12:separator@cinnamon.org:12', 'panel1:right:13:xapp-status@cinnamon.org:13', 'panel1:right:14:separator@cinnamon.org:14', 'panel1:right:15:separator@cinnamon.org:15', 'panel1:right:16:network@cinnamon.org:16', 'panel1:right:17:separator2@zyzz:17', 'panel1:right:18:calendar@cinnamon.org:18']"

        take_a_break

        f+=(
            [calendar]=~/.cinnamon/configs/calendar@cinnamon.org/$(find "${d[5]}" -maxdepth 1 -type f | awk --field-separator=/ '{print $7}')
        )

        # use custom format
        sudo sed --in-place --null-data 's|false|true|3' "${f[calendar]}"

        sudo sed --in-place --null-data 's|false|true|4' "${f[calendar]}"

        sudo sed --in-place --null-data 's|%A, %B %e, %H:%M|%e.  %B, %H:%M|2' "${f[calendar]}"

    fi

    # Order icons at grouped-windows-list
    if [[ ! $(sed --quiet '/"pinned-apps":/,/]/p' "${f[grouped]}" | grep sublime_text) && "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]]; then

        [[ ! $(dpkg --list | awk "/ii  ${m[8]}[[:space:]]/ {print }") ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH BRAVE BROWSER?" \
            && brave_stuffs

        [[ ! $(dpkg --list | awk "/ii  ${m[9]}[[:space:]]/ {print }") ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH SUBLIME TEXT?" \
            && sublime_stuffs

        [[ ! $(dpkg --list | awk "/ii  ${m[10]}[[:space:]]/ {print }") ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH USEFULL PACKAGES?" \
            && usefull_pkgs

        sudo sed --in-place --null-data 's|"firefox.desktop",|"brave-browser.desktop",|2' "${f[grouped]}"

        sudo sed --in-place '166 a\'"$(printf '%.s ' {0..11})"'"firefox.desktop",' "${f[grouped]}"

        sudo sed --in-place '167 a\'"$(printf '%.s ' {0..11})"'"transmission-gtk.desktop",' "${f[grouped]}"

        sudo sed --in-place --null-data 's|"org.gnome.Terminal.desktop",|"nemo.desktop",|2' "${f[grouped]}"

        sudo sed --in-place --null-data 's|"nemo.desktop"|"org.gnome.Terminal.desktop"|3' "${f[grouped]}"

        sudo sed --in-place '166 a\'"$(printf '%.s ' {0..11})"'"telegramdesktop.desktop",' "${f[grouped]}"

        sudo sed --in-place '170 a\'"$(printf '%.s ' {0..11})"'"sublime_text.desktop",' "${f[grouped]}"

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
dualmonitor_stuffs() {

    local -a d=(
        /usr/share/backgrounds/customized/  # 1
        ~/.var/app/es.estoes.wallpaperDownloader/  # 2
        ~/.wallpaperdownloader/downloads/  # 3
        ~/.wallpaperdownloader/  # 4
        ~/.config/autostart/  # 5
    )

    f+=(
        [default]=/usr/share/backgrounds/linuxmint/default_background.jpg
        [picture]=/org/cinnamon/desktop/background/picture-uri
        [picture_gnome]=/org/gnome/desktop/background/picture-uri
        [option]=/org/cinnamon/desktop/background/picture-options
        [option_gnome]=/org/gnome/desktop/background/picture-options
        [slideshow]=/org/cinnamon/desktop/background/slideshow/slideshow-enabled
        [source]=/org/cinnamon/desktop/background/slideshow/image-source
        [delay]=/org/cinnamon/desktop/background/slideshow/delay
        [libglew]=/tmp/libglew2.1_2.1.0-4+b1_amd64.deb
        [lw_cfg]=/tmp/livewallpaper-config_0.5.0-0~333~ubuntu20.04.1_amd64.deb
        [lw_indicator]=/tmp/livewallpaper-indicator_0.5.0-0~333~ubuntu20.04.1_amd64.deb
        [lw]=/tmp/livewallpaper_0.5.0-0~333~ubuntu20.04.1_amd64.deb
        [pkg]=es.estoes.wallpaperDownloader
        [bkg_1]="${d[3]}"sw.jpg
        [config]="${d[4]}"config.txt
        [dskt]="${d[5]}"wallpaperdownloader.desktop
        [older]="${d[4]}"wallpaperdownloader.desktop
    )

    # 3840x1080 wallpaper
    local -a l=(
        'http://ftp.de.debian.org/debian/pool/main/g/glew/libglew2.1_2.1.0-4+b1_amd64.deb'  # 1
        'https://launchpad.net/~fyrmir/+archive/ubuntu/livewallpaper-daily/+files/livewallpaper_0.5.0-0~333~ubuntu20.04.1_amd64.deb'  # 2
        'https://launchpad.net/~fyrmir/+archive/ubuntu/livewallpaper-daily/+files/livewallpaper-indicator_0.5.0-0~333~ubuntu20.04.1_amd64.deb'  # 3
        'https://launchpad.net/~fyrmir/+archive/ubuntu/livewallpaper-daily/+files/livewallpaper-config_0.5.0-0~333~ubuntu20.04.1_amd64.deb'  # 4
        'https://flathub.org/repo/flathub.flatpakrepo' # 5
        'https://images3.alphacoders.com/673/673177.jpg'  # 6
    )

    local -a m=(
        'wallpapers'  # 1
        'dconf-editor'  # 2
        'python3-opengl'  # 3
        'libglew2.1'  # 4
        'livewallpaper'  # 5
        'livewallpaper-indicator'  # 6
        'livewallpaper-config'  # 7
        'wallpaperDownloader'  # 8
        'flatpak'  # 9
        'flathub'  # 10
    )

    if [[ $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && -e "${d[1]}" ]]; then
        # 2>&- if dconf not installed

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linec:${#m[1]}} [APPLIED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NSETTING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo rm --force --recursive "${d[1]}"

                sudo rm --force "${f[src]}"

                dconf write "${f[picture]}" "'${f[default]}'"

                dconf write "${f[option]}" "'zoom'"

                dconf write "${f[slideshow]}" false

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  S${c[WHITE]}ETING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[2]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    echo; read $'?\033[1;37mSIR, DO YOU PREFER ANIMATED WALLPAPER OVER STATIC? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[5]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

            install_packages "${m[3]}"

            [[ $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[4]:u} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[4]:u} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                && sudo wget --quiet "${l[1]}" --output-document "${f[libglew]}" \
                && sudo dpkg --install "${f[libglew]}" &> "${f[null]}"

            [[ $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[5]:u} ${c[WHITE]}${linei:${#m[5]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[5]:u} ${c[WHITE]}${linen:${#m[5]}} [INSTALLING]" \
                && sudo wget --quiet "${l[2]}" --output-document "${f[lw]}" \
                && sudo dpkg --install "${f[lw]}" &> "${f[null]}"

            [[ $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[6]:u} ${c[WHITE]}${linei:${#m[6]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[6]:u} ${c[WHITE]}${linen:${#m[6]}} [INSTALLING]" \
                && sudo wget --quiet "${l[3]}" --output-document "${f[lw_indicator]}" \
                && sudo dpkg --install "${f[lw_indicator]}" &> "${f[null]}"

            [[ $(dpkg --list | awk "/ii  ${m[7]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[7]:u} ${c[WHITE]}${linei:${#m[7]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[7]:u} ${c[WHITE]}${linen:${#m[7]}} [INSTALLING]" \
                && sudo wget --quiet "${l[4]}" --output-document "${f[lw_cfg]}" \
                && sudo dpkg --install "${f[lw_cfg]}" &> "${f[null]}"

            echo; read $'?\033[1;37mSIR, SHOULD I OPEN LIVE WALLPAPER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    ( nohup "${m[7]}" & ) &> "${f[null]}"

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            # --word-regexp don't match with disconnected
            # dual monitor wallpaper
            if [[ $(xrandr --query | grep --count --word-regexp connected) -eq 2 ]] ; then

                if [[ ! $(sudo flatpak list 2>&- | grep --no-messages "${m[8]}") ]]; then

                    if [[ ! $(sudo flatpak remotes 2>&- | grep --no-messages "${m[10]}") ]]; then

                        sudo flatpak remote-add "${m[10]}" "${l[5]}"  # --if-not-exists

                        echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                        for (( ; ; )); do

                            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                                sudo reboot

                            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                                break

                            else

                                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                                read option

                            fi

                        done

                    fi

                    show "\n${c[YELLOW]}${m[8]:u} ${c[WHITE]}${linen:${#m[8]}} [INSTALLING]"

                    flatpak install --assumeyes "${m[10]}" "${f[pkg]}" &> "${f[null]}"

                fi

                while [[ ! -d "${d[4]}" ]]; do

                    show "\nRESTARTING WALLPAPER DOWNLOADER TO GENERATE CONFIG FILES.\nWAIT..."

                    ( flatpak run "${f[pkg]}" & ) &> "${f[null]}"

                    take_a_break

                    flatpak kill "${f[pkg]}"

                    take_a_break

                done

                [[ ! -d "${d[3]}" || $(stat --format="%U" "${d[3]}" 2>&-) != "${USER}" ]] \
                    && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
                    && sudo mkdir --parents "${d[3]}" > "${f[null]}" \
                    && sudo chown --recursive "${USER}":"${USER}" "${d[3]}"

                [[ ! -e "${f[bkg_1]}" ]] \
                    && curl --silent --output "${f[bkg_1]}" --create-dirs "${l[6]}"

                sudo sed --in-place "s|${pkg}.window.wallpaper-resolution.*|${pkg}.window.wallpaper-resolution=3840x1080|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.download-policy.*|${pkg}.window.download-policy=2|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.provider-devianart.*|${pkg}.window.provider-devianart=yes|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.provider-dualMonitorBackgrounds.*|${pkg}.window.provider-dualMonitorBackgrounds=yes|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.provider-bing.*|${pkg}.window.provider-bing=yes|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.provider-socialWallpapering.*|${pkg}.window.provider-socialWallpapering=yes|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.provider-wallhaven.*|${pkg}.window.provider-wallhaven=yes|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.provider-unsplash.*|${pkg}.window.provider-unsplash=yes|g" "${f[config]}"

                sudo sed --in-place "s|${pkg}.window.application-max-download-folder-size.*|${pkg}.window.application-max-download-folder-size=1024|g" "${f[config]}"

                [[ ! -L "${f[dskt]}" ]] \
                    && sudo ln --force --symbolic "${f[older]}" "${f[dskt]}"

                [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]] \
                    && dconf write "${f[picture_gnome]}" "'file://${f[bkg_1]}'" \
                    && dconf write "${f[option_gnome]}" "'spanned'"

                [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
                    && dconf write "${f[picture]}" "'file://${f[bkg_1]}'" \
                    && dconf write "${f[option]}" "'spanned'" \
                    && dconf write "${f[slideshow]}" true \
                    && dconf write "${f[source]}" "'directory://${d[3]}'" \
                    && dconf write "${f[delay]}" 15

                break

            else

                show "\nYOU DON'T HAVE DUAL MONITOR SETUP. EXITING..."

            fi

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U PREFER ANIMATED BACKGROUND?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
github_stuffs() {

    local -a l=(
        'https://api.github.com/user/keys'  # 1
        'https://git-scm.com/'  # 2
        'keyserver.ubuntu.com'  # 3
        'https://cli.github.com/packages'  # 4
        'https://api.github.com/rate_limit'  # 5
        'hkp://keyserver.ubuntu.com:80'  # 6
        'https://git-cola.github.io/downloads.html'  # 7
    )

    local -a d=(
        /tmp/  # 1
    )

    f+=(
        [config]=~/.gitconfig
        [config-ssh]=~/.ssh/config
        [tmp_success]="${d[1]}"check_success
        [all_title_gh]="${d[1]}"all_title
        [cola_new]=/usr/bin/cola
        [bearer]=~/.config/gh/hosts.yml
    )

    local -a m=(
        'git'  # 1
        'vim'  # 2
        'git-cola'  # 3
        'jq'  # 4
        'systemd'  # 5
        'dconf-editor'  # 6
        'gh'  # 7
        'python-is-python3'  # 8
        'gawk'  # 9
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") \
        && ! $(dpkg --list | awk "/ii  ${m[9]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[5]}" "${m[9]}"

    # We put ii  <pkg>[[:space:]] to get only what we need, git shows in more places (in version by the way)
    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") && \
        $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" "${m[3]}" "${m[4]}" &> "${f[null]}"

                sudo rm --force "${f[config]}"

                [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep "${m[1]}") ]] \
                    && sudo add-apt-repository --remove --yes ppa:git-core/ppa &> "${f[null]}"

                sudo sed --in-place --null-data 's|Host github.com\nHostname ssh.github.com\nPort 443||g' "${f[config-ssh]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        echo; read $'?\033[1;37mSIR, ARE U OVER VPN? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                [[ ! $(sudo apt-key list 2> /dev/null | grep 'Nate Smith') ]] \
                    && sudo apt-key adv --keyserver "${l[6]}" --recv-key C99B11DEB97541F0 &> "${f[null]}"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                [[ ! $(sudo apt-key list 2> /dev/null | grep 'Nate Smith') ]] \
                    && sudo apt-key adv --keyserver "${l[3]}" --recv-key C99B11DEB97541F0 &> "${f[null]}"

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE U BEYOND VPN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

        if [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]]; then

            [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep "${l[4]}") ]] \
                && sudo add-apt-repository --yes "${l[4]}" &> "${f[null]}" \
                && update

        fi

        install_packages "${m[1]}" "${m[2]}" "${m[3]}" "${m[6]}" "${m[7]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    latest=$(curl --silent "${l[7]}"| grep --max-count=1 'v[0-9]' | sed --expression 's|<[^>]*>||g' | sed 's|v||' | xargs)

    local=$(cola --version | awk '{print $3}')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read $'?\033[1;37mSIR, SHOULD I UPGRADE COLA VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                [[ ! $(dpkg --list | awk "/ii  ${m[8]}[[:space:]]/ {print }") ]] \
                    && show "\nFIRST THINGS FIRST. DO U PASS THROUGH PYTHON?" \
                    && python_stuffs

                pip install --quiet --no-warn-script-location --upgrade "${m[3]}"

                sudo ln --force --symbolic "$(which ${m[3]})" "${f[cola_new]}"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    # Any changes pushed to GitHub, BitBucket, GitLab or another Git host
    # server in a later lesson will include this information.
    # from: https://swcarpentry.github.io/git-novice/02-setup/
    [[ ! $(grep --no-messages @ "${f[config]}") ]] \
        && read $'?\033[1;37m\nENTER YOUR EMAIL, '"${name[random]}"$': \033[m' email \
        && read $'?\033[1;37mNAME '"${e[silent_monkey]}"$': \033[m' nome \
        && git config --global user.email "${email}" \
        && git config --global user.name "${nome}" \
        && git config --global core.editor "vim" \
        && git config --global http.sslVerify false \
        && git config --global core.quotepath off  # Recognizes UTF-8

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]] \
        && [[ $(dconf dump / | grep 'gtk-theme' | awk --field-separator='=' '{print $2}' | sed "s|'||g") =~ .*dark.* ]] \
            && git config --global cola.icontheme dark \
            && git config --global cola.theme flat-dark-green

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && [[ $(dconf dump / | grep 'gtk-theme' | awk --field-separator='=' '{print $2}' | sed "s|'||g") =~ .*Dark.* ]] \
            && git config --global cola.icontheme dark \
            && git config --global cola.theme flat-dark-green

    local=$(git --version | awk '{print $3}')

    latest=$(curl --silent "${l[2]}" | grep --after-context=1 '"version"' | tail -1 | xargs)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep git-core) ]] \
            && sudo add-apt-repository --yes ppa:git-core/ppa &> "${f[null]}"

        update && sudo apt install --assume-yes "${m[1]}" &> "${f[null]}"

        sudo add-apt-repository --remove --yes ppa:git-core/ppa &> "${f[null]}"

    fi

    check_ssh

    [[ ! $(grep --no-messages github "${f[config-ssh]}") ]] \
        && sudo tee --append "${f[config-ssh]}" > "${f[null]}" <<< 'Host github.com
    Hostname ssh.github.com
    Port 443'

    echo; read $'?\033[1;37mENTER YOUR USERNAME FROM GITHUB: \033[m' user

    # GITHUB STUFF
    for (( ; ; )); do

        echo; show "${c[RED]}${user:u}${c[WHITE]}, PLEASE CREATE A TOKEN IN https://github.com/settings/tokens\nPLEASE, ENABLE ${c[RED]}REPO/ADMIN:ORG/ADMIN:PUBLIC_KEY" 1

        echo; read $'?\033[1;37mPASTE HERE YOUR TOKEN: \033[m' token

        [[ ! -e ${f[bearer]} ]] \
            && sudo tee "${f[tmp_tk]}" > "${f[null]}" <<< "${token}" \
            && gh auth login --with-token < "${f[tmp_tk]}" &> "${f[tmp_success]}"

        # let --ignore-case as below, api github always changing sensitive case
        # best way to grep AND
        [[ \
            $(curl --silent --head --header "Authorization: token $(cat ${f[tmp_tk]})" "${l[1]}" | grep --extended-regexp --ignore-case '^x-oauth-scopes' | grep 'admin:org' | grep 'admin:public_key' | grep 'repo') &&
            ! -z "${f[tmp_success]}" \
        ]] \
            && break || show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" 1
        # if file is empty, is 200 OK

    done

    source "${f[os_release]}"

    # -z for empty not works, github api was changes, if empty: [ ] (3 line)
    if [[ $(curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" "${l[1]}" | wc --lines) -eq 3 ]]; then

        curl --silent --include --user "${user}":"$(cat ${f[tmp_tk]})" --data '{"title": "Sent from my '"${NAME//Linux/}"'", "key": "'"$(cat ${f[public_ssh]})"'"}' "${l[1]}" &> "${f[null]}"

    else

        install_packages "${m[4]}"

        # https://developer.github.com/changes/2020-02-14-deprecating-password-auth/
        curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" "${l[1]}" | jq --raw-output ".[] | .title"  &> "${f[all_title_gh]}"

        if [[ $(grep --no-messages "Sent from my ${NAME//Linux/}" "${f[all_title_gh]}") ]]; then

            echo; read $'?\033[1;37mSIR, SHOULD I REPLACE YOUR SSH ON GITHUB? THERE\'S AN INCONSISTENCY! \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    show "\nTHERE'S AN INCONSISTENCY IN YOUR LOCAL/REMOTE KEYS\nFIXING..." 1

                    old_ssh_id=$(curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" "${l[1]}" | jq --raw-output ".[] | .id, .title" | grep --before-context=1 "Sent from my ${NAME//Linux/}" | head -1)

                    curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" --request DELETE "${l[1]}"/"${old_ssh_id}"

                    curl --silent --include --user "${user}":"$(cat ${f[tmp_tk]})" --data '{"title": "Sent from my '"${NAME//Linux/}"'", "key": "'"$(cat ${f[public_ssh]})"'"}' "${l[1]}" &> "${f[null]}"

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I REPLACE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            curl --silent --include --user "${user}":"$(cat ${f[tmp_tk]})" --data '{"title": "Sent from my '"${NAME//Linux/}"'", "key": "'"$(cat ${f[public_ssh]})"'"}' "${l[1]}" &> "${f[null]}"

        fi

    fi

    [[ ! $(grep --no-messages 'alias sent' "${f[zshrc]}") ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
alias sent='\$(git remote add origin git@github.com:${user}/\${PWD##*/}.git)'"

    ssh -o BatchMode=yes -o StrictHostKeyChecking=no -T git@github.com &> "${f[ssh]}"

    # StrictHostKeyChecking=no
    [[ ! $(grep --no-messages successfully "${f[ssh]}") ]] \
        && ssh -o BatchMode=yes -T git@github.com &> "${f[null]}"

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
chrome_stuffs() {

    local -a d=(
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org/  # 1
        ~/.config/google-chrome/  # 2
    )

    local -a m=(
        'google-chrome-stable'  # 1
        'libappindicator1'  # 2
        'libindicator7'  # 3
        'libxss1'  # 4
        'gawk'  # 5
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[5]}"

    f+=(
        [file]=/tmp/google-chrome-stable_current_amd64.deb
        [garbage]=/etc/default/google-chrome
    )

    local -a l=(
        'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                # Only libappindicator1 doesn't come default in debian distros
                sudo apt remove --purge --yes "${m[1]}" "${m[2]}" &> "${f[null]}"

                sudo sed --in-place '/google-chrome/d' "${f[mimeapps]}"

                sudo sed --in-place '/google-chrome/d' "${d[1]}"*.json

                sudo rm --force --recursive "${d[2]}"

                sudo rm --force "${f[garbage]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # Dependencies
        install_packages "${m[2]}" "${m[3]}" "${m[4]}"

        show "\n${c[YELLOW]}${m[1]:u} ${c[WHITE]}${linen:${#m[1]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[1]}"

        sudo dpkg --install "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    echo; read $'?\033[1;37mSIR, SHOULD I OPEN CHROME? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            ( nohup "${m[1]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
flameshot_stuffs() {

    local -a d=(
        ~/.config/flameshot/  # 1
        /tmp/  # 2
        ~/.config/autostart/  # 3
    )

    f+=(
        [config]="${d[1]}"flameshot.ini
        [dskt]="${d[3]}"Flameshot.desktop
        [shortcut_gnome]=/org/gnome/shell/keybindings/
        [shortcut_cinnamon]=/org/cinnamon/desktop/keybindings/media-keys/
        [key_cinnamon]=/org/cinnamon/desktop/keybindings/custom-keybindings/printscreen/
        [wayland]=/etc/gdm3/custom.conf
    )

    local -a m=(
        'flameshot'  # 1
        'dconf-editor'  # 2
        'gawk'  # 3
    )

    [[ ! -d "${d[3]}" || $(stat --format="%U" "${d[3]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[3]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[3]}"

    [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[3]}"

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[1]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[1]}" "${m[2]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]]; then

        [[ $(grep --no-messages '#WaylandEnable' "${f[wayland]}") ]] \
            && sudo sed --in-place 's|#WaylandEnable=false|WaylandEnable=false|g' "${f[wayland]}"

        # sudo systemctl restart gdm3
        echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                sudo reboot

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    source "${f[user_dirs]}"

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]] \
        && dconf write "${f[shortcut_gnome]}show-screenshot-ui" "['']" \
        && dconf write "${f[shortcut_gnome]}screenshot" "['']" \
        && dconf write "${f[shortcut_gnome]}screenshot-window" "['']" \
        && dconf write "${f[custom_gnome]}" "['${f[custom_gnome]}custom0', '${f[custom_gnome]}custom1', '${f[custom_gnome]}custom2']" \
        && dconf write "${f[custom_gnome]}custom1/binding" "'Print'" \
        && dconf write "${f[custom_gnome]}custom1/command" "'flameshot gui'" \
        && dconf write "${f[custom_gnome]}custom1/name" "'Take a PrintScreen'"

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && dconf write "${f[shortcut_cinnamon]}screenshot" "['']" \
        && dconf write "${f[shortcut_cinnamon]}area-screenshot" "['']" \
        && dconf write "${f[custom_cinnamon]}" "['printscreen', 'clipboard']" \
        && dconf write "${f[key_cinnamon]}command" "'flameshot gui'" \
        && dconf write "${f[key_cinnamon]}binding" "['Print', '<Shift>Print']" \
        && dconf write "${f[key_cinnamon]}name" "'Take a PrintScreen'"

    for (( ; ; )); do

        [[ -e "${f[config]}" ]] \
            && break \
            || ( nohup "${m[1]}" config & ) &> "${f[null]}" \
            && sleep 5s

    done

    # If these instructions below stay in for, don't works
    sudo pkill "${m[1]}" && take_a_break

    [[ ! $(grep --no-messages 'savePathFixed' "${f[config]}") ]] \
        && source "${f[user_dirs]}" \
        && sudo tee "${f[config]}" > "${f[null]}" <<< "[General]
buttons=@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\x4\0\0\0\x3\0\0\0\n\0\0\0\v\0\0\0\f)
checkForUpdates=true
disabledTrayIcon=true
drawColor=#FF0000
drawThickness=3
savePath=${XDG_PICTURES_DIR}
savePathFixed=true"

    [[ ! $(grep --no-messages flameshot "${f[dskt]}") && "${XDG_CURRENT_DESKTOP:u}" ]] \
        && sudo tee "${f[dskt]}" > "${f[null]}" <<< '[Desktop Entry]
Name=flameshot
Icon=flameshot
Exec=flameshot
Terminal=false
Type=Application
X-GNOME-Autostart-enablelocal -a d=true'

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
heroku_stuffs() {

    local -a d=(
        /usr/lib/heroku/  # 1
        ~/.cache/heroku/  # 2
    )

    f+=(
        [auth]=~/.netrc
        [ppa]=/etc/apt/sources.list.d/heroku.list
    )

    local -a l=(
        'https://cli-assets.heroku.com/install-ubuntu.sh'  # 1
    )

    local -a m=(
        'heroku'  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" &> "${f[null]}"

                sudo rm --force "${f[auth]}" "${f[ppa]}"

                sudo rm --force --recursive "${d[1]}" "${d[2]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        show "\n${c[YELLOW]}${m[1]:u} ${c[WHITE]}${linen:${#m[1]}} [INSTALLING]"

        zsh -c "$(curl --silent ${l[1]})" &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    echo; read $'?\033[1;37mWANT YOU AUTHENTICATE '"${name[random]}"$'? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            echo && heroku login -i

            # https://devcenter.heroku.com/articles/heroku-cli#login-issues
            while [[ ! -e "${f[auth]}" ]]; do

                show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!\n" 1

                heroku login -i

            done

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. WANT YOU AUTHENTICATE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
hide_devices() {

    local -a d=(
        /etc/udev/rules.d/  # 1
        /boot/grub/themes/  # 2
    )

    f+=(
        [config]="${d[1]}"99-hide-disks.rules
        [grub2_theme]=/tmp/grub2-theme-mint_1.2.2_all.deb
        [grub-modified]=/etc/default/grub
        [grub]=/boot/grub/grub.cfg
        [audio]=/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common
        [keyboard]=/etc/modprobe.d/hid_apple.conf
        [temporary]=/sys/module/hid_apple/parameters/fnmode
    )

    local -a l=(
        'https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/g/grub2-theme-mint/grub2-theme-mint_1.2.2_all.deb'  # 1
        'https://vignette4.wikia.nocookie.net/despicableme/images/6/6b/Gru_sunglasses.jpg/revision/latest?cb=20140218054928'  # 2
    )

    local -a m=(
        'devices'  # 1
        'grub2-theme-mint-2k'  # 2
        'grub2-theme-mint'  # 3
        'imagemagick'  # 4
    )

    check_devices=$(sudo fdisk --list 2>&- | grep 'Microsoft basic data' | awk '{print $1}')

    if [[ -z "${check_devices}" ]]; then

        show "\n  THERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!"

        return_menu

    else

        # --no-messages hide if file don't exists
        if [[ $(grep --no-messages ID_FS_UUID "${f[config]}") ]]; then

            show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${lineh:${#m[1]}} [HIDED]\n" 1

            read $'?\033[1;37mSIR, SHOULD I SHOW THEM? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    show "\n${c[RED]}S${c[WHITE]}HOWING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                    sudo rm --force "${f[config]}"

                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    return_menu && break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I SHOW THEM AGAIN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            show "${c[GREEN]}\n\tH${c[WHITE]}IDING ${c[GREEN]}WINDOWS ${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" 1

            show "${c[GREEN]}H${c[WHITE]}IDING ${c[GREEN]}DEVICE${c[WHITE]}"

            declare -a devices=()

            # for name in ${check_devices} not works on zsh so fine like in bash
            while IFS= read -r device ; do

                devices+=("${device}")

            done <<< "${check_devices}"

            [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != ${USER} ]] \
                && mkdir --parents "${d[1]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

            for (( iterator=1; iterator<=${#devices}; iterator++ )); do

                tee --append "${f[config]}" > "${f[null]}" <<< 'ENV{ID_FS_UUID}=="'"$(blkid --match-tag UUID --output value ${devices[${iterator}]})"'",ENV{UDISKS_IGNORE}="1"'

            done

            unset iterator

            echo; read $'?\033[1;37mSIR, DO U WANT TO INSTALL A THEME FOR GRUB? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
                        && show "\nBEFORE PROCEED, WE MUST INSTALL SOME REQUIREMENTS..." \
                        && install_packages "${m[4]}"

                    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
                        && install_packages "${m[2]}"

                    if [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]]; then

                        if [[ $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]]; then

                            show "\n${c[GREEN]}${m[3]:u} ${c[WHITE]}${linei:${#m[3]}} [INSTALLED]"

                        else

                            show "\n${c[YELLOW]}${m[3]:u} ${c[WHITE]}${linen:${#m[3]}} [INSTALLING]"

                            [[ ! -e "${f[grub2_theme]}" ]] \
                                && wget --quiet "${l[1]}" --output-document "${f[grub2_theme]}" \
                                && sudo dpkg --install "${f[grub2_theme]}" &> "${f[null]}" \
                                && sudo rm --force "${f[grub2_theme]}"

                        fi

                    fi

                    d+=(
                        "${d[2]}"$(find "${d[2]}" -maxdepth 1 -type d | tail -1 | awk --field-separator=/ '{print $5}')/  # 3
                    )

                    f+=(
                        [bkg_grub_jpg]="${d[3]}"background.jpg
                        [bkg_grub_png]="${d[3]}"background.png
                        [old_bkg_grub]="${d[3]}"background_old.png
                    )

                    [[ ! -d "${d[3]}" || $(stat --format="%U" "${d[3]}" 2>&-) != "${USER}" ]] \
                        && sudo mkdir --parents "${d[3]}" > "${f[null]}" \
                        && sudo chown --recursive "${USER}":"${USER}" "${d[3]}"

                    if [[ ! -e "${f[old_bkg_grub]}" ]]; then

                        mv "${f[bkg_grub_png]}" "${f[old_bkg_grub]}"

                        [[ ! -e "${f[bkg_grub_jpg]}" ]] \
                            && wget --quiet "${l[2]}" --output-document "${f[bkg_grub_jpg]}" \
                            && convert "${f[bkg_grub_jpg]}" "${f[bkg_grub_png]}" \
                            && rm --force "${f[bkg_grub_jpg]}"

                    fi

                    [[ ! $(grep --no-messages '1920x1080' "${f[grub-modified]}") ]] \
                        && sudo sed --in-place 's|#GRUB_GFXMODE=640x480|GRUB_GFXMODE=1920x1080|g' "${f[grub-modified]}"

                    [[ ! $(grep --no-messages 'ipv6.disable=1' "${f[grub-modified]}") ]] \
                        && sudo sed --in-place 's|GRUB_CMDLINE_LINUX=""|GRUB_CMDLINE_LINUX="ipv6.disable=1"|g' "${f[grub-modified]}"

                    sudo update-grub 2>&- &> "${f[null]}"

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            echo; read $'?\033[1;37mSIR, ARE YOU HAVING ISSUES WITH USB AUDIO? (EDIFIER SPEAKER PERHAPS) \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    # https://chrisjean.com/fix-for-usb-audio-is-too-loud-and-mutes-at-low-volume-in-ubuntu/
                    [[ ! $(grep --no-messages '^volume-limit' "${f[audio]}") ]] \
                        && sudo sed --in-place 's|^volume = merge|volume = ignore\nvolume-limit = 0.01|g' "${f[audio]}" \
                        && pulseaudio --kill

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE YOU HAVING ISSUES WITH SOUND SPEAKERS?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            # https://wiki.archlinux.org/title/Apple_Keyboard
            echo; read $'?\033[1;37mSIR, ARE YOU HAVING ISSUES WITH KEYBOARD? (APPLE FN) \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    [[ ! -e "${f[temporary]}" ]] \
                        && sudo tee "${f[temporary]}" > "${f[null]}" <<< '0' \
                        && sudo update-initramfs -u 2>&- > "${f[null]}"

                    [[ ! $(grep --no-messages '2' "${f[keyboard]}") ]] \
                        && sudo tee "${f[keyboard]}" > "${f[null]}" <<< 'options hid_apple fnmode=2' \
                        && sudo update-initramfs -u 2>&- > "${f[null]}"

                    echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                    for (( ; ; )); do

                        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                            sudo reboot

                        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                            break

                        else

                            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                            read option

                        fi

                    done

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE YOU HAVING ISSUES WITH APPLE KEYBOARD?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    sudo udevadm control --reload-rules && sudo udevadm trigger

    [[ $(grep --no-messages 'Boot Manager' "${f[grub]}") ]] \
        && sudo sed --in-place 's|Boot Manager|11|g' "${f[grub]}"

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
minidlna_stuffs() {

    local -a m=(
        'minidlna'  # 1
        'gawk'  # 2
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, WE MUST INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

    source "${f[os_release]}" "${f[user_dirs]}"

    which_os="${PRETTY_NAME//Linux /}"

    local -a d=(
        "${XDG_VIDEOS_DIR}"  # 1
        /home/"${USER}"/.config/minidlna  # 2
        /var/lib/minidlna  # 3
    )

    f+=(
        [config]=/etc/minidlna.conf
        [dft]=/etc/default/minidlna
        [service]=/lib/systemd/system/minidlna.service
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" &> "${f[null]}"

                sudo rm --force "${f[config]}" "${f[default_minidlna]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! $(grep --no-messages "${d[2]}" "${f[config]}") ]]; then

        # automatic discover new files
        sudo sed --in-place 's|#inotify=.*|inotify=yes|g' "${f[config]}"

        # server_name
        sudo sed --in-place "s|#friendly.*|friendly_name=${which_os}|g" "${f[config]}"

        # location database
        sudo sed --in-place "s|#db_dir=.*|db_dir=${d[2]}|g" "${f[config]}"

        # location logs
        sudo sed --in-place "s|#log_dir=.*|log_dir=${d[2]}|g" "${f[config]}"

        # media dirs
        sudo sed --in-place --null-data "s|${d[3]}|V,${d[1]}|5" "${f[config]}"

        # user to access this database
        sudo sed --in-place "s|#USER=.*|USER=\"${USER}\"|g" "${f[dft]}"

        sudo sed --in-place "s|#GROUP=.*|GROUP=\"${USER}\"|g" "${f[dft]}"

        sudo sed --in-place "s|User.*|User=${USER}|g" "${f[service]}"

        sudo sed --in-place "s|Group.*|Group=${USER}|g" "${f[service]}"

        # after double lasts commands, daemon-reload is necessary
        systemctl daemon-reload

        # sudo minidlnad -R when service is stopped
        [[ $(systemctl is-active minidlna.service) = 'active' ]] \
            && sudo service minidlna restart \
            && sudo service minidlna force-reload \
            || sudo service minidlna start

    fi

    echo; read $'?\033[1;37mSIR, AREN\'T YOUR FILES BEING REFRESHED ON MINIDLNA DATABASE? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            sudo minidlnad -r && sudo service minidlna restart

            sudo service minidlna force-reload

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE YOU LOOKING AT TV YOUR NEW MISSING FILES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
nvidia_stuffs() {

    # The nouveau driver comes by default once linux is installed, but not
    # extract all resources as nvidia driver (only father knows the kid)
    f+=(
        [config]=/etc/modprobe.d/blacklist-nouveau.conf
    )

    local -a l=(
        'https://www.nvidia.com/Download/driverResults.aspx/157462/en-us'  # 1
    )

    local -a m=(
        'nvidia-driver'  # 1
        'nouveau-driver'  # 2
        'nvidia-settings'  # 3
        'dconf-editor'  # 4
        'gawk'  # 5
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[5]}"

    latest=$(curl --silent "${l[1]}" | grep -1 '"tdVersion"' | tail -1 | awk --field-separator=. '{print $1}' | xargs)

    # https://4fasters.com.br/2018/04/26/benchmark-nvidia-driver-do-fabricante-vs-driver-open-source-no-linux/
    # -class: Show reduced data
    check_nvidia_existence=$(sudo lshw -class display | egrep "fabricante|vendor" | awk '{print $2}')

    if [[ "${check_nvidia_existence}" != 'NVIDIA' ]]; then

        show "\n\tTHERE'S NO NVIDIA CARD IN YOUR MACHINE!"

        return_menu

    else

        # Identify actual driver.
        check_driver=$(lsmod | grep drm_kms_helper | head -1 | awk '{print $4}')

        if [[ "${check_driver%%_drm}" = "nvidia" ]]; then

            show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

            read $'?\033[1;37mSIR, SHOULD I RESTORE NOUVEAU DRIVER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    show "\n${c[RED]}R${c[WHITE]}ESTORING ${c[RED]}${m[2]:u}${c[WHITE]}!\n"

                    [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep graphics) ]] \
                        && sudo add-apt-repository --remove --yes ppa:graphics-drivers/ppa &> "${f[null]}"

                    sudo apt remove --purge --yes "${m[3]}" "${m[1]}-"* &> "${f[null]}"

                    sudo rm --force "${f[config]}"

                    sudo update-initramfs -u > "${f[null]}"

                    echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                    for (( ; ; )); do

                        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                            sudo reboot

                        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                            break

                        else

                            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                            read option

                        fi

                    done

                    remove_useless

                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    return_menu && break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTORE DEFAULT DRIVER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

            [[ ! $(apt search nvidia-driver-"${latest}") ]] \
                && sudo add-apt-repository --yes ppa:graphics-drivers/ppa &> "${f[null]}" \
                && update

            install_packages "${m[1]}-${latest}" "${m[3]}"

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! $(grep --no-messages nouveau "${f[config]}") ]]; then

        sudo tee "${f[config]}" > "${f[null]}" <<< 'blacklist nouveau
blacklist lbm-nouveau
alias nouveau off
alias lbm-nouveau off'

        sudo update-initramfs -u > "${f[null]}"

        echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                reboot

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    local=$(apt version "${m[1]}-"* 2>&-)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep graphics) ]] \
            && sudo add-apt-repository --yes ppa:graphics-drivers/ppa &> "${f[null]}"

        update && install_packages "${m[1]}-${latest}"

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
postgres_stuffs() {

    local -a d=(
        /etc/postgresql/  # 1
        /var/log/postgresql/  # 2
    )

    f+=(
        [ppa]=/etc/apt/sources.list.d/pgdg.list
        [ppa-pgadm]=/etc/apt/sources.list.d/pgadmin4.list
        [pspg_postgres]=/var/lib/postgresql/.psqlrc
        [pspg_user]=~/.psqlrc
    )

    local -a l=(
        'https://www.postgresql.org/media/keys/ACCC4CF8.asc'  # 1
        'https://www.postgresql.org/download/windows/'  # 2
        'https://www.pgadmin.org/static/packages_pgadmin_org.pub'  # 3
        'https://www.linuxmint.com/download_all.php'  # 4
    )

    local -a m=(
        'postgresql'  # 1
        'postgresql-client'  # 2
        'postgresql-contrib'  # 3
        'libpq-dev'  # 4
        'pgadmin4'  # 5
        'pspg'  # 6
        'gawk'  # 7
        'systemd'  # 8
        'lsb-release'  # 9
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[7]}[[:space:]]/ {print }") \
        && ! $(dpkg --list | awk "/ii  ${m[8]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[7]}" "${m[8]}" "${m[9]}"

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" &> "${f[null]}"

                sudo rm --force "${f[ppa]}"

                sudo rm --force --recursive "${d[1]}" "${d[2]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # lsb_release get os version name
        [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
            && check_codename=$(curl --silent "${l[4]}" | grep --ignore-case -2 $(lsb_release --codename --short) | tail -1 | awk '{print $3}' | sed 's|</td>||' | tr '[:upper:]' '[:lower:]')

        [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]] \
            && check_codename=$(lsb_release --codename --short)

        # 2> hides warning
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep PostgreSQL) ]] \
            && sudo wget --quiet --output-document - "${l[1]}" | sudo apt-key add - &> "${f[null]}"

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep pgadmin) ]] \
            && sudo wget --quiet --output-document - "${l[3]}" | sudo apt-key add - &> "${f[null]}"

        # If returns warning about architeture, please write deb [ arch=amd64 ]
        [[ ! $(grep --no-messages "${check_codename}" "${f[ppa]}") ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb [ arch=amd64 ] http://apt.postgresql.org/pub/repos/apt ${check_codename}-pgdg main"

        [[ ! $(grep --no-messages "${check_codename}" "${f[ppa-pgadm]}") ]] \
            && sudo tee "${f[ppa-pgadm]}" > "${f[null]}" <<< "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/${check_codename} pgadmin4 main"

        update

        install_packages "${m[1]}" "${m[2]}" "${m[3]}" "${m[5]}" "${m[6]}"  # "${m[4]}"

        sudo rm --force "${f[ppa-pgadm]}"

        echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

        # Or pg_createcluster $(apt version postgresql | cut -c1-2) main --start
        # /etc/init.d/postgresql start
        d+=(
            /etc/postgresql/"$(apt version "${m[1]}" | cut --characters=1-2)"/main/conf.d/  # 3
        )

        if [[ ! -d "${d[3]}" ]]; then

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    sudo reboot

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    return_menu && break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    f+=(
        [pspg]=$(which pspg)  # /usr/bin/pspg
    )

    [[ ! -e "${f[pspg_postgres]}" && ! -e "${f[pspg_user]}" ]] \
        && sudo tee "${f[pspg_postgres]}" "${f[pspg_user]}" > "${f[null]}" <<< "\pset linestyle unicode
\pset border 2
\setenv PAGER '${f[pspg]} --blackwhite --reprint-on-exit --no-mouse'" \
        && sudo chown postgres:postgres "${f[pspg_postgres]}" \
        && sudo chown "${user}":"${user}" "${f[pspg_user]}"

    latest=$(curl --silent "${l[2]}" | grep scope | head -1 | tr --complement --delete 0-9,. | xargs)

    # Match perhaps with -10 or -11 etc (fixed installation)
    local=$(apt version "${m[1]}" 2>&-)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read $'?\033[1;37mSIR, SHOULD I UPGRADE POSTGRES VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                sudo apt install --assume-yes --only-upgrade "${m[1]}"* &> "${f[null]}"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    f+=(
        [cfg]="${d[1]}""${local:0:2}"/main/postgresql.conf
        [hba]="${d[1]}""${local:0:2}"/main/pg_hba.conf
    )

    sudo sed --in-place "s|#listen_addresses|listen_addresses|g" "${f[cfg]}"

    read $'?\033[1;37m\nDO U WANT A USER TO ACCESS THE CONSOLE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            # sudo -u postgres psql
            echo; read $'?\033[1;37mENTER THE USER ('"${USER}"$'): \033[m' user

            # if empty string
            [[ -z "${user}" ]] && user="${USER}"

            [[ $(sudo --user=postgres psql --command "SELECT 1 FROM pg_roles WHERE rolname='${user}'" | egrep "registro|row" | awk '{print $1}' | sed 's|(||') -ge 1 ]] \
                && show "\nUSER ${c[RED]}${user:u}${c[WHITE]} ALREADY EXISTS. EXITING..." \
                && break

            password=$("${f[askpass]}" $'\033[1;37mPASSWORD OF USER '"${user:u}"$':\033[m')

            sudo --user=postgres psql --command "CREATE USER ${user} WITH ENCRYPTED PASSWORD '${password}'" &> "${f[null]}"

            sudo --user=postgres psql --command "ALTER ROLE ${user} SET client_encoding TO 'utf8'" &> "${f[null]}"

            sudo --user=postgres psql --command "ALTER ROLE ${user} SET default_transaction_isolation TO 'read committed'" &> "${f[null]}"

            sudo --user=postgres psql --command "ALTER ROLE ${user} SET timezone TO 'America/Sao_Paulo'" &> "${f[null]}"

            read $'?\033[1;37m\nDO U WANT A DATABASE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    # \c <database>
                    read $'?\033[1;37m\nENTER THE DATABASE NAME: \033[m' database

                    [[ $(sudo --user=postgres psql --command "SELECT 1 FROM pg_database WHERE datname='${database}'" | egrep "registro|row" | awk '{print $1}' | sed 's|(||') -ge 1 ]] \
                        && show "\nDATABASE ${c[RED]}${database:u}${c[WHITE]} ALREADY EXISTS. EXITING..." \
                        && break

                    sudo --user=postgres psql --command "CREATE DATABASE ${database}" &> "${f[null]}"

                    sudo --user=postgres psql --command "GRANT ALL PRIVILEGES ON DATABASE ${database} TO ${user}" &> "${f[null]}"

                    sudo --user=postgres psql --dbname="${database}" --command "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO ${user}" &> "${f[null]}"

                    [[ "${database}" = 'rarbg' ]] \
                        && sudo --user=postgres psql --dbname="${database}" --command "CREATE TABLE IF NOT EXISTS torrent (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150),
    url VARCHAR(50),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);" &> "${f[null]}"

                    [[ "${database}" = 'cursoemvideo' ]] \
                        && sudo --user=postgres psql --dbname="${database}" --command "CREATE TYPE definicao AS ENUM ('M', 'F');
CREATE TABLE IF NOT EXISTS gafanhotos (
    id smallserial PRIMARY KEY,
    nome varchar(30) NOT NULL,
    profissao varchar(20),
    nascimento date,
    sexo definicao DEFAULT 'M',
    peso decimal(5, 2),
    altura decimal(3, 2),
    nacionalidade varchar(20) DEFAULT 'Brasil'
);" &> "${f[null]}" \
                        && sudo --user=postgres psql --dbname="${database}" --command "CREATE TABLE IF NOT EXISTS cursos (
    id smallserial PRIMARY KEY,
    nome character varying(30) NOT NULL UNIQUE,
    descricao text,
    carga int4 CHECK (carga >= 0),
    totaulas int4,
    ano character varying(4) DEFAULT '2018'
);" &> "${f[null]}" \
                        && sudo --user=postgres psql --dbname="${database}" --command "INSERT INTO gafanhotos
VALUES
(1,'Daniel Morais','Auxiliar Administrat','1984-01-02','M',78.50,1.83,'Brasil'),
(2,'Talita Nascimento','Farmacêutico','1999-12-30','F',55.20,1.65,'Portugal'),
(3,'Emerson Gabriel','Programador','1920-12-30','M',50.20,1.65,'Moçambique'),
(4,'Lucas Damasceno','Auxiliar Administrat','1930-11-02','M',63.20,1.75,'Irlanda'),
(5,'Leila Martins','Farmacêutico','1975-04-22','F',99.00,2.15,'Brasil'),
(6,'Letícia Neves','Programador','1999-12-03','F',87.00,2.00,'Brasil'),
(7,'Janaína Couto','Auxiliar Administrat','1987-11-12','F',75.40,1.66,'EUA'),
(8,'Carlisson Rosa','Professor','2010-08-01','M',78.22,1.98,'Brasil'),
(9,'Jackson Telles','Programador','1999-01-23','M',55.75,1.33,'Portugal'),
(10,'Danilo Araujo','Dentista','1975-12-10','M',99.21,1.87,'EUA'),
(11,'Andreia Delfino','Auxiliar Administrat','1975-07-01','F',48.64,1.54,'Irlanda'),
(12,'Valter Vilmerson','Ator','1985-10-12','M',88.55,2.03,'Brasil'),
(13,'Allan Silva','Programador','1993-11-11','M',76.99,1.55,'Brasil'),
(14,'Rosana Kunz','Professor','1935-01-16','F',55.24,1.87,'Brasil'),
(15,'Josiane Dutra','Empreendedor','1950-01-20','F',98.70,1.04,'Portugal'),
(16,'Elvis Schwarz','Dentista','2011-05-07','M',66.69,1.76,'EUA'),
(17,'Paulo Narley','Auxiliar Administrat','1997-03-17','M',120.10,2.22,'Brasil'),
(18,'Joade Assis','Médico','1930-12-01','M',65.88,1.78,'França'),
(19,'Nara Matos','Programador','1978-03-17','F',65.90,1.33,'Brasil'),
(20,'Marcos Dissotti','Empreendedor','2010-01-01','M',53.79,1.54,'Portugal'),
(21,'Ana Carolina Mendes','Ator','2000-12-15','F',88.30,1.54,'Brasil'),
(22,'Guilherme de Sousa','Dentista','2001-05-18','M',132.70,1.97,'Moçambique'),
(23,'Bruno Torres','Auxiliar Administrat','2000-01-30','M',44.65,1.65,'Brasil'),
(24,'Yuji Homa','Empreendedor','1996-12-25','M',33.90,1.22,'Japão'),
(25,'Raian Porto','Programador','1989-05-05','M',54.89,1.54,'Brasil'),
(26,'Paulo Batista','Ator','1999-03-15','M',110.12,1.87,'Portugal'),
(27,'Monique Precivalli','Auxiliar Administrat','2013-12-30','F',48.20,1.22,'Brasil'),
(28,'Herisson Silva','Auxiliar Administrat','1965-10-10','M',74.65,1.56,'EUA'),
(29,'Tiago Ulisses','Dentista','1993-04-22','M',150.30,2.35,'Brasil'),
(30,'Anderson Rafael','Programador','1989-12-01','M',64.22,1.44,'Irlanda'),
(31,'Karine Ribeiro','Empreendedor','1988-10-01','F',42.10,1.65,'Brasil'),
(32,'Roberto Luiz Debarba','Ator','2007-01-09','M',77.44,1.56,'Brasil'),
(33,'Jarismar Andrade','Dentista','2000-06-23','F',63.70,1.33,'Brasil'),
(34,'Janaina Oliveira','Professor','1955-03-12','F',52.90,1.76,'Canadá'),
(35,'Márcio Mello','Programador','2011-11-20','M',54.11,1.55,'EUA'),
(36,'Robson Rodolpho','Auxiliar Administrat','2000-08-08','M',110.10,1.76,'Brasil'),
(37,'Daniele Moledo','Empreendedor','2006-08-11','F',101.30,1.99,'Brasil'),
(38,'Neto Sophiate','Ator','1996-05-17','M',59.28,1.65,'Portugal'),
(39,'Neriton Dias','Auxiliar Administrat','2009-10-30','M',48.99,1.29,'Brasil'),
(40,'André Schmidt','Programador','1993-07-26','M',55.37,1.22,'Angola'),
(41,'Isaias Buscarino','Dentista','2001-01-07','M',99.90,1.55,'Moçambique'),
(42,'Rafael Guimma','Empreendedor','1968-04-11','M',88.88,1.54,'Brasil'),
(43,'Ana Carolina Hernandes','Ator','1970-10-11','F',65.40,2.08,'EUA'),
(44,'Luiz Paulo','Professor','1984-11-01','M',75.12,1.38,'Portugal'),
(45,'Bruna Teles','Programador','1980-11-07','F',55.10,1.86,'Brasil'),
(46,'Diogo Padilha','Auxiliar Administrat','2000-03-03','M',54.34,1.88,'Angola'),
(47,'Bruno Miltersteiner','Dentista','1986-02-19','M',77.45,1.65,'Alemanha'),
(48,'Elaine Nunes','Programador','1998-08-15','F',35.90,2.00,'Canadá'),
(49,'Silvio Ricardo','Programador','2012-03-12','M',65.99,1.23,'EUA'),
(50,'Denilson Barbosa da Silva','Empreendedor','2000-01-08','M',97.30,2.00,'Brasil'),
(51,'Jucinei Teixeira','Professor','1977-11-22','F',44.80,1.76,'Portugal'),
(52,'Bruna Santos','Auxiliar Administrat','1991-12-01','F',76.30,1.45,'Canadá'),
(53,'André Vitebo','Médico','1970-07-01','M',44.11,1.55,'Brasil'),
(54,'Andre Santini','Programador','1991-08-15','M',66.00,1.76,'Itália'),
(55,'Ruan Valente','Programador','1998-03-19','M',101.90,1.76,'Canadá'),
(56,'Nailton Mauricio','Médico','1992-04-25','M',86.01,1.43,'EUA'),
(57,'Rita Pontes','Professor','1999-09-02','F',54.10,1.35,'Angola'),
(58,'Carlos Camargo','Programador','2005-02-22','M',124.65,1.33,'Brasil'),
(59,'Philppe Oliveira','Auxiliar Administrat','2000-05-23','M',105.10,2.19,'Brasil'),
(60,'Dayana Dias','Professor','1993-05-30','F',88.30,1.66,'Angola'),
(61,'Silvana Albuquerque','Programador','1999-05-22','F',56.00,1.50,'Brasil');" &> "${f[null]}" \
                        && sudo --user=postgres psql --dbname="${database}" --command "INSERT INTO cursos
VALUES
(1,'HTML5','Curso de HTML5',40,37,2014),
(2,'Algoritmos','Lógica de Programação',20,15,2014),
(3,'Photoshop5','Dicas de Photoshop CC',10,8,2014),
(4,'PHP','Curso de PHP para iniciantes',40,20,2015),
(5,'Java','Introdução à Linguagem Java',40,29,2015),
(6,'MySQL','Bancos de Dados MySQL',30,15,2016),
(7,'Word','Curso completo de Word',40,30,2016),
(8,'Python','Curso de Python',40,18,2017),
(9,'POO','Curso de Programação Orientada a Objetos',60,35,2016),
(10,'Excel','Curso completo de Excel',40,30,2017),
(11,'Responsividade','Curso de Responsividade',30,15,2018),
(12,'C++','Curso de C++ com Orientação a Objetos',40,25,2017),
(13,'C#','Curso de C#',30,12,2017),
(14,'Android','Curso de Desenvolvimento de Aplicativos para Android',60,30,2018),
(15,'JavaScript','Curso de JavaScript',35,18,2017),
(16,'PowerPoint','Curso completo de PowerPoint',30,12,2018),
(17,'Swift','Curso de Desenvolvimento de Aplicativos para iOS',60,30,2019),
(18,'Hardware','Curso de Montagem e Manutenção de PCs',30,12,2017),
(19,'Redes','Curso de Redes para Iniciantes',40,15,2016),
(20,'Segurança','Curso de Segurança',15,8,2018),
(21,'SEO','Curso de Otimização de Sites',30,12,2017),
(22,'Premiere','Curso de Edição de Vídeos com Premiere',20,10,2017),
(23,'After Effects','Curso de Efeitos em Vídeos com After Effects',20,10,2018),
(24,'WordPress','Curso de Criação de Sites com WordPress',60,30,2019),
(25,'Joomla','Curso de Criação de Sites com Joomla',60,30,2019),
(26,'Magento','Curso de Criação de Lojas Virtuais com Magento',50,25,2019),
(27,'Modelagem de Dados','Curso de Modelagem de Dados',30,12,2020),
(28,'HTML4','Curso Básico de HTML, versão 4.0',20,9,2010),
(29,'PHP7','Curso de PHP, versão 7.0',40,20,2020),
(30,'PHP4','Curso de PHP, versão 4.0',30,11,2010);" &> "${f[null]}"

                    read $'?\033[1;37mWANT CREATE MORE DATABASES? \n[Y/N] R: \033[m' option

                    if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                        continue  # Simillar to pass

                    elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. WANT U CREATE MORE DATABASES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                        read option

                    fi

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    if [[ ! $(sudo grep --no-messages --extended-regexp '(postgres[[:space:]]+)md5' "${f[hba]}") ]]; then

        # Before change cryptography, we need add a password for postgres
        password=$("${f[askpass]}" $'\033[1;37m\nPASSWORD OF USER POSTGRES \033[31;1m(root)\033[1;37m:\033[m')

        sudo --user=postgres psql --command "ALTER USER postgres WITH ENCRYPTED PASSWORD '${password}'" &> "${f[null]}"

        sudo sed --in-place --regexp-extended 's|(postgres[[:space:]]+)peer|\1md5|g' "${f[hba]}"

    fi

    [[ $(systemctl is-active postgresql.service) = active ]] \
        && sudo service postgresql restart \
        || sudo service postgresql start

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
postman_stuffs() {

    source "${f[user_dirs]}"

    local -a d=(
        /opt/  # 1
        /opt/Postman/  # 2
        "${HOME}"/.postman/InterceptorBridge  # 3
        ~/.config/BraveSoftware/Brave-Browser/Default/Extensions/aicmkgpgakddgnaphhhpliifpcfhicfo/  # 4
        ~/.config/google-chrome/Default/Extensions/aicmkgpgakddgnaphhhpliifpcfhicfo/  # 5
    )

    local -a m=(
        'postman'  # 1
        'gawk'  # 2
        'brave-browser'  # 3
        'google-chrome-stable'  # 4
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

    f+=(
        [file]="${XDG_DOWNLOAD_DIR}"/Postman-linux-x64-latest.tar.gz
        [bin]=/usr/local/bin/postman
        [run]="${d[2]}"Postman
        [postman]=/usr/share/applications/postman.desktop
        [int_brave]=~/.config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.postman.postmanapp.json
        [int_chrome]=~/.config/google-chrome/NativeMessagingHosts/com.postman.postmanapp.json
        [inter]="${HOME}"/.postman/InterceptorBridge/InterceptorBridge
    )

    local -a l=(
        'https://dl.pstmn.io/download/latest/linux64'  # 1
        'https://chrome.google.com/webstore/detail/postman-interceptor/aicmkgpgakddgnaphhhpliifpcfhicfo?hl=en'  # 2
    )

    if [[ -f "${f[bin]}" ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                rm --force "${f[postman]}" "${f[bin]}"

                rm --force --recursive "${d[2]}"




                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        show "\n${c[YELLOW]}${m[1]:u} ${c[WHITE]}${linen:${#m[1]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[1]}"

        sudo tar --extract --gzip --file="${f[file]}" --directory="${d[1]}" > "${f[null]}"

        sudo ln --force --symbolic "${f[run]}" "${f[bin]}"

        read $'?\033[1;37m\nSIR, WANT TO INSTALL INTERCEPTOR BRIDGE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                echo; read $'?\033[1;37mSIR, DO YOU PREFER BRAVE BROWSER OVER CHROME BROWSER? \n[Y/N] R: \033[m' option

                for (( ; ; )); do

                    if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                        [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH BRAVE?" \
                            && brave_stuffs

                        choice='brave-browser'

                        break

                    elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                        [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
                            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH CHROME?" \
                            && chrome_stuffs

                        choice='google-chrome-stable'

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U PREFER BRAVE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                        read option

                    fi

                done

                ( nohup "${m[1]}" & ) &> "${f[null]}"

                while [[ ! -d "${d[3]}" ]]; do

                    show "\nPLEASE, ENTER CAPTURE REQUESTS ICON AT POSTMAN AND INSTALL INTERCEPTOR BRIDGE..."

                    sleep 10s

                done

                sudo pkill postman

                ( nohup "${choice}" & ) &> "${f[null]}"

                if [[ "${choice}" = 'brave-browser' ]]; then

                    while [[ ! -d "${d[4]}" ]]; do

                        show "\nPLEASE, INSTALL POSTMAN INTERCEPTOR EXTENSION IN ${choice:u}\n${l[2]}"

                        sleep 10s

                    done

                    sudo pkill brave

                    [[ ! $(grep --no-messages 'chrome-extension' "${f[int_brave]}") ]] \
                        && sudo tee "${f[int_brave]}" > "${f[null]}" <<< '{
  "name": "com.postman.postmanapp",
  "description": "Native Messaging Host for Postman Native App <> Interceptor Integration",
  "path": '"\"${f[inter]}\""',
  "type": "stdio",
  "allowed_origins": [
    "chrome-extension://aicmkgpgakddgnaphhhpliifpcfhicfo/"
  ]
}'

                else

                    while [[ ! -d "${d[5]}" ]]; do

                        show "\nPLEASE, INSTALL POSTMAN INTERCEPTOR EXTENSION IN ${choice:u}\n${l[2]}"

                        sleep 10s

                    done

                    sudo pkill chrome

                    [[ ! $(grep --no-messages 'chrome-extension' "${f[int_chrome]}") ]] \
                        && sudo tee "${f[int_chrome]}" > "${f[null]}" <<< '{
  "name": "com.postman.postmanapp",
  "description": "Native Messaging Host for Postman Native App <> Interceptor Integration",
  "path": '"\"${f[inter]}\""',
  "type": "stdio",
  "allowed_origins": [
    "chrome-extension://aicmkgpgakddgnaphhhpliifpcfhicfo/"
  ]
}'

                fi

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL INTERCEPTOR BRIDGE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ ! $(grep --no-messages Postman "${f[postman]}") ]] \
        && sudo tee "${f[postman]}" > "${f[null]}" <<< '[Desktop Entry]
Type=Application
Name=Postman
Icon=/opt/Postman/app/resources/app/assets/icon.png
Exec='"${f[run]}"'
Comment=Postman GUI
Categories=Development;Code;'

    echo; read $'?\033[1;37mSIR, SHOULD I OPEN POSTMAN? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            ( nohup "${m[1]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
python_stuffs() {

    local -a d=(
        ~/.pyenv/shims/  # 1
    )

    f+=(
        [python_new]=/usr/bin/python
    )

    local -a l=(
        'https://pypi.org/project/pip/'  # 1
        'https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer'  # 2
        'https://www.python.org/doc/versions/'  # 3
    )

    local -a m=(
        'python-is-python3'  # 1
        'python3-pip'  # 2
        'python-dev-is-python3'  # 3
        'build-essential'  # 4
        'pyenv'  # 5
        'curl'  # 6
        'wget'  # 7
        'zlib1g-dev'  # 8
        'libreadline-dev'  # 9
        'libsqlite3-dev'  # 10
        'llvm'  # 11
        'libncurses5-dev'  # 12
        'libbz2-dev'  # 13
        'libssl-dev'  # 14
        'libffi-dev'  # 15
        'gawk'  # 16
        'dependencies'  # 17
        'git'  # 18
        'liblzma-dev'  # 19
        'tk-dev'  # 20
        'python3-venv'  # 21
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[16]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[16]}"

    # https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body
    local -a d=(
        ~/.pyenv  # 1
        ~/.pyenv/versions/$(curl --silent "${l[3]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')  # 2
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]" 1

        read $'?\033[1;37m\nSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]} AND ${c[RED]}${m[17]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[1]}"

                sudo sed --in-place '/pyenv/Id' "${f[zshrc]}"

                source "${f[zshrc]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" "${m[21]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # pip versions
    local=$(apt version "${m[2]}" 2>&-)

    latest=$(curl --silent "${l[1]}" | grep --after-context=2 '_le' | tail -1 | awk '{print $2}')

    ( $(dpkg --compare-versions "${local}" lt "${latest}") ) \
        && python3 -m pip install --quiet --no-warn-script-location --upgrade pip

    # python versions
    # apt version python don't works, because it shows only packages added by
    # apt and pyenv download/install packages from curl
    local=$(python -c 'from platform import python_version as v; print(v())')

    latest=$(curl --silent "${l[3]}" | grep --no-messages external | head -4 | tail -1 | awk --field-separator=/ '{print $5}')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read $'?\033[1;37mSIR, SHOULD I UPGRADE VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[5]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

                # Dependencies
                install_packages "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" "${m[18]}" "${m[19]}" "${m[20]}"

                [[ -d "${d[1]}" ]] \
                    && show "\n${c[GREEN]}${m[5]:u} ${c[WHITE]}${linei:${#m[5]}} [INSTALLED]" \
                    || show "\n${c[YELLOW]}${m[5]:u} ${c[WHITE]}${linen:${#m[5]}} [INSTALLING]" \
                    && zsh -c "$(curl --silent --location ${l[2]})" &> "${f[null]}"

                echo; show "INITIALIZING CONFIGS..."

                [[ ! $(grep --no-messages rehash "${f[zshrc]}") ]] \
                    && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< '
# PYENV (py upgrade) configs
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"' \
                    && source "${f[zshrc]}"

                # pyenv versions
                # pyenv install --list | grep " 3\.[678]"
                [[ ! -d "${d[2]}" ]] && pyenv install "${latest}" &> "${f[null]}"

                # check with pyenv versions
                pyenv global "${latest}" > "${f[null]}"

                sudo rm --force "${f[python_new]}"

                # try python -m venv .venv after alfred pass here
                sudo ln --force --symbolic "${d[1]}$(echo ${latest} | awk --field-separator='.' '{print $1 "." $2}')" "${f[python_new]}"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
upgrade() {

    # Get last upgrades
    # last=$(grep --no-messages Start-Date "${f[apt_history]}" | tail -1 | awk '{print $2}')

    # Best data format, dd/mm/yyyy
    # date=$(date -d "${last}" +"%d/%m/%Y")

    sudo apt upgrade --yes &> "${f[null]}"

}
#======================#

#======================#
reduceye_stuffs() {

    local -a d=(
        ~/.config/redshift/  # 1
        ~/.config/autostart/  # 2
    )

    f+=(
        [config]="${d[1]}"redshift.conf
        [dskt]="${d[2]}"redshift-gtk.desktop
    )

    local -a m=(
        'redshift'  # 1
        'redshift-gtk'  # 2
    )

    [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[1]}"

                sudo rm --force "${f[dskt]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[1]}" "${m[2]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[config]}" ]]; then

        [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

        tee "${f[config]}" > "${f[null]}" <<< "; Global settings for redshift
[redshift]
; Set the day and night screen temperatures
temp-day=5700
temp-night=3500

; Disable the smooth fade between temperatures when Redshift starts and stops.
; 0 will cause an immediate change between screen temperatures.
; 1 will gradually apply the new screen temperature over a couple of seconds.
fade=1

; Solar elevation thresholds.
; By default, Redshift will use the current elevation of the sun to determine
; whether it is daytime, night or in transition (dawn/dusk). When the sun is
; above the degrees specified with elevation-high it is considered daytime and
; below elevation-low it is considered night.
;elevation-high=3
;elevation-low=-6

; Custom dawn/dusk intervals.
; Instead of using the solar elevation, the time intervals of dawn and dusk
; can be specified manually. The times must be specified as HH:MM in 24-hour
; format.
;dawn-time=6:00-7:45
;dusk-time=18:35-20:15

; Set the screen brightness. Default is 1.0.
;brightness=0.9
; It is also possible to use different settings for day and night
; since version 1.8.
;brightness-day=0.7
;brightness-night=0.4
; Set the screen gamma (for all colors, or each color channel
; individually)
gamma=0.8
;gamma=0.8:0.7:0.8
; This can also be set individually for day and night since
; version 1.10.
;gamma-day=0.8:0.7:0.8
;gamma-night=0.6

; Set the location-provider: 'geoclue2', 'manual'
; type 'redshift -l list' to see possible values.
; The location provider settings are in a different section.
location-provider=manual

; Set the adjustment-method: 'randr', 'vidmode'
; type 'redshift -m list' to see all possible values.
; 'randr' is the preferred method, 'vidmode' is an older API.
; but works in some cases when 'randr' does not.
; The adjustment method settings are in a different section.
adjustment-method=randr

; Configuration of the location-provider:
; type 'redshift -l PROVIDER:help' to see the settings.
; ex: 'redshift -l manual:help'
; Keep in mind that longitudes west of Greenwich (e.g. the Americas)
; are negative numbers.
[manual]
lat=-23.550520
lon=-46.633308

; Configuration of the adjustment-method
; type 'redshift -m METHOD:help' to see the settings.
; ex: 'redshift -m randr:help'
; In this example, randr is configured to adjust only screen 0.
; Note that the numbering starts from 0, so this is actually the first screen.
; If this option is not specified, Redshift will try to adjust _all_ screens.
[randr]
screen=0"

    fi

    [[ ! $(grep --no-messages Redshift "${f[dskt]}") ]] \
        && sudo tee "${f[dskt]}" > "${f[null]}" <<< '[Desktop Entry]
Version=1.0
Name=Redshift
Name[pt_BR]=Redshift
GenericName=Color temperature adjustment
GenericName[es]=Ajuste de la temperatura de color
Comment=Color temperature adjustment tool
Exec=redshift-gtk
Icon=redshift
Terminal=false
Type=Application
Categories=Utility;
StartupNotify=true
Hidden=false
X-GNOME-Autostart-enabled=true'

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
ruby_stuffs() {

    f+=(
        [ppa]=/etc/apt/sources.list.d/yarn.list
    )

    local -a l=(
        'https://www.ruby-lang.org/en/downloads/'  # 1
        'https://github.com/rbenv/rbenv.git'  # 2
        'https://github.com/rbenv/ruby-build.git'  # 3
        'https://dl.yarnpkg.com/debian/pubkey.gpg'  # 4
    )

     local -a m=(
        'ruby'  # 1
        'yarn'  # 2
        'gawk'  # 3
        'rbenv'  # 4
        'ruby-build'  # 5
        'git'  # 6
        'zlib1g-dev'  # 7
        'build-essential'  # 8
        'libssl-dev'  # 9
        'libreadline-dev'  # 10
        'libyaml-dev'  # 11
        'libsqlite3-dev'  # 12
        'sqlite3'  # 13
        'libxml2-dev'  # 14
        'libxslt1-dev'  # 15
        'libcurl4-openssl-dev'  # 16
        'software-properties-common'  # 17
        'libffi-dev'  # 18
        'ruby-dev'  # 19
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[3]}"

    # https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body
    local -a d=(
        ~/.rbenv  # 1
        ~/.rbenv/versions/$(curl --silent "${l[1]}" | grep --no-messages stable | awk '{print $6}' | sed 's|.||6')  # 2
        ~/.rbenv/plugins/ruby-build  # 3
    )

   if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[19]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[VERMELHO]}U${c[WHITE]}NINSTALLING ${c[VERMELHO]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" "${m[2]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[1]}"

                sudo sed --in-place '/rbenv/d' "${f[zshrc]}"

                sudo sed --in-place 's|# Ruby configs||g' "${f[zshrc]}"

                source "${f[zshrc]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[VERMELHO]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESET?${c[FIM]}\n${c[WHITE]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep Yarn) ]] \
            && sudo wget --quiet --output-document - "${l[4]}" | sudo apt-key add - &> "${f[null]}"

        # [[ ! $(grep --no-messages yarnpkg "${f[ppa]}") ]] \
        #     && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb https://dl.yarnpkg.com/debian/ stable main" \
        #     && update

        install_packages "${m[1]}" "${m[2]}" "${m[19]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # ruby versions
    local=$(ruby -e 'puts "#{RUBY_VERSION}"')

    latest=$(curl --silent "${l[1]}" | grep --no-messages stable | awk '{print $6}' | sed 's|.||6')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read $'?\033[1;37mSIR, SHOULD I UPGRADE VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[4]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

                # Dependencies
                install_packages "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}""${m[13]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}" "${m[18]}"

                # rbenv
                [[ -d "${d[1]}" ]] \
                    && show "\n${c[GREEN]}${m[4]:u} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]" \
                    || show "\n${c[YELLOW]}${m[4]:u} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                    && git clone --quiet "${l[2]}" "${d[1]}"

                # Install don't comes by default on rbenv until ruby-build was installed
                [[ -d "${d[3]}" ]] \
                    && show "\n${c[GREEN]}${m[5]:u} ${c[WHITE]}${linei:${#m[5]}} [INSTALLED]" \
                    || show "\n${c[YELLOW]}${m[5]:u} ${c[WHITE]}${linen:${#m[5]}} [INSTALLING]" \
                    && git clone --quiet "${l[3]}" "${d[3]}"

                echo; show "INITIALIZING CONFIGS..."

                [[ ! $(grep --no-messages rbenv "${f[zshrc]}") ]] \
                    && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< '
# Ruby configs
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"' \
                    && source "${f[zshrc]}"

                # rbenv versions
                # rbenv install -l
                [[ ! -d "${d[2]}" ]] && rbenv install "${latest}" &> "${f[null]}"

                rbenv global "${latest}" > "${f[null]}"

                echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
# Remember: Sublime don't show file content if not have access
sublime_stuffs() {

    declare -a d=(
        ~/.config/sublime-text/  # 1
        ~/.config/sublime-text/Installed\ Packages/  # 2
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org  # 3
        /.Trash-1000/  # 4
        ~/.config/sublime-merge/  # 5
    )

    f+=(
        [config]="${d[1]}"Packages/User/Preferences.sublime-settings
        [config_merge]="${d[5]}"Packages/User/Preferences.sublime-settings
        [hosts]=/etc/hosts
        [ppa]=/etc/apt/sources.list.d/sublime-text.list
        [exec]=/opt/sublime_text/sublime_text
        [license]="${d[1]}"Local/License.sublime_license
        [license_merge]="${d[5]}"Local/License.sublime_license
        [pkg_ctrl]="${d[2]}"Package\ Control.sublime-package
        [pkgs]="${d[1]}"Packages/User/Package\ Control.sublime-settings
        [anaconda]="${d[1]}"Packages/Anaconda/Anaconda.sublime-settings
        [keymap]="${d[1]}"Packages/User/Default\ \(Linux\).sublime-keymap
        [REPL]="${d[1]}"Packages/SublimeREPL/SublimeREPL.sublime-settings
        [REPLPY]="${d[1]}"Packages/SublimeREPL/config/Python/Main.sublime-menu
        [reduce]=config/Python/Main.sublime-menu
        [REPLPYT]="${d[1]}"Packages/SublimeREPL/sublimerepl.py
        [recently_used]=~/.local/share/recently-used.xbel
        [free_st]=/tmp/st_sm_cracker.c
        [out]=/tmp/crack.out
        [merge_old]=/opt/sublime_merge/sublime_merge
        [merge_new]=/usr/bin/merge
        [smerge]=/tmp/sublime-merge_build-2068_amd64.deb
    )

    declare -a l=(
        'https://download.sublimetext.com/sublimehq-pub.gpg'  # 1
        'https://download.sublimetext.com/ apt/stable/'  # 2
        'https://packagecontrol.io/Package%20Control.sublime-package'  # 3
        'https://packagecontrol.io/packages/'  # 4
        'https://gist.githubusercontent.com/rafaelribeiroo/bbacd1e735e1b7657b3b0e1a984b2ae7/raw/231a95f55ecd7bc23202885591ed2ce69403396d/st_sm_cracker.c'  # 5
        'https://download.sublimetext.com/sublime-merge_build-2074_amd64.deb'  # 6
    )

    declare -a m=(
        'apt-transport-https'  # 1
        'sublime-text'  # 2
        'gawk'  # 3
        'sublime-merge'  # 4
        'python-is-python3'  # 5
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[3]}"

    if [[ $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && -e "${f[merge_old]}" ]]; then

        show "\n${c[GREEN]}${m[2]:u} ${c[WHITE]}${linei:${#m[2]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[2]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[2]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[1]}"

                sudo sed --in-place '/sublime_text/d' "${f[mimeapps]}"

                sudo sed --in-place '/sublime/d' "${f[hosts]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[2]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # 2> hides
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep Sublime) ]] \
            && sudo wget --quiet --output-document - "${l[1]}" | sudo apt-key add - &> "${f[null]}"

        # [[ ! $(grep --no-messages sublimetext "${f[ppa]}") ]] \
        #     && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb ${l[2]}" \
        #     && update

        [[ ! -e "${f[smerge]}" ]] \
            && show "\n${c[YELLOW]}${m[4]:u} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
            && wget --quiet "${l[6]}" --output-document "${f[smerge]}" \
            && sudo dpkg --install "${f[smerge]}" &> "${f[null]}" \
            && sudo rm --force "${f[smerge]}"

        install_packages "${m[1]}" "${m[2]}"

        # This hides from dpkg --list
        # sudo apt-mark hold "${m[4]}" &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    while [[ ! -d "${d[1]}" ]]; do

        show "\nRESTARTING SUBLIME TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup subl & ) &> "${f[null]}"

        take_a_break

        sudo pkill subl

        take_a_break

    done

    sudo ln --force --symbolic "${f[merge_old]}" "${f[merge_new]}"

    while [[ ! -d "${d[5]}" ]]; do

        show "\nRESTARTING MERGE TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup merge & ) &> "${f[null]}"

        take_a_break

        sudo pkill merge

        take_a_break

    done

    [[ ! -e "${f[free_st]}" ]] \
        && wget --quiet "${l[5]}" --output-document "${f[free_st]}"

    gcc "${f[free_st]}" --output="${f[free_st]//.c/}"

    [[ $(stat --format='%a' "${f[free_st]}") -ne 776 ]] \
        && sudo chmod 776 "${f[free_st]}"

    ( nohup sudo "${f[free_st]//.c/}" & ) &> "${f[out]}"

    for (( ; ; )); do

        [[ $(grep --no-messages 'Paying' "${f[out]}") ]] \
            && break \
            || continue

    done

    # Adding license key
    [[ ! $(grep --no-messages Paying "${f[license]}") ]] \
        && sudo tee "${f[license]}" > "${f[null]}" <<< 'Paying $99 USD'

    # Adding license key
    [[ ! $(grep --no-messages Paying "${f[license_merge]}") ]] \
        && sudo tee "${f[license_merge]}" > "${f[null]}" <<< 'Paying $99 USD'

    # Remove file changes history
    # sudo rm --force "${f[recently_used]}"

    if [[ ! -e "${f[pkg_ctrl]}" ]]; then

        [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

        curl --silent --output "${f[pkg_ctrl]}" --create-dirs "${l[3]}"

    fi

    [[ ! $(grep --no-messages packages "${f[pkgs]}") ]] \
        && sudo tee "${f[pkgs]}" > "${f[null]}" <<< '{
    "installed_packages": ["Anaconda", "Djaneiro", "Restart", "SublimeREPL", "Dracula Color Scheme", "AutoPEP8", "Pretty JSON", "Sync View Scroll"]
}' \
        && sudo chown "${USER}":"${USER}" "${f[pkgs]}"

    read $'?\033[1;37m\nSIR, WANT TO INSTALL SOME ADITTIONAL PACKAGE FROM PACKAGE CONTROL? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            echo; read $'?\033[1;37mTITLE (CASE SENSITIVE): \033[m' pkg

            [[ $(curl --silent --write-out %{http_code} --output "${f[null]}" "${l[4]}""${pkg}") -ne 200 ]] \
                && show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" 1 \
                && continue

            if ! [[ "${pkg}" =~ ^(Anaconda|Djaneiro|Restart|SublimeREPL|Sublimerge Pro|Dracula Color Scheme)$ ]]; then

                # Append new pkg to the last index of tuple
                sudo sed --in-place --regexp-extended "s|(.*)\"|\1\", \"${pkg}\"|" "${f[pkgs]}"

                echo; read $'?\033[1;37mSIR, DO U WANT INSTALL ONE MORE? \n[Y/N] R: \033[m' option

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    continue

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL ONE MORE PACKAGE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            else

                echo; show "\t      REPO ALREADY ${c[RED]}PRE-INSTALLED${c[WHITE]}"

            fi

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL MORE PACKAGES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    [[ ! -d "${d[4]}" ]] \
        && sudo mkdir --parents "${d[4]}" > "${f[null]}" \
        && sudo chown "${USER}":"${USER}" "${d[4]}"

    [[ ! $(grep --no-messages rulers "${f[config]}") ]] \
        && sudo tee "${f[config]}" > "${f[null]}" <<< '{
    "ensure_newline_at_eof_on_save": true,
    "font_size": 12,
    "bold_folder_labels": true,
    "highlight_line": true,
    "ignored_packages":
    [
        "Vintage"
    ],
    "rulers":
    [
        80
    ],
    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "trim_trailing_white_space_on_save": true,
    "word_wrap": false,
    "wrap_width": 80,
    "remember_open_files": true
}'

    [[ ! $(grep --no-messages update_check "${f[config_merge]}") ]] \
        && sudo tee "${f[config_merge]}" > "${f[null]}" <<< '{
    "update_check": false
}'

    while true; do

        ( nohup subl & ) &> "${f[null]}"

        echo && read $'?\033[1;37mSUBLIME ALREADY INSTALL ALL PACKAGES?\n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                sudo pkill subl && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                echo && show "I'LL RESTART... \n(RESTART IS REQUIRED AFTER PACKAGE CONTROL INSTALLATION)"

                sudo pkill subl && ( nohup subl & ) &> "${f[null]}"

                echo && read $'?\033[1;37mPACKAGES ARE INSTALLED? \n[Y/N] R: \033[m' option

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SUBLIME ALREADY INSTALL PACKAGES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

        if [[ -e "${f[anaconda]}" && -e "${f[REPL]}" && -e "${f[REPLPY]}" \
            && -e "${f[REPLPY]}" ]]; then

            [[ ! $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH PYTHON?" \
                && python_stuffs

            sudo sed --in-place 's|"swallow_startup_errors": false|"swallow_startup_errors": true|g' "${f[anaconda]}"

            sudo sed --in-place 's|"python_interpreter": "python",|"python_interpreter": "'$(which python)'",|g' "${f[anaconda]}"

            sudo tee "${f[keymap]}" > "${f[null]}" <<< '[
    { "keys": ["ctrl+p"], "command": "run_existing_window_command", "args": {
        "id": "repl_python_run", "file": '\""config/Python/Main.sublime-menu"\"' }
    },
    { "keys": ["("], "command": "insert_snippet", "args": {"contents": "($0)"}, "context":
        [
            { "key": "setting.auto_match_enabled", "operator": "equal", "operand": true },
            { "key": "selection_empty", "operator": "equal", "operand": true, "match_all": true },
            { "key": "following_text", "operator": "regex_contains", "operand": "^\"(?:\t| |\\)|]|;|\\}|\\\"|$)", "match_all": true }
        ]
    },
    { "keys": ["{"], "command": "insert_snippet", "args": {"contents": "{$0}"}, "context":
        [
            { "key": "setting.auto_match_enabled", "operator": "equal", "operand": true },
            { "key": "selection_empty", "operator": "equal", "operand": true, "match_all": true },
            { "key": "following_text", "operator": "regex_contains", "operand": "^\"(?:\t| |\\)|]|;|\\}|\\\"|$)", "match_all": true }
        ]
    },
    { "keys": ["["], "command": "insert_snippet", "args": {"contents": "[$0]"}, "context":
        [
            { "key": "setting.auto_match_enabled", "operator": "equal", "operand": true },
            { "key": "selection_empty", "operator": "equal", "operand": true, "match_all": true },
            { "key": "following_text", "operator": "regex_contains", "operand": "^\"(?:\t| |\\)|]|;|\\}|\\\"|$)", "match_all": true }
        ]
    },
    { "keys": ["ctrl+t"], "command": "toggle_sync_scroll" }
]'

            # Removes autocomplete at runtime
            sudo sed --in-place 's|"auto_complete": true|"auto_complete": false|g' "${f[REPL]}"

            # Reuse same tab for multiple runtimes
            # https://github.com/wuub/SublimeREPL/issues/481
            sudo sed --in-place --null-data 's|"R"|"r"|1' "${f[REPLPY]}"

            sudo sed --in-place 's|"R"|"d"|g' "${f[REPLPY]}"

            sudo sed --in-place 's|"P"|"p"|g' "${f[REPLPY]}"

            sudo sed --in-place 's|"I"|"p"|g' "${f[REPLPY]}"

            sudo sed --in-place 's|"D"|"d"|g' "${f[REPLPY]}"

            sudo sed --in-place --null-data 's|"cmd": \["python"|"cmd": \["'"$(which python)"'"|3' "${f[REPLPY]}"

            [[ ! $(grep --no-messages '"view_id"' "${f[REPLPY]}") ]] \
                && sudo sed --in-place "s|Language\",|Language\",\n$(printf '%.s ' {1..24})\"view_id\": \"*REPL* [python]\",|g" "${f[REPLPY]}"

            sudo sed --in-place 's|if view.id|if view.name|g' "${f[REPLPYT]}"

            # PY don't run if mix tabs with space
            [[ ! $(grep --no-messages 'focus_view(found)' "${f[REPLPYT]}") ]] \
                && sudo sed --in-place "s|found = view|found = view\n$(printf '%.s ' {1..20})window.focus_view(found)|g" "${f[REPLPYT]}"

            break

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
tmate_stuffs() {

    local -a m=(
        'tmate'  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" &> "${f[null]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    check_ssh

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
usefull_pkgs() {

    local -a d=(
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org/  # 1
        ~/.SpaceVim/  # 2
        ~/.config/vlc/  # 3
        /etc/  # 4
        /etc/series-renamer/  # 5
        ~/.config/autostart/  # 6
        ~/.config/Rename\ My\ TV\ Series/  # 7
        /tmp/coreutils-8.32  # 8
        ~/.local/bin  # 9
        /tmp/  # 10
    )

    f+=(
        [cfg]="${d[2]}"autoload/SpaceVim.vim
        [load]=~/.config/nvim/init.vim
        [lock]="${d[4]}"apt/preferences.d/nosnap.pref
        [out]=/tmp/spacevim.out
        [vlc]="${d[3]}"vlcrc
        [series]="${d[5]}"RenameMyTVSeries
        [rar-file]="${d[4]}"RenameMyTVSeries-2.0.10-Linux64bit.tar.gz
        [startup]=~/.local/share/applications/rename-series.desktop
        [icon]="${d[5]}"icons/128x128.png
        [config]=~/.config/transmission/settings.json
        [key2_cinnamon]=/org/cinnamon/desktop/keybindings/custom-keybindings/clipboard/
        [media_info]=/tmp/nemo-mediainfo-tab_1.0.4_all.deb
        [sticky_cfg]=/org/x/sticky/
        [rename_db]="${d[7]}"LocalData.sqlite3
        [daemon_rnm]=/usr/bin/rename-tv-series
        [recent_items]=/net/launchpad/diodon/clipboard/recent-items-size
        [after_torrent]=/usr/bin/torrent_completed.sh
        [cp_custom]=/tmp/coreutils-8.32.tar.xz
        [patch]=/tmp/coreutils-8.32/advcpmv-0.8-8.32.patch
        [new_cp]=~/.local/bin/cp
        [old_cp]=/tmp/coreutils-8.32/src/cp
    )

    local -a l=(
        'https://spacevim.org/install.sh'  # 1
        'https://www.tweaking4all.com/downloads/video/RenameMyTVSeries-2.0.10-Linux64bit.tar.gz'  # 2
        'https://github.com/transmission/transmission/releases/'  # 3
        'https://github.com/linux-man/nemo-mediainfo-tab/releases/download/v1.0.4/nemo-mediainfo-tab_1.0.4_all.deb'  # 4
        'https://api.pushover.net/1/messages.json'  # 5
        'http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz'  # 6
        'https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch'  # 7
    )

    # Se seu vlc estiver em inglês, instale: "vlc-l10n" e remova ~/.config/vlc
    local -a m=(
        'tree'  # 1
        'vlc'  # 2
        'vim'  # 3
        'easytag'  # 4
        'telegram-desktop'  # 5
        'mlocate'  # 6
        'usefull packages'  # 7
        'soundconverter'  # 8
        'at'  # 9
        'autokey-gtk'  # 10
        'snapd'  # 11
        'compress-video'  # 12
        'spacevim'  # 13
        'dos2unix'  # 14
        'glow'  # 15
        'ffmpeg'  # 16
        'rename-tv-series'  # 17
        'sqlite3'  # 18
        'libsqlite3-dev'  # 19
        'ffmpegthumbnailer'  # 20
        'diodon'  # 21
        'neofetch'  # 22
        'nemo-mediainfo-tab'  # 23
        'transmission-gtk'  # 24
        'doublecmd-gtk'  # 25
        'libssl-dev'  # 26
        'dconf-editor'  # 27
        'python3-mediainfodll'  # 28
        'inotify-tools'  # 29
        'gcc'  # 30
        'g++'  # 31
        'make'  # 32
        'build-essential'  # 33
        'cprogressbar'  # 34
        'peek'  # 35
    )

    [[ ! -d "${d[6]}" || $(stat --format="%U" "${d[6]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[6]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[6]}"

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[14]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[16]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[7]:u} ${c[WHITE]}${linei:${#m[7]}} [INSTALLED]" 1

        read $'?\033[1;37m\nSIR, SHOULD I UNINSTALL THEM? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}, ${c[RED]}${m[2]:u}${c[WHITE]}, ${c[RED]}${m[3]:u}${c[WHITE]}, ${c[RED]}${m[4]:u}${c[WHITE]} AND ${c[RED]}${m[5]:u}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" &> "${f[null]}"

                [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep "${m[5]}") ]] \
                    && sudo add-apt-repository --remove --yes ppa:atareao/telegram &> "${f[null]}"

                [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep "${m[6]}") ]] \
                    && sudo add-apt-repository --remove --yes ppa:bashtop-monitor/bashtop &> "${f[null]}"

                sudo rm --recursive --force "${f[vimrc]}"

                sudo sed --in-place --null-data 's|video/x-matroska=vlc.desktop\nvideo/mp4=vlc.desktop||g' "${f[mimeapps]}"

                sudo sed --in-place '/vlc/d' "${f[zshrc]}"

                sudo sed --in-place '/vlc/d' "${f[mimeapps]}"

                sudo sed --in-place '/"telegram.desktop",/d' "${d[1]}"*.json

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n     I${c[WHITE]}NSTALLING ${c[GREEN]}${m[7]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}"

        [[ -e "${f[lock]}" ]] && sudo rm --force "${f[lock]}"

        install_packages "${m[28]}"

        [[ ! $(dpkg --list | awk "/ii  ${m[23]}[[:space:]]/ {print }") ]] \
            && show "\n${c[GREEN]}${m[23]:u} ${c[WHITE]}${linei:${#m[23]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[23]:u} ${c[WHITE]}${linen:${#m[23]}} [INSTALLING]" \
            && sudo wget --quiet "${l[4]}" --output-document "${f[media_info]}" \
            && sudo dpkg --install "${f[media_info]}" &> "${f[null]}"

        update && install_packages "${m[5]}" "${m[6]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[14]}" "${m[16]}" "${m[18]}" "${m[19]}" "${m[20]}" "${m[21]}" "${m[22]}" "${m[25]}" "${m[26]}" "${m[27]}" "${m[29]}" "${m[30]}" "${m[31]}" "${m[32]}" "${m[33]}" "${m[35]}"

        [[ $(snap list 2>&- | grep "${m[12]}") ]] \
            && show "\n${c[GREEN]}${m[12]:u} ${c[WHITE]}${linei:${#m[12]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[12]:u} ${c[WHITE]}${linen:${#m[12]}} [INSTALLING]" \
            && snap install "${m[12]}" &> "${f[null]}"

        [[ $(snap list 2>&- | grep "${m[15]}") ]] \
            && show "\n${c[GREEN]}${m[15]:u} ${c[WHITE]}${linei:${#m[15]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[15]:u} ${c[WHITE]}${linen:${#m[15]}} [INSTALLING]" \
            && snap install "${m[15]}" &> "${f[null]}"

        [[ -d "${d[2]}" ]] \
            && show "\n${c[GREEN]}${m[13]:u} ${c[WHITE]}${linei:${#m[13]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[13]:u} ${c[WHITE]}${linen:${#m[13]}} [INSTALLING]" \
            && zsh -c "$(curl --silent --location ${l[1]})" &> "${f[out]}"

        if [[ ! -e "${f[new_cp]}" ]]; then

            show "\n${c[YELLOW]}${m[34]:u} ${c[WHITE]}${linen:${#m[34]}} [INSTALLING]"

            [[ ! -d "${d[8]}" ]] \
                && wget --quiet "${l[6]}" --output-document "${f[cp_custom]}" \
                && tar --extract --file="${f[cp_custom]}" --directory="${d[10]}"

            [[ ! -e "${f[patch]}" ]] \
                && wget --quiet "${l[7]}" --output-document "${f[patch]}" \
                && patch --strip=1 --input="${f[patch]}" &> "${f[null]}" \
                && cd "${d[8]}" > "${f[null]}" \
                && ./configure &> "${f[null]}" \
                && make &> "${f[null]}" \
                && cd - > "${f[null]}"

            [[ ! -d "${d[9]}" || $(stat --format="%U" "${d[9]}" 2>&-) != "${USER}" ]] \
                && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
                && sudo mkdir --parents "${d[9]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[9]}"

            sudo cp "${f[old_cp]}" "${f[new_cp]}"

            [[ ! $(grep --no-messages '--progress-bar' "${f[zshrc]}") ]] \
                && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< '
alias cp="${HOME}/.local/bin/cp --progress-bar"' \
                && source "${f[zshrc]}"

        fi

        if [[ ! -e "${f[series]}" ]]; then

            show "\n${c[YELLOW]}${m[17]:u} ${c[WHITE]}${linen:${#m[17]}} [INSTALLING]"

            sudo wget --quiet "${l[2]}" --output-document "${f[rar-file]}"

            sudo mkdir --parents "${d[5]}" > "${f[null]}"

            sudo tar --extract --gzip --file="${f[rar-file]}" --directory="${d[5]}" > "${f[null]}"

            sudo rm --force "${f[rar-file]}"

            [[ ! -x "${f[series]}" ]] \
                && sudo chmod +x "${f[series]}"

            [[ ! $(grep --no-messages Rename "${f[startup]}") ]] \
                && sudo tee "${f[startup]}" > "${f[null]}" <<< "[Desktop Entry]
Type=Application
Encoding=UTF-8
Name=Rename TV Series
Icon=${f[icon]}
Comment=Renamemytvseries
Exec=${f[series]}
Terminal=false
StartupNotify=true"

        else

            show "\n${c[GREEN]}${m[17]:u} ${c[WHITE]}${linei:${#m[17]}} [INSTALLED]"

        fi

        for (( ; ; )); do

            [[ $(grep --no-messages "Updating font cache" "${f[out]}") ]] \
                && break \
                || continue

        done

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ ! -L "${f[daemon_rnm]}" ]] \
        && sudo ln --force --symbolic "${f[series]}" "${f[daemon_rnm]}"

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]] \
        && dconf write "${f[custom_gnome]}" "['${f[custom_gnome]}custom0', '${f[custom_gnome]}custom1', '${f[custom_gnome]}custom2']" \
        && dconf write "${f[custom_gnome]}custom2/binding" "['<Super>v']" \
        && dconf write "${f[custom_gnome]}custom2/command" "'/usr/bin/diodon'" \
        && dconf write "${f[custom_gnome]}custom2/name" "'Clipboard Manager'"

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && dconf write "${f[custom_cinnamon]}" "['printscreen', 'clipboard']" \
        && dconf write "${f[key2_cinnamon]}command" "'/usr/bin/diodon'" \
        && dconf write "${f[key2_cinnamon]}binding" "['<Super>v']" \
        && dconf write "${f[key2_cinnamon]}name" "'Clipboard Manager'" \
        && dconf write "${f[sticky_cfg]}autostart" true \
        && dconf write "${f[sticky_cfg]}autostart-notes-visible" true \
        && dconf write "${f[sticky_cfg]}font" "'Monospace 14'" \
        && dconf write "${f[recent_items]}" 'uint32 10'

    if [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]]; then

        local=$(apt version "${m[24]}")

        latest=$(curl --silent "${l[3]}" | grep 'class="Link--primary"' | head -1 | awk '{print $5}' | tr --complement --delete 0-9,. | xargs)

        if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

            echo; read $'?\033[1;37mSIR, SHOULD I UPGRADE TRANSMISSION VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep transmissionbt) ]] \
                        && sudo add-apt-repository --yes ppa:transmissionbt/ppa &> "${f[null]}" \
                        && update

                    sudo apt install --assume-yes --only-upgrade "${m[24]}" &> "${f[null]}"

                    while [[ ! -e "${f[config]}" ]]; do

                        show "\nRESTARTING TRANSMISSION TO GENERATE CONFIG FILES.\nWAIT..."

                        ( nohup "${m[24]}" & ) &> "${f[null]}"

                        take_a_break

                        sudo pkill "${m[24]}"

                        take_a_break

                    done

                    sudo sed --in-place 's|"download-queue-size".*|"download-queue-size": 50,|g' "${f[config]}"

                    sudo sed --in-place 's|"trash-original-torrent-files": false,|"trash-original-torrent-files": true,|g' "${f[config]}"

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        fi

    fi

    echo; read $'?\033[1;37mSIR, SHOULD I NOTIFY YOU WHEN TORRENTS BY TRANSMISSION-GTK ARE DONE? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            echo; show "SIR, PLEASE CREATE AN ACCOUNT IN https://pushover.net/signup\nAFTER THAT, CREATE AN APPLICATION AND PASTE TOKEN BELOW."

            for (( ; ; )); do

                echo; read $'?\033[1;37mAPI TOKEN: \033[m' app

                read $'?\033[1;37mTOKEN USER '"${e[silent_monkey]}"$': \033[m' user

                [[ $(curl --silent --form-string "token=${app}" --form-string "user=${user}" \
                    --form-string "message=ALFRED DOING SOME TESTS" "${l[5]}" | jq --raw-output .user) = 'invalid' ]] \
                    && show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" \
                    || break

            done

            [[ ! $(grep --no-messages 'curl' "${f[after_torrent]}") ]] \
                && sudo tee "${f[after_torrent]}" > "${f[null]}" <<< '#!/usr/bin/env zsh

declare -a values=(
    '\"${app}\"'  # 1
    '\"${user}\"'  # 2
    "0"  # 3
    "siren"  # 4
    "Torrent Complete!"  # 5
    "<b><i>${TR_TORRENT_NAME:u}</i></b> finished downloading at ${TR_TIME_LOCALTIME}. Check it in ${TR_TORRENT_DIR}"  # 6
    "1"  # 7
    "https://api.pushover.net/1/messages.json"  # 8
)

curl --silent --form-string "token=${values[1]}" \
     --form-string "user=${values[2]}"  --form-string "timestamp=$(date +%s)" \
     --form-string "priority=${values[3]}" --form-string "sound=${values[4]}" \
     --form-string "title=${values[5]}" --form-string "message=${values[6]}" \
     --form-string "html=${values[7]}" "${values[8]}"'
     
            [[ $(stat --format='%a' "${f[after_torrent]}") -ne 755 ]] \
                && sudo chmod 755 "${f[after_torrent]}"

            sudo sed --in-place 's|"script-torrent-done-enabled".*|"script-torrent-done-enabled": true,|g' "${f[config]}"
            
            sudo sed --in-place 's|"script-torrent-done-filename".*|"script-torrent-done-filename": '\""${f[after_torrent]}"\"',|g' "${f[config]}"
                     
            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I NOTIFY YOU?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done




    while [[ ! -e "${f[vlc]}" ]]; do

        show "\nRESTARTING VLC TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[2]}" & ) &> "${f[null]}"

        take_a_break

        sudo pkill "${m[2]}"

        take_a_break

    done

    sudo sed --in-place 's|#avcodec-hw=any|avcodec-hw=none|g' "${f[vlc]}"

    sudo sed --in-place 's|#freetype-rel-fontsize=0|freetype-rel-fontsize=12|g' "${f[vlc]}"

    sudo sed --in-place 's|#freetype-color=16777215|freetype-color=16776960|g' "${f[vlc]}"

    sudo sed --in-place 's|#video-title-show=1|video-title-show=0|g' "${f[vlc]}"

    while [[ ! -d "${d[7]}" ]]; do

        show "\nRESTARTING RENAME-SERIES TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[17]}" & ) &> "${f[null]}"

        take_a_break

        kill -9 $(pidof RenameMyTVSeries rename-tv-series) &> "${f[null]}"

        take_a_break

    done

    sqlite3 "${f[rename_db]}" "UPDATE preferences SET CheckForUpdates = 0;" "" > "${f[null]}"

    sqlite3 "${f[rename_db]}" "UPDATE preferences SET FileNameFormatString = '%E. %T';" "" > "${f[null]}"

    sqlite3 "${f[rename_db]}" "UPDATE preferences SET SeasonNrAtLeast2Chars = 0;" "" > "${f[null]}"

    sqlite3 "${f[rename_db]}" 'DELETE FROM replacechars WHERE replacement = "`";' "" > "${f[null]}"

    # These character class match once only, so we need +
    # https://www.petefreitag.com/cheatsheets/regex/character-classes/
    [[ $(grep --no-messages --extended-regexp '([[:space:]]+ = )1' "${f[cfg]}") ]] \
        && sed --in-place --regexp-extended 's|([[:space:]]+ = )1|\10|g' "${f[cfg]}"

    # set wrap breaks line when is too long
    # set mouse allow mouse highligh text
    [[ ! $(grep --no-messages mouse "${f[load]}") ]] \
        && sudo tee --append "${f[load]}" > "${f[null]}" <<< 'set mouse=a
set wrap'

    [[ ! $(grep --no-messages 'alias vk' "${f[zshrc]}") ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
alias vk='kill -9 \$(pidof vlc) &> ${f[null]}'" \
        && source "${f[zshrc]}"

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
workspace_stuffs() {

    local -a d=(
        /workspace/  # 1
    )

    f+=(
        [bookmarks]=~/.config/gtk-3.0/bookmarks
        [check_repo]=/tmp/check_repo
        [out]=/tmp/check_connection
        [token]=~/.config/gh/hosts.yml
        [bookmarks_in]=/org/nemo/preferences/show-bookmarks-in-to-menus
        [expand]=/org/nemo/window-state/bookmarks-expanded
        [show]=/com/linuxmint/mintmenu/plugins/places/show-gtk-bookmarks
    )

    local -a l=(
        'https://api.github.com/user'  # 1
        'https://api.github.com/repos/'  # 2
        'git@github.com:'  # 3
    )

    local -a m=(
        'dconf-editor'  # 1
    )

    if [[ -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) = ${USER} ]]; then

        show "\n${c[GREEN]}${d[1]:u} ${c[WHITE]}${linec:${#d[1]}} [CREATED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I REMOVE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}R${c[WHITE]}EMOVING ${c[RED]}${d[1]:u}${c[WHITE]}!\n"

                sudo rm --force --recursive "${d[1]}"

                [[ $(grep --no-messages workspace "${f[bookmarks]}") ]] \
                    && sudo sed --in-place $'s|file:///workspace \360\237\221\211 Workspace||g' "${f[bookmarks]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t C${c[WHITE]}REATING ${c[GREEN]}${d[1]:u}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" 1

        show "${c[GREEN]}C${c[WHITE]}REATING ${c[GREEN]}${d[1]:u}${c[WHITE]}"

        sudo mkdir --parents "${d[1]}" > "${f[null]}"

        sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

        install_packages "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && dconf write "${f[bookmarks_in]}" true \
        && dconf write "${f[expand]}" true \
        && dconf write "${f[show]}" true

    # Lost your bookmarks? Run xdg-user-dirs-gtk-update
    [[ ! $(grep --no-messages workspace "${f[bookmarks]}") ]] \
        && sudo tee --append "${f[bookmarks]}" > "${f[null]}" <<< $'file:///workspace \360\237\221\211 Workspace'

    echo; read $'?\033[1;37mSIR, SHOULD I DOWNLOAD ANY REPO FROM UR GITHUB ACCOUNT? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            [[ ! $(yes "" | ssh -T git@github.com 2>&1 | grep --no-messages "You've successfully") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH GITHUB?" \
                && github_stuffs

            user_gh=$(grep --no-messages oauth_token: "${f[token]}" | awk '{print $2}')

            read $'?\033[1;37m\nSIR, WHICH REPOSITORY DO U WANT?\nR: \033[m' repo

            for (( ; ; )); do

                [[ -d "${d[1]}${repo}" ]] \
                    && show "\n\t\t${c[RED]}REPO ALREADY DOWNLOADED" 1 \
                    && break

                if [[ $(grep successfully "${f[ssh]}") ]]; then

                    if [[ ! -z $(curl --silent "${l[2]}$(curl --silent --header "Authorization: Bearer ${user_gh}" "${l[1]}" | jq --raw-output .login)/${repo}" | jq .id) ]]; then

                        git clone --quiet "${l[3]}$(curl --silent --header "Authorization: Bearer ${user_gh}" "${l[1]}" | jq --raw-output .login)/${repo}.git" "${d[1]}${repo}" 2> "${f[null]}"

                        clear

                        read $'?\033[1;37mWANT DOWNLOAD MORE REPO? \n[Y/N] R: \033[m' option

                        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                            repo='$'

                            read $'?\033[1;37m\nWHICH IS\nR: \033[m' repo

                            continue  # Simillar to pass

                        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                            break

                        else

                            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. WANT U DOWNLOAD MORE REPOSITORIES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                            read option

                        fi

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}REPO DOESN'T EXISTS!\n\nSR. WHICH REPO SHOULD I DOWNLOAD?${c[END]}\n${c[WHITE]}R: "${c[END]}

                        read repo

                    fi

                else

                    ssh -o BatchMode=yes -T git@github.com &> "${f[ssh]}"

                    continue

                fi

            done

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I DOWNLOAD SOME REPOSITORIES OF YOUR GITHUB ACCOUNT?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
xscreensaver_stuffs() {

    local -a d=(
        ~/.config/autostart/  # 1
    )

    f+=(
        [screen_saver]=~/.xscreensaver
        [gluqlo]=/tmp/gluqlo_1.1-1ubuntu2~xenial1_amd64.deb
        [screensaver_cinnamon]=/org/cinnamon/desktop/session/idle-delay
        [dskt]="${d[1]}"xscreensaver.desktop
        [new_gluqlo]=/usr/libexec/xscreensaver/gluqlo
        [old_gluqlo]=/usr/lib/xscreensaver/gluqlo
        [fix-broken]=/tmp/check_upgrade
    )

    local -a l=(
        'https://launchpad.net/~alexanderk23/+archive/ubuntu/ppa/+files/gluqlo_1.1-1ubuntu2~xenial1_amd64.deb'  # 1
    )

    # https://forum.xfce.org/viewtopic.php?id=12635
    local -a m=(
        'xscreensaver'  # 1
        'xscreensaver-gl-extra'  # 2
        'xscreensaver-data-extra'  # 3
        'gluqlo'  # 4
        'build-essential'  # 5
        'libsdl1.2-dev'  # 6
        'libsdl-ttf2.0-dev'  # 7
        'libsdl-gfx1.2-dev'  # 8
        'libx11-dev'  # 9
        'xscreensaver-demo'  # 10
        'dconf-editor'  # 11
    )

    [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"



                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_packages "${m[1]}" "${m[2]}" "${m[3]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[11]}"

        [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
            && show "\n${c[YELLOW]}${m[4]:u} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
            && sudo wget --quiet "${l[1]}" --output-document "${f[gluqlo]}" \
            && sudo dpkg --install "${f[gluqlo]}" &> "${f[null]}" \
            || show "\n${c[GREEN]}${m[4]:u} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]"

        sudo apt update &> "${f[null]}"

        sudo apt upgrade --yes &> "${f[fix-broken]}"

        [[ ! $(grep --no-messages 'unmet dependencies' "${f[fix-broken]}") ]] \
            && sudo apt --fix-broken --yes install &> "${f[null]}"

        # or /lib/xscreensaver/gluqlo
        [[ ! -e "${f[new_gluqlo]}" ]] \
            && sudo mv "${f[old_gluqlo]}" "${f[new_gluqlo]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    while [[ ! -e "${f[screen_saver]}" ]]; do

        show "\nRESTARTING XSCREENSAVER TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[1]}" & ) &> "${f[null]}"

        sleep 6s

        sudo pkill "${m[1]}"

        take_a_break

    done

    [[ ! $(grep --no-messages XscreenSaver "${f[dskt]}") ]] \
        && sudo tee "${f[dskt]}" > "${f[null]}" <<< '[Desktop Entry]
Name=XscreenSaver
Name[pt_BR]=XscreenSaver
Exec=xscreensaver -no-splash
Icon=redshift
Terminal=false
Type=Application
Categories=Utility;
StartupNotify=true
Hidden=false
X-GNOME-Autostart-enabled=true'

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && dconf write "${f[screensaver_cinnamon]}" 'uint32 0'

    [[ ! $(grep --no-messages 'gluqlo' "${f[screen_saver]}") ]] \
        && sudo sed --in-place '47 a\'"$(printf '%.s ' {0..7})"'gluqlo -root \n\\' "${f[screen_saver]}"

    # Changes not being applied?
    # xrdb -load ~/.xscreensaver && killall xscreensaver && xscreensaver -no-splash &
    sudo sed --in-place 's|lock:.*|lock:  True|g' "${f[screen_saver]}"

    sudo sed --in-place 's|mode:.*|mode:  one|g' "${f[screen_saver]}"

    sudo sed --in-place 's|selected:.*|selected:  1|g' "${f[screen_saver]}"

    sudo sed --in-place 's|lockTimeout:.*|LockTimeout: 0:03:00|g' "${f[screen_saver]}"

    echo; read $'?\033[1;37mSIR, SHOULD I OPEN XSCREENSAVER? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            ( nohup "${m[10]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
zsh_stuffs() {

    source "${f[user_dirs]}"

    local -a d=(
        ~/.oh-my-zsh  # 1
        ~/.fonts/  # 2
        ~/.config/fontconfig/conf.d/  # 3
    )

    f+=(
        [powerline_otf]="${d[2]}"PowerlineSymbols.otf
        [powerline_conf]="${d[3]}"10-powerline-symbols.conf
        [original]=/etc/skel/.bashrc
        [bkp_zsh]=~/.zshrc_bkp
        [meslo]="${d[2]}"Meslo.zip
        [color]=/var/lib/gems/3.0.0/gems/colorls-1.4.6/lib/colorls.rb
    )

    local -a l=(
        'https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh'  # 1
        'https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf'  # 2
        'https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf'  # 3
        'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip'  # 4
        'https://github.com/spaceship-prompt/spaceship-prompt.git'  # 5
        'https://github.com/zsh-users/zsh-syntax-highlighting'  # 6
        'https://github.com/zsh-users/zsh-autosuggestions'  # 7
    )

    local -a m=(
        'oh-my-zsh'  # 1
        'xdotool'  # 2
        'ruby-dev:amd64'  # 3
        'colorls'  # 4
        'git'  # 5
    )

    if [[ -d "${d[1]}" ]]; then

        show "\n${c[GREEN]}${m[1]:u} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

        read $'?\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]:u}${c[WHITE]}!\n"

                # sudo apt remove --purge --yes "${m[4]}" &> "${f[null]}"

                # --force: ignore nonexistent files, never prompt
                # --recursive: remove directories
                sudo rm --force --recursive "${d[1]}"

                cp "${f[zshrc]}" "${f[bkp_zsh]}" &> "${f[null]}"

                sudo rm --force "${f[powerline_otf]}" "${f[powerline_conf]}" "${f[zshrc]}"

                cp "${f[original]}" "${f[zshrc]}" &> "${f[null]}"

                source "${f[zshrc]}"

                # remove_useless

                echo; read $'?\033[1;37mSIR, SHOULD I GO BACK TO BASH? \n[Y/N] R: \033[m' option

                for (( ; ; )); do

                    if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                        # sudo sed --in-place "s|${USER}:/bin/bash|${USER}:/bin/zsh|g" /etc/passwd
                        [[ $(echo "${SHELL}") = '/bin/zsh' ]] \
                            && sudo chsh --shell $(which bash)

                        read $'?\033[1;37mSIR, I\'M NEED TO APPLY CHANGES. SHOULD I REBOOT? \n[Y/N] R: \033[m' option

                        for (( ; ; )); do

                            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                                sudo reboot

                            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                                break

                            else

                                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I REBOOT?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                                read option

                            fi

                        done

                        break

                    elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I TURN BASH DEFAULT AGAIN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                        read option

                    fi

                done

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]:u}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_packages "${m[2]}" "${m[5]}"

        show "\n${c[YELLOW]}${m[1]:u} ${c[WHITE]}${linen:${#m[1]}} [INSTALLING]"

        zsh -c "$(curl --silent --show-error --fail --location ${l[1]})" "" --unattended &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ ! $(grep --no-messages DEFAULT_USER "${f[zshrc]}") ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
# Hides user from terminal
# DEFAULT_USER=${USER}

# Don't overwrite existing files with '>'
set +o noclobber

# Hides default behavior from zsh in grep: no matches found.
setopt +o nomatch

alias c='clear'

alias remove_all_pip_packages='pip freeze | xargs pip uninstall -y'

declare -A c=(
    [WHITE]='\033[1;37m'
    [END]='\e[0m'
)

alias unstaged='find -type d -name .git | sed \"s|^./||g\" | while read dir; do zsh -c \"cd \${dir}/../ && echo \"\${c[WHITE]}GIT STATUS IN \${dir%%.git}\${c[END]}\" && git status --short\"; done'" \
        && sudo sed --in-place 's|echo "\${c\[W|echo \\"${c[W|g' "${f[zshrc]}" \
        && sudo sed --in-place 's|\[END]}"|[END]}\\"|g' "${f[zshrc]}" \
        && source "${f[zshrc]}"

    if [[ $(grep --no-messages "${USER}:/bin/bash" "${f[passwd]}") ]]; then

        echo; read $'?\033[1;37mSIR, SHOULD I SET ZSH DEFAULT SHELL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                # chsh --shell $(which zsh)
                # ps --pid $$ | tail -1 | awk '{print $4}'
                sudo sed --in-place "s|${USER}:/bin/bash|${USER}:/bin/zsh|g" "${f[passwd]}"

                echo; read $'?\033[1;37mSIR, I\'M NEED TO APPLY CHANGES. SHOULD I REBOOT? \n[Y/N] R: \033[m' option

                for (( ; ; )); do

                    if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                        sudo reboot

                    elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I REBOOT?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                        read option

                    fi

                done

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I TURN ZSH DEFAULT?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    # default theme
    if [[ $(grep --no-messages 'ZSH_THEME="robbyrussell"' "${f[zshrc]}") ]]; then

        echo; read $'?\033[1;37mSIR, DO YOU PREFER SPACESHIP THEME OVER AGNOSTER? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                f+=(
                    [old_spaceship]="${ZSH_CUSTOM}"/themes/spaceship-prompt/spaceship.zsh-theme
                    [new_spaceship]="${ZSH_CUSTOM}"/themes/spaceship.zsh-theme
                )

                d+=(
                    "${ZSH_CUSTOM}"/themes/spaceship-prompt  # 4
                    "${ZSH_CUSTOM}"/plugins/zsh-syntax-highlighting  # 5
                    "${ZSH_CUSTOM}"/plugins/zsh-autosuggestions  # 6
                )

                [[ ! -d "${d[4]}" || ! -d "${d[5]}" || ! -d "${d[6]}" ]] \
                    && git clone --quiet --depth=1 "${l[5]}" "${d[4]}" \
                    && git clone --quiet --depth=1 "${l[6]}" "${d[5]}" \
                    && git clone --quiet --depth=1 "${l[7]}" "${d[6]}"

                sudo ln --force --symbolic "${f[old_spaceship]}" "${f[new_spaceship]}"

                sudo sed --in-place 's|ZSH_THEME=.*|ZSH_THEME="spaceship"|g' "${f[zshrc]}"

                [[ ! $(grep --no-messages 'plugins=(git ' "${f[zshrc]}") ]] \
                    && sed --in-place --null-data 's|plugins=(git)|plugins=(git python pip virtualenv copyfile zsh-syntax-highlighting zsh-autosuggestions)|g' "${f[zshrc]}" \
                    && source "${f[zshrc]}"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                if [[ ! -e "${f[powerline_otf]}" ]]; then

                    # Hidden directories are owned by root, we must change owner to bash "read"
                    # 2>&- hides: "can't stat: no such file..."
                    [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != ${USER} ]] \
                        && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
                        && sudo chown --recursive "${USER}":"${USER}" "${d[2]}" # Close error output

                    # --location follows to last URL (github provides a few redirects)
                    # --output write content to file
                    curl --silent --location --output "${f[powerline_otf]}" --create-dirs "${l[2]}"

                    # Update font cache
                    sudo fc-cache --force "${d[2]}"

                fi

                if [[ ! -e "${f[powerline_conf]}" ]]; then

                    [[ ! -d "${d[3]}" || $(stat --format="%U" "${d[3]}" 2>&-) != ${USER} ]] \
                        && sudo mkdir --parents "${d[3]}" > "${f[null]}" \
                        && sudo chown --recursive "${USER}":"${USER}" "${d[3]%conf.d}"

                    curl --silent --location --output "${f[powerline_conf]}" --create-dirs "${l[3]}"

                    # Workaround to prevent terminal restart
                    xdotool key Ctrl+plus && xdotool key Ctrl+minus

                fi

                sudo sed --in-place 's|ZSH_THEME=.*|ZSH_THEME="agnoster"|g' "${f[zshrc]}"

                [[ ! $(grep --no-messages 'plugins=(git ' "${f[zshrc]}") ]] \
                    && sed --in-place --null-data 's|plugins=(git)|plugins=(git python pip virtualenv copyfile)|g' "${f[zshrc]}" \
                    && source "${f[zshrc]}"

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U PREFER SPACESHIP?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    if [[ ! -e "${f[color]}" ]]; then

        echo; read $'?\033[1;37mSIR, DO U WANT TO INSTALL COLORIZED LS? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                    && show "\nFIRST THINGS FIRST. DO U PASS THROUGH RUBY?" \
                    && ruby_stuffs

                # ruby-dev is essential
                [[ ! $(sudo gem list 2>&- | grep --no-messages "${m[4]}") ]] \
                    && show "\n${c[YELLOW]}${m[4]:u} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                    && sudo gem install --silent "${m[4]}"

                [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != ${USER} ]] \
                    && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
                    && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

                [[ ! -e "${f[meslo]}" ]] \
                    && wget --quiet "${l[4]}" --output-document "${f[meslo]}" \
                    && unzip "${f[meslo]}" -d "${d[2]}" &> "${f[null]}" \
                    && rm --force --recursive "${f[meslo]}" "${d[2]}"*Windows*.ttf

                sudo fc-cache --force "${d[2]}"

                [[ ! $(grep --no-messages "${m[4]}" "${f[zshrc]}") ]] \
                    && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
# Colorls stuffs
source $(dirname $(sudo gem which ${m[4]}))/tab_complete.sh

alias ll='${m[4]}'" \
                    && source "${f[zshrc]}"

                echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                for (( ; ; )); do

                    if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                        sudo reboot

                    elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                        read option

                    fi

                done

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
change_panelandgui() {

    f+=(
        [automount]=/org/cinnamon/desktop/media-handling/automount
        [automount_open]=/org/cinnamon/desktop/media-handling/automount-open
        [open_folder]=/org/cinnamon/desktop/media-handling/autorun-x-content-open-folder
        [start_app]=/org/cinnamon/desktop/media-handling/autorun-x-content-start-app
        [autostart_blacklist]=/org/cinnamon/cinnamon-session/autostart-blacklist
        [computer_icon]=/org/nemo/desktop/computer-icon-visible
        [volumes_icon]=/org/nemo/desktop/volumes-visible
        [default_sort_order]=/org/nemo/preferences/default-sort-order
        [default_sort_reverse]=/org/nemo/preferences/default-sort-in-reverse-order
        [default_sort_reverse_gnome]=/org/gnome/nautilus/preferences/default-sort-in-reverse-order
        [home_icon]=/org/nemo/desktop/home-icon-visible
        [icon_theme]=/org/cinnamon/desktop/interface/icon-theme
        [icon_theme_gnome]=/org/gnome/desktop/interface/icon-theme
        [looking_glass]=/org/cinnamon/desktop/keybindings/looking-glass-keybinding
        [numlock]=/etc/lightdm/slick-greeter.conf
        [paste]=/org/gnome/terminal/legacy/keybindings/paste
        [screensaver]=/org/cinnamon/desktop/keybindings/media-keys/screensaver
        [show_hidden]=/org/nemo/preferences/show-hidden-files
        [show_hidden_gnome]=/org/gnome/nautilus/preferences/show-hidden-files
        [thumbnail-limit]=/org/nemo/preferences/thumbnail-limit
        [thumbnail-limit-gnome]=/org/gnome/nautilus/preferences/thumbnail-limit
        [reverse-order]=/org/nemo/preferences/default-sort-in-reverse-order
        [default-order]=/org/nemo/preferences/default-sort-order
        [trash_gnome]=/org/gnome/shell/extensions/dash-to-dock/show-trash
        [mount_gnome]=/org/gnome/shell/extensions/dash-to-dock/show-mounts
        [delay_screensaver]=/org/cinnamon/desktop/session/idle-delay
        [auto_upgrade]=/etc/apt/apt.conf.d/20auto-upgrades
        [cedilha]=/usr/bin/cedilha
        [out]=/tmp/cedilha.out
        [cursor]=/org/cinnamon/desktop/interface/cursor-theme
        [util_extract]=/etc/manage_files.sh
        [cron]=/var/spool/cron/"${USER}"
        [cron_bin]=/usr/bin/crontab
        [unattended]=/etc/apt/apt.conf.d/50unattended-upgrades
        [convert]=generator/convert.rb
    )

    local -a d=(
        /tmp/linux-firmware/  # 1
        /lib/firmware/amdgpu/  # 2
        /tmp/linux-firmware/amdgpu/  # 3
        /tmp/oreo-cursors/  # 4
    )

    local -a l=(
        'https://raw.githubusercontent.com/marcopaganini/gnome-cedilla-fix/master/fix-cedilla'  # 1
        'https://kernel.googlesource.com/pub/scm/linux/kernel/git/firmware/linux-firmware.git'  # 2
        'https://github.com/varlesh/oreo-cursors.git'  # 3
        'https://gist.githubusercontent.com/rafaelribeiroo/a7e8b342308f4381c5fc4798624be9b0/raw/711322654b44b1507f6ae66607a7cb91dfbc21e7/manage_files.sh'  # 4
    )

    local -a m=(
        'dconf-editor'  # 1
        'numlockx'  # 2
        'vlc'  # 3
        'sublime-text'  # 4
        'brave-browser'  # 5
        'google-chrome-stable'  # 6
        'git'  # 7
        'make'  # 8
        'inkscape'  # 9
        'ruby'  # 10
        'inotify-tools'  # 11
        'unattended-upgrades'  # 12
        'update-notifier-common'  # 13
        'language-pack-pt-base'  # 14
        'language-pack-gnome-pt-base'  # 15
        'hyphen-fi'  # 16
        'hyphen-ga'  # 17
        'hyphen-id'  # 18
    )

    install_packages "${m[1]}" "${m[2]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}" "${m[18]}"

    # Cinnamon needs a png thumbnail in the icon themes cursors folder called
    # thumbnail.png or a named thumbnail in /usr/share/cinnamon/thumbnails/cursors
    # e.g. capitaine.png.
    echo; read $'?\033[1;37mSIR, DO YOU WANT A CUSTOM CURSOR? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            install_packages "${m[7]}" "${m[8]}" "${m[9]}"

            git clone --quiet "${l[3]}" "${d[4]}"

            [[ ! $(dpkg --list | awk "/ii  ${m[10]}[[:space:]]/ {print }") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH RUBY?" \
                && ruby_stuffs

            cd "${d[4]}" > "${f[null]}"

            ruby "${f[convert]}" &> "${f[null]}"

            make build &> "${f[null]}"

            sudo make install &> "${f[null]}"

            cd - > "${f[null]}"

            dconf write "${f[cursor]}" "'oreo_spark_violet_cursors'"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. DO YOU WANT A CUSTOM CURSOR?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; read $'?\033[1;37mSIR, DO YOU WANT UNPACK AUTOMATICALLY AT DOWNLOADS FOLDER? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            install_packages "${m[11]}"

            [[ ! -e "${f[util_extract]}" ]] \
                && sudo wget --quiet "${l[4]}" --output-document "${f[util_extract]}"

            [[ $(stat --format="%U" "${f[util_extract]}" 2>&-) != ${USER} ]] \
                && sudo chown "${USER}":"${USER}" "${f[util_extract]}"

            # crontab -u ${USER} -l
            [[ ! $(grep --no-messages upgrade "${f[cron]}") ]] \
                && sudo tee "${f[cron]}" > "${f[null]}" <<< "# MINUTE HOUR MONTH_DAY MONTH  WEEKDAY COMMAND
# 0-59    0-23 1-31       1-12 0-7           zsh MY_SCRIPT.sh
@reboot zsh ${f[util_extract]}" \
                && "${f[cron_bin]}" "${f[cron]}"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. DO YOU WANT A AUTOMATICALLY EXTRACT?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; read $'?\033[1;37mSIR, ARE YOU FACING ISSUES TO TYPE Ç ON YOUR KEYBOARD? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            [[ ! -e "${f[cedilha]}" ]] \
                && sudo curl --silent --location --output "${f[cedilha]}" --create-dirs "${l[1]}"

            [[ $(stat --format='%a' "${f[cedilha]}") -ne 755 ]] \
                && sudo chmod 755 "${f[cedilha]}"

            ( nohup "${f[cedilha]}" & ) &> "${f[out]}"

            for (( ; ; )); do

                [[ $(grep --no-messages 'Operation complete.' "${f[out]}") ]] \
                    && break \
                    || continue

            done

            echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    sudo reboot

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE YOU HAVING ISSUES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; read $'?\033[1;37mSIR, YOUR SYSTEM ARE LOST SOME AMD FIRMWARES? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            [[ ! -d "${d[1]}" ]] \
                && git clone --quiet "${l[2]}" "${d[1]}"

            sudo cp --recursive "${d[3]}"* "${d[2]}"
            
            # sudo update-initramfs -u
            sudo update-initramfs -k all -u -v 2>&- &> "${f[null]}"

            echo && read $'?\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    sudo reboot

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE YOU UNPROTECTED?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    # STARTS UPGRADE AUTOMATICALLY
    if [[ ! $(grep --no-messages 'Update-Package' "${f[auto_upgrade]}") ]]; then

        install_packages "${m[12]}" "${m[13]}"

        echo; read $'?\033[1;37m\nENTER YOUR EMAIL, '"${name[random]}"$': \033[m' email

        sudo sed --in-place "s|//Unattended-Upgrade::Mail \"\";|Unattended-Upgrade::Mail \"${email}\";|g" "${f[unattended]}"

        sudo sed --in-place 's|//Unattended-Upgrade::MailReport "on-change";|Unattended-Upgrade::MailReport "only-on-error";|g' "${f[unattended]}"

        sudo sed --in-place 's|//    "${distro_id}:${distro_codename}-updates";|    "${distro_id}:${distro_codename}-updates";|g' "${f[unattended]}"

        # sudo unattended-upgrades --dry-run --debug
        # Check periodically /lib/systemd/system/apt-daily.timer
        sudo tee "${f[auto_upgrade]}" > "${f[null]}" <<< 'APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";'

    fi  # ENDS UPGRADE AUTOMATICALLY

    # START NUMLOCK ALWAYS ACTIVE AT STARTUP
    [[ ! -e "${f[numlock]}" && "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && sudo tee "${f[numlock]}" > "${f[null]}" <<< '[Greeter]
activate-numlock=true'

    [[ $(grep --no-messages false "${f[numlock]}") ]] \
        && sudo sed --in-place 's|false|true|g' "${f[numlock]}"  # END NUMLOCK

    # START GUI CHANGES
    dconf write "${f[paste]}" "'<Ctrl>v'"

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]] \
        && dconf write "${f[show_hidden]}" true \
        && dconf write "${f[thumbnail-limit]}" 'uint64 34359738368' \
        && dconf write "${f[default_sort_reverse]}" false \
        && dconf write "${f[gtk_theme_gnome]}" "'Yaru-viridian-dark'" \
        && dconf write "${f[icon_theme]}" "'Yaru-viridian'" \
        && dconf write "${f[custom_gnome]}" "['${f[custom_gnome]}custom0']" \
        && dconf write "${f[custom_gnome]}custom0/binding" "'<Super>e'" \
        && dconf write "${f[custom_gnome]}custom0/command" "'nautilus'" \
        && dconf write "${f[custom_gnome]}custom0/name" "'Raise Nautilus'" \
        && dconf write "${f[trash_gnome]}" false \
        && dconf write "${f[mount_gnome]}" false

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && dconf write "${f[computer_icon]}" false \
        && dconf write "${f[volumes_icon]}" false \
        && dconf write "${f[home_icon]}" false \
        && dconf write "${f[automount]}" true \
        && dconf write "${f[automount_open]}" true \
        && dconf write "${f[open_folder]}" "['x-content/bootable-media']" \
        && dconf write "${f[start_app]}" "['x-content/unix-software', 'x-content/bootable-media']" \
        && dconf write "${f[show_hidden]}" true \
        && dconf write "${f[thumbnail-limit]}" 'uint64 34359738368' \
        && dconf write "${f[looking_glass]}" "['<Ctrl><Alt>l']" \
        && dconf write "${f[screensaver]}" "['<Super>l', 'XF86ScreenSaver']" \
        && dconf write "${f[default_sort_order]}" "'name'" \
        && dconf write "${f[default_sort_reverse]}" false \
        && dconf write "${f[gtk_theme]}" "'Mint-Y-Dark-Red'" \
        && dconf write "${f[icon_theme]}" "'Mint-Y-Red'" \
        && dconf write "${f[delay_screensaver]}" "uint32 180" \
        && dconf write "${f[autostart_blacklist]}" "['gnome-settings-daemon', 'org.gnome.SettingsDaemon', 'gnome-fallback-mount-helper', 'gnome-screensaver', 'mate-screensaver', 'mate-keyring-daemon', 'indicator-session', 'gnome-initial-setup-copy-worker', 'gnome-initial-setup-first-login', 'gnome-welcome-tour', 'xscreensaver-autostart', 'nautilus-autostart', 'caja', 'xfce4-power-manager', 'mintwelcome']"  # END GUI


    [[ -e "${f[mimeapps]}" ]] \
            && sudo cp "${f[mimeapps]}" "${f[mimebkp]}"

    echo; read $'?\033[1;37mSIR, CAN I TURN APPLICATIONS DEFAULT? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

            [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH USEFULL PACKAGES?" \
                && usefull_pkgs

            [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH SUBLIME TEXT?" \
                && sublime_stuffs

            echo; read $'?\033[1;37mSIR, DO YOU PREFER BRAVE BROWSER OVER CHROME BROWSER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                    [[ ! $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") ]] \
                        && show "\nFIRST THINGS FIRST. DO U PASS THROUGH BRAVE?" \
                        && brave_stuffs

                    prefer='brave-browser'

                    break

                elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                    [[ ! $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") ]] \
                        && show "\nFIRST THINGS FIRST. DO U PASS THROUGH CHROME?" \
                        && chrome_stuffs

                    prefer='google-chrome'

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U PREFER BRAVE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            sudo tee "${f[mimeapps]}" > "${f[null]}" <<< "[Default Applications]
text/html=${prefer}.desktop
x-scheme-handler/http=${prefer}.desktop
x-scheme-handler/https=${prefer}.desktop
x-scheme-handler/about=${prefer}.desktop
x-scheme-handler/unknown=${prefer}.desktop
x-scheme-handler/mailto=${prefer}.desktop
text/plain=sublime_text.desktop
video/x-matroska=vlc.desktop
video/mp4=vlc.desktop
video/x-msvideo=vlc.desktop
audio/mpeg=io.github.celluloid_player.Celluloid.desktop

[Added Associations]
video/x-matroska=vlc.desktop;
application/x-partial-download=vlc.desktop;
video/mp4=vlc.desktop;
video/x-ogm+ogg=vlc.desktop;
video/mpeg=vlc.desktop;
video/x-avi=vlc.desktop;
video/x-ms-wmv=vlc.desktop;
text/plain=sublime_text.desktop;
text/csv=sublime_text.desktop;
application/xml=sublime_text.desktop;
text/html=sublime_text.desktop;
text/css=sublime_text.desktop;
text/markdown=sublime_text.desktop;
application/json=sublime_text.desktop;
application/javascript=sublime_text.desktop;
text/x-python=sublime_text.desktop;
application/x-shellscript=sublime_text.desktop;
application/x-subrip=sublime_text.desktop;"

            break

        elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U WANT TO APPLY DEFAULT APPLICATIONS?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

}
#======================#

#======================#
evoke_functions() {

    case "${choice}" in

        0|00) close_menu &> "${f[null]}" ;;
        1|01) alexa_stuffs && return_menu ;;
        2|02) brave_stuffs && return_menu ;;
        3|03) deemix_stuffs && return_menu ;;
        4|04) docky_stuffs && return_menu ;;
        5|05) dualmonitor_stuffs && return_menu ;;
        6|06) github_stuffs && return_menu ;;
        7|07) chrome_stuffs && return_menu ;;
        8|08) flameshot_stuffs && return_menu ;;
        9|09) heroku_stuffs && return_menu ;;
        10) hide_devices && return_menu ;;
        11) minidlna_stuffs && return_menu ;;
        12) nvidia_stuffs && return_menu ;;
        13) postgres_stuffs && return_menu ;;
        14) postman_stuffs && return_menu ;;
        15) python_stuffs && return_menu ;;
        16) reduceye_stuffs && return_menu ;;
        17) ruby_stuffs && return_menu ;;
        18) sublime_stuffs && return_menu ;;
        19) tmate_stuffs && return_menu ;;
        20) usefull_pkgs && return_menu ;;
        21) workspace_stuffs && return_menu ;;
        22) xscreensaver_stuffs && return_menu ;;
        23) zsh_stuffs && return_menu ;;
        24) echo; show "KNOW YOUR LIMITS ${name[random]}..."

        echo; read $'?\033[1;37mSIR, DO U TRUST ME TO DO MY OWN CHANGES? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ ^(s|S|y|Y)$ ]] ; then

                change_panelandgui

                echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                break

            elif [[ "${option:0:1}" =~ ^(N|n)$ ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I DO MY OWN CHANGES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

        alexa_stuffs
        brave_stuffs
        deemix_stuffs
        docky_stuffs
        dualmonitor_stuffs
        github_stuffs
        chrome_stuffs
        flameshot_stuffs
        heroku_stuffs
        hide_devices
        minidlna_stuffs
        nvidia_stuffs
        postgres_stuffs
        postman_stuffs
        python_stuffs
        reduceye_stuffs
        ruby_stuffs
        sublime_stuffs
        tmate_stuffs
        usefull_pkgs
        workspace_stuffs
        xscreensaver_stuffs
        zsh_stuffs

        echo; show "YOU SEE ONLY ONE END TO YOUR JOURNEY..."

        close_menu ;;

        *) echo -ne ${c[RED]}"\n   ${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}${c[WHITE]}\n\t\t  PLEASE, ONLY NUMBERS!\n"${c[END]}
        return_menu ;;
        # take_a_break &&

    esac
}
#======================#

#======================#
menu() {

    for (( ; ; )); do

        sleep 0.1s; show "${c[RED]}=======================================================" 1

        for line in "${(@k)logo}"; do

            show "    ${c[RED]}${(P)logo}${line}" 1 && sleep 0.1s

        done

        sleep 0.1s; show "${c[RED]}=======================================================" 1
        sleep 0.1s; show "${c[RED]}[ 00 ] ${c[WHITE]}EXIT ${e[door]}" 1
        sleep 0.1s; show "${c[RED]}[ 01 ] ${c[WHITE]}ALEXA SKILLS ${e[alexa]}" 1
        sleep 0.1s; show "${c[RED]}[ 02 ] ${c[WHITE]}BRAVE BROWSER ${e[leo]}" 1
        sleep 0.1s; show "${c[RED]}[ 03 ] ${c[WHITE]}DEEMIX ${e[headphone]}" 1
        sleep 0.1s; show "${c[RED]}[ 04 ] ${c[WHITE]}DOCKY ${e[control]}" 1
        sleep 0.1s; show "${c[RED]}[ 05 ] ${c[WHITE]}DUAL MONITOR SETUP ${e[landscape]}" 1
        sleep 0.1s; show "${c[RED]}[ 06 ] ${c[WHITE]}GIT/GITHUB ${e[octopus]}" 1
        sleep 0.1s; show "${c[RED]}[ 07 ] ${c[WHITE]}GOOGLE CHROME ${e[globe]}" 1
        sleep 0.1s; show "${c[RED]}[ 08 ] ${c[WHITE]}FLAMESHOT ${e[camera]}" 1
        sleep 0.1s; show "${c[RED]}[ 09 ] ${c[WHITE]}HEROKU ${e[rocket]}" 1
        sleep 0.1s; show "${c[RED]}[ 10 ] ${c[WHITE]}HIDE WINDOWS DEVICES (DUAL BOOT) ${e[blind_monkey]}" 1
        sleep 0.1s; show "${c[RED]}[ 11 ] ${c[WHITE]}MINIDLNA ${e[popcorn]}" 1
        sleep 0.1s; show "${c[RED]}[ 12 ] ${c[WHITE]}NVIDIA DRIVER ${e[n]}" 1
        sleep 0.1s; show "${c[RED]}[ 13 ] ${c[WHITE]}POSTGRES ${e[elephant]}" 1
        sleep 0.1s; show "${c[RED]}[ 14 ] ${c[WHITE]}POSTMAN ${e[satellite]}" 1
        sleep 0.1s; show "${c[RED]}[ 15 ] ${c[WHITE]}PYTHON ${e[snake]}" 1
        sleep 0.1s; show "${c[RED]}[ 16 ] ${c[WHITE]}REDUCE EYE STRAIN ${e[moon]}" 1
        sleep 0.1s; show "${c[RED]}[ 17 ] ${c[WHITE]}RUBY ${e[ruby]}" 1
        sleep 0.1s; show "${c[RED]}[ 18 ] ${c[WHITE]}SUBLIME TEXT ${e[letters]}" 1
        sleep 0.1s; show "${c[RED]}[ 19 ] ${c[WHITE]}TMATE ${e[magnet]}" 1
        sleep 0.1s; show "${c[RED]}[ 20 ] ${c[WHITE]}USEFULL PROGRAMS ${e[diamond]}" 1
        sleep 0.1s; show "${c[RED]}[ 21 ] ${c[WHITE]}WORKSPACE ${e[suitcase]}" 1
        sleep 0.1s; show "${c[RED]}[ 22 ] ${c[WHITE]}XSCREENSAVER ${e[screensaver]}" 1
        sleep 0.1s; show "${c[RED]}[ 23 ] ${c[WHITE]}ZSH (OH-MY-ZSH) ${e[paint]}" 1
        sleep 0.1s; show "${c[RED]}[ 24 ] ${c[WHITE]}ALL ${e[whale]}" 1
        sleep 0.1s; show "${c[RED]}=======================================================" 1

        # zsh convention, anything after a ? is used as the prompt string
        # https://superuser.com/questions/555874/zsh-read-command-fails-within-bash-function-read1-p-no-coprocess
        read -k 2 $'?\033[1;31m[    ]\033[m\033[4D' choice

        # The read command above is inline, so we need this echo to breakline
        echo

        [[ "${choice}" =~ ^[[:alpha:]]$ ]] \
            && echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}${c[WHITE]}\n\t\tPLEASE, ONLY NUMBERS!\n\n${c[WHITE]}WANT YOU RETURN SIR?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]} \
            && read trash_typed || evoke_functions "${choice}"

            [[ "${trash_typed:0:1}" =~ ^(s|S|y|Y)$ ]] && return_menu \
            || close_menu && break

    done

}
#======================#

check_source
