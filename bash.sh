#!/usr/bin/env bash

# curl --silent --output alfred.sh --create-dirs 'https://raw.githubusercontent.com/rafaelribeiroo/alfred/build/bash.sh'

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
random=$(shuf --input-range 0-$((${#name[@]}-1)) --head-count 1)

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
    [bashrc]=~/.bashrc
    [custom_gnome]=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/
    [custom_cinnamon]=/org/cinnamon/desktop/keybindings/custom-list
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

        read -p $'\033[1;37mDID U WANNA CONTINUE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                check_source

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

        show "\n${c[RED-BLINK]}PLEASE, RUNS: source alfred.sh\n" 1 && exit

    else

        if [[ ! -e "${f[update]}" ]]; then

            clear && show "\nCHECKING TOTAL OF PACKAGES TO BE UPGRADED..."

            [[ ! -e "${f[alfred]}" ]] \
                && sudo curl --silent --location --output "${f[alfred]}" --create-dirs "${l[0]}"

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

    [[ "${2}" == 'fast' ]] && return 0 || take_a_break

}
#======================#

#======================#
install_packages() {

    # $@: Trick to unpack all received values
    for package in "${@}"; do

        if check_pkg "${package}"; then

            echo && show "${c[GREEN]}${package^^} ${c[WHITE]}${linei:${#package}} [INSTALLED]"

        else

            if test "${?}" -eq 1; then

                echo && show "${c[YELLOW]}${package^^} ${c[WHITE]}${linen:${#package}} [INSTALLING]"

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

            echo && show "${c[GREEN]}${package^^} ${c[WHITE]}${linei:${#package}} [INSTALLED]"

        else

            echo && show "${c[YELLOW]}${package^^} ${c[WHITE]}${linen:${#package}} [INSTALLING]"

            python -m pip install --quiet --no-warn-script-location "${package}"

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

    [[ "${1}" -ne 1 ]] && show "${c[RED]}––––––––––––––––––––––– ${c[YELLOW]}END ${c[GREEN]}${choice} ${c[RED]}––––––––––––––––––––––––" 'fast'

}

#======================#
update() {

    # &> redirects stdout and stderr to file
    sudo apt update &> "${f[null]}"

}
#======================#

#======================#
uninstall_or_configure() {

    echo; show "${c[RED]}––––––––––––––––––– ${c[YELLOW]}YOUR CHOICE: ${c[GREEN]}${choice} ${c[RED]}–––––––––––––––––––" 'fast'

    if [[ "${1}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!"

                return 0

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        ~/.TRIGGERcmdData/  # 0
        ~/.nvm/  # 1
    )

    local -a m=(
        'triggercmdagent'  # 0
        'gawk'  # 1
        'nodejs'  # 2
        'minidlna'  # 3
        'libgconf-2-4'  # 4
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[1]}"

    source "${f[user_dirs]}"

    f+=(
        [file]=/tmp/triggercmdagent_1.0.1_amd64.deb
        [agent]=/usr/lib/triggercmdagent/resources/app/src/agent.js
        [check_token]=/tmp/check_tk
        [cmds]=~/.TRIGGERcmdData/commands.json
        [pc_id]=~/.TRIGGERcmdData/computerid.cfg
        [daemon]=/usr/lib/triggercmdagent/resources/app/src/daemon.js
        [fix-broken]=/tmp/check_libgconf
    )

    local -a l=(
        'https://s3.amazonaws.com/triggercmdagents/triggercmdagent_1.0.1_amd64.deb'  # 0
        'https://nodejs.org/en/download/releases'  # 1
        'https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh'  # 2
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"



                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n     I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        install_packages "${m[2]}" "${m[4]}"

        # lib m[4] always broken for being so old
        sudo apt update &> "${f[null]}"

        sudo apt upgrade --yes &> "${f[fix-broken]}"

        [[ ! $(grep --no-messages 'unmet dependencies' "${f[fix-broken]}") ]] \
            && sudo apt --fix-broken --yes install &> "${f[null]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[0]}"

        sudo dpkg --install "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    latest=$(curl --silent "${l[1]}" | grep --only-matching 'v[0-9]\+.[0-9]\+.[0-9]\+' | head -5 | tail -1 | sed 's|v||')

    local=$(node --version | sed 's|v||')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE NODEJS VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                [[ ! -d "${d[1]}" ]] \
                    && curl --silent --output - "${l[2]}" | bash

                [[ ! $(grep --no-messages '.nvm' "${f[bashrc]}") ]] \
                    && sudo tee "${f[bashrc]}" > "${f[null]}" <<< '
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' \
                    && source "${f[bashrc]}"

                # nvm ls-remote
                nvm install "${latest}" &> "${f[null]}"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    if [[ ! -e "${f[pc_id]}" ]]; then

        echo; show "${c[RED]}SIR${c[WHITE]}, CREATE AN ACCOUNT IN https://www.triggercmd.com/user/auth/login\nAFTER THAT, COPY TOKEN FROM ${c[RED]}INSTRUCTIONS ${c[WHITE]}PANEL AND PASTE IN GUI SCREEN" 'fast'

        ( nohup "${m[0]}" & ) &> "${f[check_token]}"

        for (( ; ; )); do

            sleep 10s

            # node /usr/lib/triggercmdagent/resources/app/src/agent.js --console
            [[ $(grep --no-messages 'Now connected' "${f[check_token]}") ]] \
                && break || show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!"

        done

    fi

    [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
        && show "\nFIRST THINGS FIRST. DO U PASS THROUGH MINIDLNA?" \
        && minidlna_stuffs

    [[ ! $(grep --no-messages 'icarus' "${f[cmds]}") ]] \
        && sudo tee "${f[cmds]}" > "${f[null]}" <<< '[
  {"trigger":"Reboot","command":"shutdown -r","ground":"background","voice":"init seis","allowParams": "false"},
  {"trigger":"Shut down","command":"shutdown -n now","ground":"background","voice":"protocolo icarus","allowParams": "false"},
  {"trigger":"MiniDLNA Restart","command":"sudo service minidlna restart && sudo service minidlna force-reload","ground":"background","voice":"init tres","allowParams": "false"}
]'

    # ( nohup node "${f[daemon]}" --run "${d[0]}" & ) &> "${f[null]}"

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
bash_stuffs() {

    source "${f[user_dirs]}"

    local -a d=(
        ~/.oh-my-bash  # 0
        ~/.fonts/  # 1
        ~/.config/fontconfig/conf.d  # 2
        "${XDG_DOWNLOAD_DIR}"/ble.sh  # 3
        ~/.local  # 4
        ~/.local/share/blesh  # 5
    )

    f+=(
        [powerline_otf]=~/.fonts/PowerlineSymbols.otf
        [powerline_conf]=~/.config/fontconfig/conf.d/10-powerline-symbols.conf
        [original]=/etc/skel/.bashrc
        [bkp_bash]=~/.bashrc_bkp
        [config]=~/.oh-my-bash/oh-my-bash.sh
        [bkp]=~/.bashrc.pre-oh-my-bash
        [ble]=~/.local/share/blesh/ble.sh
        [blerc]=~/.blerc
    )

    local -a l=(
        'https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh'  # 0
        'https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf'  # 1
        'https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf'  # 2
        'https://github.com/akinomyoga/ble.sh.git'  # 3
    )

    local -a m=(
        'oh-my-bash'  # 0
        'xdotool'  # 1
        'ble.sh'  # 2
        'git'  # 3
    )

    if [[ -d "${d[0]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                # sudo apt remove --purge --yes "${m[3]}" &> "${f[null]}"

                # --force: ignore nonexistent files, never prompt
                # --recursive: remove directories
                sudo rm --force --recursive "${d[0]}" "${d[5]}"

                sudo rm --force "${f[blerc]}"

                cp "${f[bashrc]}" "${f[bkp_bash]}" &> "${f[null]}"

                sudo rm --force "${f[powerline_otf]}" "${f[powerline_conf]}" "${f[bashrc]}" "${f[blerc]}"

                # Could be mv "${f[bkp]}" "${f[bashrc]}", but if user format
                # disk and maintain home intact, returns error
                # mv "${f[bkp]}" "${f[bashrc]}"

                cp "${f[original]}" "${f[bashrc]}" &> "${f[null]}"

                source "${f[bashrc]}"

                # remove_useless

                show "PLEASE, RESTART YOUR TERMINAL TO APPLY CHANGES\n"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        install_packages "${m[1]}" "${m[3]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        # First /dev/null hide download progress, second hide thirty commands
        0> "${f[null]}" sh -c "$(curl --silent --show-error --fail --location ${l[0]})" &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[powerline_otf]}" ]]; then

        # Hidden directories are owned by root, we must change owner to bash "read"
        # 2>&- hides: "can't stat: no such file..."
        [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}" # Close error output

        # --location follows to last URL (github provides a few redirects)
        # --output write content to file
        curl --silent --location --output "${f[powerline_otf]}" --create-dirs "${l[1]}"

        # Update font cache
        sudo fc-cache --force "${d[1]}"

    fi

    if [[ ! -e "${f[powerline_conf]}" ]]; then

        [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]%conf.d}"

        curl --silent --location --output "${f[powerline_conf]}" --create-dirs "${l[2]}"

        # Workaround to prevent terminal restart
        xdotool key Ctrl+plus && xdotool key Ctrl+minus

    fi

    # If show error when open oh-my-base, run command below
    # [[ $(grep --no-messages "check_for_upgrade.sh" "${f[config]}") ]] \
    #     && sudo sed --in-place --null-data 's|if \[ "$DISABLE_AUTO_UPDATE" != "true" \]; then\n  env OSH=$OSH DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT bash -f $OSH/tools/check_for_upgrade.sh\nfi||g' "${f[config]}"

    [[ ! $(grep --no-messages DEFAULT_USER "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
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
        && sudo sed --in-place 's|echo "\${c\[W|echo \\"${c[W|g' "${f[bashrc]}" \
        && sudo sed --in-place 's|\[END]}"|[END]}\\"|g' "${f[bashrc]}" \
        && source "${f[bashrc]}"

    sudo sed --in-place 's|font|agnoster|g' "${f[bashrc]}"

    [[ ! $(grep --no-messages 'plugins=(git' "${f[bashrc]}") ]] \
        && sudo sed --in-place --null-data 's|plugins=(\n  git\n  bashmarks\n)|plugins=(git python pip virtualenv)|g' "${f[bashrc]}"

    echo; read -p $'\033[1;37mSIR, SHOULD I INSTALL AUTOCOMPLETE LIKE IN OH-MY-ZSH? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            if [[ ! -e "${f[ble]}" ]]; then

                [[ ! -d "${d[3]}" ]] \
                    && show "\n${c[YELLOW]}${d[2]^^} ${c[WHITE]}${linen:${#d[2]}} [INSTALLING]" \
                    && git clone --quiet "${l[3]}" "${d[3]}"

                sudo make --quiet --directory="${d[3]}" --prefix="${d[4]}" install

                sudo rm --force --recursive "${d[3]}"

            else

                show "\n${c[GREEN]}${d[2]^^} ${c[WHITE]}${linei:${#d[2]}} [INSTALLED]"

            fi

            [[ ! $(grep --no-messages Bash-complete "${f[bashrc]}") ]] \
                && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
# Bash-complete
source ${f[ble]}"

            # Load changes
            source "${f[bashrc]}" &> "${f[null]}"

            [[ ! $(grep --no-messages menu-complete "${f[blerc]}") ]] \
                && sudo tee "${f[blerc]}" > "${f[null]}" <<< "bind 'TAB: menu-complete'
bind 'set show-all-if-ambiguous on'
bind 'set completion-ignore-case on'
bind 'set menu-complete-display-prefix on'
bind 'set completion-ignore-case on'

# Hide [ble: exit ???] that appears on each command
bleopt exec_errexit_mark=''

ble-color-setface auto_complete italic
ble-color-setface argument_option none
ble-color-setface disabled none
ble-color-setface region_insert none
ble-color-setface syntax_history_expansion none
ble-color-setface region_match none

ble-color-setface varname_number none
ble-color-setface varname_unset none
ble-color-setface varname_export none
ble-color-setface varname_array none

ble-color-setface filename_character none
ble-color-setface filename_directory_sticky none
ble-color-setface filename_directory none
ble-color-setface filename_executable none
ble-color-setface filename_other none
ble-color-setface filename_url underline

ble-color-setface command_alias none
ble-color-setface command_directory none
ble-color-setface command_builtin none
ble-color-setface command_builtin_dot none
ble-color-setface command_file none
ble-color-setface command_keyword none
ble-color-setface command_function none

ble-color-setface syntax_glob none
ble-color-setface syntax_brace none
ble-color-setface syntax_command none
ble-color-setface syntax_tilde none
ble-color-setface syntax_comment none
ble-color-setface syntax_error none
ble-color-setface syntax_expr none
ble-color-setface syntax_function_name none
ble-color-setface syntax_param_expansion none
ble-color-setface syntax_delimiter none
ble-color-setface syntax_quotation none
ble-color-setface syntax_quoted none
ble-color-setface syntax_varname none"

            # Load changes
            source "${f[blerc]}" &> "${f[null]}"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL AUTOCOMPLETE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
brave_stuffs() {

    local -a d=(
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org/  # 0
        /opt/brave.com/  # 1
        ~/.config/BraveSoftware/  # 2
        ~/.cache/BraveSoftware/  # 3
    )

    f+=(
        [gpg]=/etc/apt/trusted.gpg.d/brave-browser-release.gpg
        [ppa]=/etc/apt/sources.list.d/brave-browser-release.list
        [exe_1]=/usr/bin/brave-browser
        [exe_2]=/usr/bin/brave-browser-stable
    )

    local -a l=(
        'https://brave-browser-apt-release.s3.brave.com/brave-core.asc'  # 0
        'https://brave-browser-apt-release.s3.brave.com/'  # 1
    )

    local -a m=(
        'brave-browser'  # 0
        'apt-transport-https'  # 1
        'curl'  # 2
        'gnupg'  # 3
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                remove_useless

                sudo sed --in-place '/brave/d' "${d[0]}"*.json

                sudo sed --in-place '/brave/d' "${f[mimeapps]}"

                sudo rm --force --recursive "${d[1]}" "${d[2]}" "${d[3]}"

                sudo rm --force "${f[exe_1]}" "${f[exe_2]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep brave) ]] \
            && curl --silent "${l[0]}" | sudo apt-key --keyring "${f[gpg]}" add - &> "${f[null]}"

        [[ ! -e "${f[ppa]}" ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb [arch=amd64] ${l[1]} stable main" \
            && update

        # Dependencies
        install_packages "${m[1]}" "${m[2]}" "${m[3]}" "${m[0]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    echo; read -p $'\033[1;37mSIR, SHOULD I OPEN BRAVE? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            ( nohup "${m[0]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

    source "${f[user_dirs]}"

    local -a d=(
        /tmp/  # 0
        ~/Musicas\ Deemix/  # 1
        ~/.cache/thumbnails/fail  # 2
        ~/.config/deemix/  # 3
        ~/.config/deemix-gui/  # 4
    )

    f+=(
        [file]="${d[0]}"linux-x86_64-latest.deb
        [decrypt]=/etc/browser_cookie3_n.py
        [clear_garbage]=/etc/clear_garbage.sh
        [cookies]="${d[0]}"cookies
        [arl_value]="${d[3]}".arl
        [cfg]="${d[3]}"config.json
        [flac]=/usr/share/thumbnailers/ffmpegthumbnailer.thumbnailer
    )

    local -a l=(
        'https://download.deemix.workers.dev/gui/linux-x64-latest.deb'  # 0
        'https://raw.githubusercontent.com/rachpt/lanzou-gui/master/lanzou/browser_cookie3_n.py'  # 1
    )

    local -a m=(
        'deemix-gui'  # 0
        'xplayer'  # 1
        'certifi'  # 2
        'cffi'  # 3
        'chardet'  # 4
        'cryptography'  # 5
        'idna'  # 6
        'jeepney'  # 7
        'keyring'  # 8
        'lz4'  # 9
        'pbkdf2'  # 10
        'pyaes'  # 11
        'pycparser'  # 12
        'pycryptodome'  # 13
        'PyQt5'  # 14
        'PyQt5-sip'  # 15
        'PyQtWebEngine'  # 16
        'requests'  # 17
        'requests-toolbelt'  # 18
        'SecretStorage'  # 19
        'six'  # 20
        'urllib3'  # 21
        'lanzou-gui'  # 22
        'google-chrome-stable'  # 23
        'xsel'  # 24
        'gawk'  # 25
        'python-is-python3'  # 26
        'wheel'  # 27
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[25]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, WE MUST INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[25]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[24]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" "${m[1]}" "${m[24]}" &> "${f[null]}"

                remove_useless

                pip uninstall --quiet "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}" "${m[18]}" "${m[19]}" "${m[20]}" "${m[21]}"

                sudo rm --force --recursive "${d[3]}" "${d[4]}"

                sudo rm --force "${f[decrypt]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" =~ @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        # Dependencies
        install_packages "${m[0]}" "${m[1]}" "${m[24]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[0]}"

        sudo dpkg --install "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

        [[ ! $(dpkg --list | awk "/ii  ${m[26]}[[:space:]]/ {print }") ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH PYTHON?" \
            && python_stuffs

        echo; show "SIR, BEFORE PROCEED WE NEED TO GET YOUR ARL..."

        show "${c[GREEN]}\n        I${c[WHITE]}NSTALLING ${c[GREEN]}${m[22]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        install_pip "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[27]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}" "${m[18]}" "${m[19]}" "${m[20]}" "${m[21]}"

        if [[ ! -e "${f[decrypt]}" ]]; then

            show "\n${c[YELLOW]}${m[22]^^} ${c[WHITE]}${linen:${#m[22]}} [INSTALLING]"

            sudo wget --quiet "${l[1]}" --output-document "${f[decrypt]}"

        else

            show "\n${c[GREEN]}${m[22]^^} ${c[WHITE]}${linei:${#m[22]}} [INSTALLED]"

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ ! $(dpkg --list | awk "/ii  ${m[23]}[[:space:]]/ {print }") ]] \
        && show "\nFIRST THINGS FIRST. DO U PASS THROUGH CHROME?" \
        && chrome_stuffs

    while [[ ! -d "${d[3]}" ]]; do

        show "\nRESTARTING DEEMIX TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[0]}" & ) &> "${f[null]}"

        take_a_break

        sudo pkill "${m[0]}"

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

    [[ ! -e "${f[clear_garbage]}" ]] \
        && sudo tee "${f[clear_garbage]}" > "${f[null]}" <<< "#!/usr/bin/env bash

rename 's/^(Dj|dj|mc|Mc)/\U$1/' ${XDG_MUSIC_DIR}/* && rename 's|Ac_dc|ACDC|g' ${XDG_MUSIC_DIR}/* && find ${XDG_MUSIC_DIR}/ -type f -regex '.*\.mp3\|.*\.flac\|.*\.lrc' -exec rename 's/ \(.*\)//' {} \;"

    [[ $(stat --format='%a' "${f[clear_garbage]}") -ne 755 ]] \
        && sudo chmod 755 "${f[clear_garbage]}"

    [[ ! $(grep --no-messages 'autoCheckForUpdates' "${f[cfg]}") ]] \
        && sudo sed --in-place --null-data 's|}|},\n  "autoCheckForUpdates": true|1' "${f[cfg]}"

    sudo sed --in-place "s|\"downloadLocation\".*|\"downloadLocation\": \"${XDG_MUSIC_DIR}\",|g" "${f[cfg]}"

    sudo sed --in-place 's|"saveArtwork":.*|"saveArtwork": false,|g' "${f[cfg]}"

    sudo sed --in-place 's|"explicit":.*|"explicit": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"syncedLyrics":.*|"syncedLyrics": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"queueConcurrency":.*|"queueConcurrency": 50,|g' "${f[cfg]}"

    # MP3 320KBPS SET TO 3, FLAC 9
    sudo sed --in-place 's|"maxBitrate":.*|"maxBitrate": "3",|g' "${f[cfg]}"

    sudo sed --in-place 's|"playlistTracknameTemplate":.*|"playlistTracknameTemplate": "%artist% - %title%",|g' "${f[cfg]}"

    sudo sed --in-place 's|"titleCasing":.*|"titleCasing": "start",|g' "${f[cfg]}"

    sudo sed --in-place 's|"syncedLyrics":.*|"syncedLyrics": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"artistCasing":.*|"artistCasing": "start",|g' "${f[cfg]}"

    sudo sed --in-place 's|"featuredToTitle":.*|"featuredToTitle": "1",|g' "${f[cfg]}"

    sudo sed --in-place 's|"removeAlbumVersion":.*|"removeAlbumVersion": true,|g' "${f[cfg]}"

    sudo sed --in-place "s|\"executeCommand\":.*|\"executeCommand\": \"${f[clear_garbage]}\",|g" "${f[cfg]}"

    [[ ! $(grep --no-messages 'flac' "${f[flac]}") ]] \
        && sudo sed --in-place --regexp-extended 's|(MimeType.*$)|\1;audio/flac;audio/mpeg|g' "${f[flac]}"

    # In pt_BR language, deemix not recognizes ú from Músicas.
    if [[ $(echo "${LANG}" | awk --field-separator=. '{print $1}') = 'pt_BR' ]]; then

        [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

        sudo sed --in-place "s|\"downloadLocation\": \"${XDG_MUSIC_DIR}/deemix Music/\",|\"downloadLocation\": \"${d[1]}\",|g" "${f[cfg]}"

    fi

    [[ ! $(grep --no-messages '"albumTracknameTemplate": "%artist% - %title%"' "${f[cfg]}") ]] \
        && sudo sed --in-place 's|"albumTracknameTemplate": "%tracknumber% - %title%",|"albumTracknameTemplate": "%artist% - %title%",|g' "${f[cfg]}"

    [[ ! $(grep --no-messages 'alias ct' "${f[zshrc]}") ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
alias ct='rm --recursive --force ${d[2]}'"

    [[ -e "${f[file]}" ]] \
        && sudo rm --force "${f[file]}"

    curl --silent --location --output "${f[file]}" --create-dirs "${l[0]}"

    latest=$(dpkg-deb --info "${f[file]}" | grep 'Version' | awk '{print $2}')

    local=$(apt version "${m[0]}")

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE DEEMIX-GUI VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                sudo dpkg --install "${f[file]}" &> "${f[null]}"

                sudo rm --force "${f[file]}"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    if [[ ! -e "${f[arl_value]}" ]]; then

        echo; read -p $'\033[1;37mSIR, SHOULD I OPEN DEEMIX? (CLIPBOARD CONTAINS ARL) \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ @(s|S|y|Y) ]] ; then

                ( nohup "${m[0]}" & ) &> "${f[null]}"

                break

            elif [[ "${option:0:1}" =~ @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
docky_stuffs() {

    local -a d=(
        /tmp/  # 0
        ~/.local/share/cinnamon/applets/  # 1
        ~/.local/share/cinnamon/applets/separator2@zyzz  # 2
        ~/.local/share/cinnamon/applets/force-quit@cinnamon.org  # 3
        ~/.cinnamon/configs/calendar@cinnamon.org  # 4
    )

    local -a m=(
        'libgconf2.0-cil'  # 0
        'multiarch-support'  # 1
        'libgnome-keyring-common'  # 2
        'libgnome-keyring0:amd64'  # 3
        'libgnome-keyring1.0-cil'  # 4
        'docky'  # 5
        'gconf-editor'  # 6
        'brave-browser'  # 7
        'sublime-text'  # 8
        'telegram-desktop'  # 9
        'dconf-editor'  # 10
        'gconf-defaults-service'  # 11
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
        'http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-sharp2/libgconf2.0-cil_2.24.2-4_all.deb'  # 0
        'http://archive.ubuntu.com/ubuntu/pool/main/g/glibc/multiarch-support_2.27-3ubuntu1_amd64.deb'  # 1
        'http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring-common_3.12.0-1build1_all.deb'  # 2
        'http://archive.ubuntu.com/ubuntu/pool/universe/libg/libgnome-keyring/libgnome-keyring0_3.12.0-1build1_amd64.deb'  # 3
        'http://archive.ubuntu.com/ubuntu/pool/universe/g/gnome-keyring-sharp/libgnome-keyring1.0-cil_1.0.0-5_amd64.deb'  # 4
        'http://archive.ubuntu.com/ubuntu/pool/universe/d/docky/docky_2.2.1.1-1_all.deb'  # 5
        'https://cinnamon-spices.linuxmint.com/files/applets/separator2@zyzz.zip'  # 6
        'https://cinnamon-spices.linuxmint.com/files/applets/force-quit@cinnamon.org.zip'  # 7
        'http://ftp.de.debian.org/debian/pool/main/g/gconf-editor/gconf-editor_3.0.1-6_amd64.deb'  # 8
    )

    if [[ $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[5]^^} ${c[WHITE]}${linei:${#m[5]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[5]^^}${c[WHITE]}!\n"





                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[5]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        # Dependencies
        if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]]; then

            install_packages "${m[10]}" "${m[11]}"

            [[ $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[6]^^} ${c[WHITE]}${linei:${#m[6]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[6]^^} ${c[WHITE]}${linen:${#m[6]}} [INSTALLING]" \
                && sudo wget --quiet "${l[8]}" --output-document "${f[gconf_d]}" \
                && sudo dpkg --install "${f[gconf_d]}" &> "${f[null]}"

        fi

        for (( iterador=0; iterador<=4; iterador++ )); do

            [[ $(dpkg --list | awk "/ii  ${m[iterator]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[iterador]^^} ${c[WHITE]}${linei:${#m[iterador]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[iterador]^^} ${c[WHITE]}${linen:${#m[iterador]}} [INSTALLING]" \
                && sudo wget --quiet "${l[iterator]}" --output-document "${f[dep$iterator]}" \
                && sudo dpkg --install "${f[dep$iterator]}" &> "${f[null]}"

        done

        unset iterador

        [[ ! -e "${f[docky_run]}" ]] \
            && show "\n${c[YELLOW]}${m[5]^^} ${c[WHITE]}${linen:${#m[5]}} [INSTALLING]" \
            && sudo wget --quiet "${l[5]}" --output-document "${f[docky_run]}"

        sudo dpkg --install "${f[docky_run]}" &> "${f[null]}"

        sudo apt --fix-broken --yes install &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    f+=(
        [get_dock]=/apps/docky-2/Docky/DockController/ActiveDocks
    )

    while [[ ! -d "${d[5]}" ]]; do

        show "\nRESTARTING DOCKY TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[5]}" & ) &> "${f[null]}"

        sleep 10s

        get_dock=$(gconftool --get "${f[get_dock]}" | sed 's/[][]//g')

        d+=(
           ~/.gconf/apps/docky-2/Docky/Interface/DockPreferences/"${get_dock}"  # 5
        )

        sudo pkill "${m[5]}"

        take_a_break

    done

    f+=(
        [pref]=/apps/docky-2/Docky/Interface/DockPreferences/"${get_dock}"/
    )

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
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
    if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]]; then

        [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != "${USER}" ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

        [[ ! -e "${f[separator2]}" && ! -d "${d[2]}" ]] \
            && wget --quiet "${l[6]}" --output-document "${f[separator2]}" \
            && unzip "${f[separator2]}" -d "${d[1]}" &> "${f[null]}" \
            && sudo rm --force "${f[separator2]}"

        [[ ! -e "${f[forceqt]}" && ! -d "${d[3]}" ]] \
            && wget --quiet "${l[7]}" --output-document "${f[forceqt]}" \
            && unzip "${f[forceqt]}" -d "${d[1]}" &> "${f[null]}" \
            && sudo rm --force "${f[forceqt]}"

        dconf write "${f[enabled_applets]}" "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:show-desktop@cinnamon.org:1', 'panel1:left:2:grouped-window-list@cinnamon.org:2', 'panel1:right:3:removable-drives@cinnamon.org:3', 'panel1:right:4:separator@cinnamon.org:4', 'panel1:right:5:separator@cinnamon.org:5', 'panel1:right:6:notifications@cinnamon.org:6', 'panel1:right:7:keyboard@cinnamon.org:7', 'panel1:right:8:separator@cinnamon.org:8', 'panel1:right:9:separator@cinnamon.org:9', 'panel1:right:10:force-quit@cinnamon.org:10', 'panel1:right:11:separator@cinnamon.org:11', 'panel1:right:12:separator@cinnamon.org:12', 'panel1:right:13:xapp-status@cinnamon.org:13', 'panel1:right:14:separator@cinnamon.org:14', 'panel1:right:15:separator@cinnamon.org:15', 'panel1:right:16:network@cinnamon.org:16', 'panel1:right:17:separator2@zyzz:17', 'panel1:right:18:calendar@cinnamon.org:18']"

        take_a_break

        f+=(
            [calendar]=~/.cinnamon/configs/calendar@cinnamon.org/$(find "${d[4]}" -maxdepth 1 -type f | awk --field-separator=/ '{print $7}')
        )

        # use custom format
        sudo sed --in-place --null-data 's|false|true|3' "${f[calendar]}"

        sudo sed --in-place --null-data 's|false|true|4' "${f[calendar]}"

        sudo sed --in-place --null-data 's|%A, %B %e, %H:%M|%e.  %B, %H:%M|2' "${f[calendar]}"

    fi

    # Order icons at grouped-windows-list
    if [[ ! $(sed --quiet '/"pinned-apps":/,/]/p' "${f[grouped]}" | grep sublime_text) && "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]]; then

        [[ ! $(dpkg --list | awk "/ii  ${m[7]}[[:space:]]/ {print }") ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH BRAVE BROWSER?" \
            && brave_stuffs

        [[ ! $(dpkg --list | awk "/ii  ${m[8]}[[:space:]]/ {print }") ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH SUBLIME TEXT?" \
            && sublime_stuffs

        [[ ! $(dpkg --list | awk "/ii  ${m[9]}[[:space:]]/ {print }") ]] \
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
        /usr/share/backgrounds/customized/  # 0
        ~/.var/app/es.estoes.wallpaperDownloader/  # 1
        ~/.wallpaperdownloader/downloads/  # 2
        ~/.wallpaperdownloader/  # 3
        ~/.config/autostart/  # 4
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
        [bkg_1]="${d[2]}"sw.jpg
        [config]="${d[3]}"config.txt
        [dskt]="${d[4]}"wallpaperdownloader.desktop
        [older]="${d[3]}"wallpaperdownloader.desktop
    )

    # 3840x1080 wallpaper
    local -a l=(
        'http://ftp.de.debian.org/debian/pool/main/g/glew/libglew2.1_2.1.0-4+b1_amd64.deb'  # 0
        'https://launchpad.net/~fyrmir/+archive/ubuntu/livewallpaper-daily/+files/livewallpaper_0.5.0-0~333~ubuntu20.04.1_amd64.deb'  # 1
        'https://launchpad.net/~fyrmir/+archive/ubuntu/livewallpaper-daily/+files/livewallpaper-indicator_0.5.0-0~333~ubuntu20.04.1_amd64.deb'  # 2
        'https://launchpad.net/~fyrmir/+archive/ubuntu/livewallpaper-daily/+files/livewallpaper-config_0.5.0-0~333~ubuntu20.04.1_amd64.deb'  # 3
        'https://flathub.org/repo/flathub.flatpakrepo' # 4
        'https://images3.alphacoders.com/673/673177.jpg'  # 5
    )

    local -a m=(
        'wallpapers'  # 0
        'dconf-editor'  # 1
        'python3-opengl'  # 2
        'libglew2.1'  # 3
        'livewallpaper'  # 4
        'livewallpaper-indicator'  # 5
        'livewallpaper-config'  # 6
        'wallpaperDownloader'  # 7
        'flatpak'  # 8
        'flathub'  # 9
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && -e "${d[0]}" ]]; then
        # 2>&- if dconf not installed

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linec:${#m[0]}} [APPLIED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NSETTING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo rm --force --recursive "${d[0]}"

                sudo rm --force "${f[src]}"

                dconf write "${f[picture]}" "'${f[default]}'"

                dconf write "${f[option]}" "'zoom'"

                dconf write "${f[slideshow]}" false

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  S${c[WHITE]}ETING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        install_packages "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # --word-regexp don't match with disconnected
    # dual monitor wallpaper

    echo; read -p $'\033[1;37mSIR, DO YOU PREFER ANIMATED WALLPAPER OVER STATIC? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[4]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

            install_packages "${m[2]}"

            [[ $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[3]:u} ${c[WHITE]}${linei:${#m[3]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[3]:u} ${c[WHITE]}${linen:${#m[3]}} [INSTALLING]" \
                && sudo wget --quiet "${l[0]}" --output-document "${f[libglew]}" \
                && sudo dpkg --install "${f[libglew]}" &> "${f[null]}"

            [[ $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[4]:u} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[4]:u} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                && sudo wget --quiet "${l[1]}" --output-document "${f[lw]}" \
                && sudo dpkg --install "${f[lw]}" &> "${f[null]}"

            [[ $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[5]:u} ${c[WHITE]}${linei:${#m[5]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[5]:u} ${c[WHITE]}${linen:${#m[5]}} [INSTALLING]" \
                && sudo wget --quiet "${l[2]}" --output-document "${f[lw_indicator]}" \
                && sudo dpkg --install "${f[lw_indicator]}" &> "${f[null]}"

            [[ $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") ]] \
                && show "\n${c[GREEN]}${m[6]:u} ${c[WHITE]}${linei:${#m[6]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[6]:u} ${c[WHITE]}${linen:${#m[6]}} [INSTALLING]" \
                && sudo wget --quiet "${l[3]}" --output-document "${f[lw_cfg]}" \
                && sudo dpkg --install "${f[lw_cfg]}" &> "${f[null]}"

            echo; read -p $'\033[1;37mSIR, SHOULD I OPEN LIVE WALLPAPER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    ( nohup "${m[6]}" & ) &> "${f[null]}"

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            if [[ $(xrandr --query | grep --count --word-regexp connected) -eq 2 ]] ; then

                if [[ ! $(sudo flatpak list 2>&- | grep --no-messages "${m[7]}") ]]; then

                    if [[ ! $(sudo flatpak remotes 2>&- | grep --no-messages "${m[9]}") ]]; then

                        sudo flatpak remote-add "${m[9]}" "${l[4]}"  # --if-not-exists

                        echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                        for (( ; ; )); do

                            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                                sudo reboot

                            elif [[ "${option:0:1}" = @(n|N) ]] ; then

                                break

                            else

                                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                                read option

                            fi

                        done

                    fi

                    show "\n${c[YELLOW]}${m[7]^^} ${c[WHITE]}${linen:${#m[7]}} [INSTALLING]"

                    flatpak install --assumeyes "${m[9]}" "${f[pkg]}" &> "${f[null]}"

                fi

                while [[ ! -d "${d[3]}" ]]; do

                    show "\nRESTARTING WALLPAPER DOWNLOADER TO GENERATE CONFIG FILES.\nWAIT..."

                    ( flatpak run "${f[pkg]}" & ) &> "${f[null]}"

                    take_a_break

                    flatpak kill "${f[pkg]}"

                    take_a_break

                done

                [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != "${USER}" ]] \
                    && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
                    && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
                    && sudo chown "${USER}":"${USER}" "${d[2]}"

                [[ ! -e "${f[bkg_1]}" ]] \
                    && curl --silent --output "${f[bkg_1]}" --create-dirs "${l[5]}"

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

                [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
                    && dconf write "${f[picture_gnome]}" "'file://${f[bkg_1]}'" \
                    && dconf write "${f[option_gnome]}" "'spanned'"

                [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
                    && dconf write "${f[picture]}" "'file://${f[bkg_1]}'" \
                    && dconf write "${f[option]}" "'spanned'" \
                    && dconf write "${f[slideshow]}" true \
                    && dconf write "${f[source]}" "'directory://${d[2]}'" \
                    && dconf write "${f[delay]}" 15

            else

                show "\nYOU DON'T HAVE DUAL MONITOR SETUP. EXITING..."

            fi

            break

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
        'https://api.github.com/user/keys'  # 0
        'https://git-scm.com/'  # 1
        'keyserver.ubuntu.com'  # 2
        'https://cli.github.com/packages'  # 3
        'https://api.github.com/rate_limit'  # 4
        'hkp://keyserver.ubuntu.com:80'  # 5
        'https://git-cola.github.io/downloads.html'  # 6
    )

    local -a d=(
        /tmp/  # 0
    )

    f+=(
        [config]=~/.gitconfig
        [config-ssh]=~/.ssh/config
        [tmp_success]="${d[0]}"check_success
        [all_title_gh]="${d[0]}"all_title
        [cola_new]=/usr/bin/cola
        [bearer]=~/.config/gh/hosts.yml
    )

    local -a m=(
        'git'  # 0
        'vim'  # 1
        'git-cola'  # 2
        'jq'  # 3
        'systemd'  # 4
        'dconf-editor'  # 5
        'gh'  # 6
        'python-is-python3'  # 7
        'gawk'  # 8
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") \
        && ! $(dpkg --list | awk "/ii  ${m[8]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[4]}" "${m[8]}"

    # We put ii  <pkg>[[:space:]] to get only what we need, git shows in more places (in version by the way)
    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") && \
        $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" "${m[2]}" "${m[3]}" &> "${f[null]}"

                sudo rm --force "${f[config]}"

                [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep "${m[0]}") ]] \
                    && sudo add-apt-repository --remove --yes ppa:git-core/ppa &> "${f[null]}"

                sudo sed --in-place --null-data 's|Host github.com\nHostname ssh.github.com\nPort 443||g' "${f[config-ssh]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        echo; read -p $'\033[1;37mSIR, ARE U OVER VPN? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                [[ ! $(sudo apt-key list 2> /dev/null | grep 'Nate Smith') ]] \
                    && sudo apt-key adv --keyserver "${l[5]}" --recv-key C99B11DEB97541F0 &> "${f[null]}"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                [[ ! $(sudo apt-key list 2> /dev/null | grep 'Nate Smith') ]] \
                    && sudo apt-key adv --keyserver "${l[2]}" --recv-key C99B11DEB97541F0 &> "${f[null]}"

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE U BEYOND VPN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

        if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]]; then

            [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep "${l[4]}") ]] \
                && sudo add-apt-repository --yes "${l[4]}" &> "${f[null]}" \
                && update

        fi

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[5]}" "${m[6]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    latest=$(curl --silent "${l[6]}"| grep --max-count=1 'v[0-9]' | sed --expression 's|<[^>]*>||g' | sed 's|v||' | xargs)

    local=$(cola --version | awk '{print $3}')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE COLA VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                [[ ! $(dpkg --list | awk "/ii  ${m[7]}[[:space:]]/ {print }") ]] \
                    && show "\nFIRST THINGS FIRST. DO U PASS THROUGH PYTHON?" \
                    && python_stuffs

                pip install --quiet --no-warn-script-location "${m[2]}"=="${latest}"

                sudo ln --force --symbolic "$(which ${m[2]})" "${f[cola_new]}"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        && read -p $'\033[1;37m\nENTER YOUR EMAIL, '"${name[random]}"$': \033[m' email \
        && read -p $'\033[1;37mNAME '"${e[silent_monkey]}"$': \033[m' nome \
        && git config --global user.email "${email}" \
        && git config --global user.name "${nome}" \
        && git config --global core.editor "vim" \
        && git config --global http.sslVerify false \
        && git config --global core.quotepath off  # Recognizes UTF-8

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
        && [[ $(dconf dump / | grep 'gtk-theme' | awk --field-separator='=' '{print $2}' | sed "s|'||g") =~ .*dark.* ]] \
            && git config --global cola.icontheme dark \
            && git config --global cola.theme flat-dark-green

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && [[ $(dconf dump / | grep 'gtk-theme' | awk --field-separator='=' '{print $2}' | sed "s|'||g") =~ .*Dark.* ]] \
            && git config --global cola.icontheme dark \
            && git config --global cola.theme flat-dark-green

    local=$(git --version | awk '{print $3}')

    latest=$(curl --silent "${l[1]}" | grep --after-context=1 '"version"' | tail -1 | xargs)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep git-core) ]] \
            && sudo add-apt-repository --yes ppa:git-core/ppa &> "${f[null]}"

        update && sudo apt install --assume-yes "${m[0]}" &> "${f[null]}"

        sudo add-apt-repository --remove --yes ppa:git-core/ppa &> "${f[null]}"

    fi

    check_ssh

    [[ ! $(grep --no-messages github "${f[config-ssh]}") ]] \
        && sudo tee --append "${f[config-ssh]}" > "${f[null]}" <<< 'Host github.com
    Hostname ssh.github.com
    Port 443'

    echo; read -p $'\033[1;37mENTER YOUR USERNAME FROM GITHUB: \033[m' user

    # GITHUB STUFF
    for (( ; ; )); do

        echo; show "${c[RED]}${user^^}${c[WHITE]}, PLEASE CREATE A TOKEN IN https://github.com/settings/tokens\nPLEASE, ENABLE ${c[RED]}REPO/ADMIN:ORG/ADMIN:PUBLIC_KEY" 'fast'

        echo; read -p $'\033[1;37mPASTE HERE YOUR TOKEN: \033[m' token

        [[ ! -e ${f[bearer]} ]] \
            && sudo tee "${f[tmp_tk]}" > "${f[null]}" <<< "${token}" \
            && gh auth login --with-token < "${f[tmp_tk]}" &> "${f[tmp_success]}"

        # let --ignore-case as below, api github always changing sensitive case
        # best way to grep AND
        [[ \
            $(curl --silent --head --header "Authorization: token $(cat ${f[tmp_tk]})" "${l[0]}" | grep --extended-regexp --ignore-case '^x-oauth-scopes' | grep 'admin:org' | grep 'admin:public_key' | grep 'repo') &&
            ! -z "${f[tmp_success]}" \
        ]] \
            && break || show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" 'fast'
        # if file is empty, is 200 OK

    done

    source "${f[os_release]}"

    # -z for empty not works, github api was changes, if empty: [ ] (3 line)
    if [[ $(curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" "${l[0]}" | wc --lines) -eq 3 ]]; then

        curl --silent --include --user "${user}":"$(cat ${f[tmp_tk]})" --data '{"title": "Sent from my '"${NAME//Linux/}"'", "key": "'"$(cat ${f[public_ssh]})"'"}' "${l[0]}" &> "${f[null]}"

    else

        install_packages "${m[3]}"

        # https://developer.github.com/changes/2020-02-14-deprecating-password-auth/
        curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" "${l[0]}" | jq --raw-output ".[] | .title"  &> "${f[all_title_gh]}"

        if [[ $(grep --no-messages "Sent from my ${NAME//Linux/}" "${f[all_title_gh]}") ]]; then

            echo; read -p $'\033[1;37mSIR, SHOULD I REPLACE YOUR SSH ON GITHUB? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    old_ssh_id=$(curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" "${l[0]}" | jq --raw-output ".[] | .id, .title" | grep --before-context=1 "Sent from my ${NAME//Linux/}" | head -1)

                    curl --silent --user "${user}":"$(cat ${f[tmp_tk]})" --request DELETE "${l[0]}"/"${old_ssh_id}"

                    curl --silent --include --user "${user}":"$(cat ${f[tmp_tk]})" --data '{"title": "Sent from my '"${NAME//Linux/}"'", "key": "'"$(cat ${f[public_ssh]})"'"}' "${l[0]}" &> "${f[null]}"

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I REPLACE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            curl --silent --include --user "${user}":"$(cat ${f[tmp_tk]})" --data '{"title": "Sent from my '"${NAME//Linux/}"'", "key": "'"$(cat ${f[public_ssh]})"'"}' "${l[0]}" &> "${f[null]}"

        fi

    fi

    [[ ! $(grep --no-messages 'alias sent' "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
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
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org/  # 0
        ~/.config/google-chrome/  # 1
    )

    local -a m=(
        'google-chrome-stable'  # 0
        'libappindicator1'  # 1
        'libindicator7'  # 2
        'libxss1'  # 3
        'gawk'  # 4
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[4]}"

    f+=(
        [file]=/tmp/google-chrome-stable_current_amd64.deb
        [garbage]=/etc/default/google-chrome
    )

    local -a l=(
        'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'  # 0
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                # Only libappindicator1 doesn't come default in debian distros
                sudo apt remove --purge --yes "${m[0]}" "${m[1]}" &> "${f[null]}"

                sudo sed --in-place '/google-chrome/d' "${f[mimeapps]}"

                sudo sed --in-place '/google-chrome/d' "${d[0]}"*.json

                sudo rm --force --recursive "${d[1]}"

                sudo rm --force "${f[garbage]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        # Dependencies
        install_packages "${m[1]}" "${m[2]}" "${m[3]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[0]}"

        sudo dpkg --install "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    echo; read -p $'\033[1;37mSIR, SHOULD I OPEN CHROME? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            ( nohup "${m[0]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        ~/.config/flameshot/  # 0
        /tmp/  # 1
        ~/.config/autostart/  # 2
    )

    f+=(
        [config]="${d[0]}"flameshot.ini
        [dskt]="${d[2]}"Flameshot.desktop
        [shortcut_gnome]=/org/gnome/shell/keybindings/
        [shortcut_cinnamon]=/org/cinnamon/desktop/keybindings/media-keys/
        [key_cinnamon]=/org/cinnamon/desktop/keybindings/custom-keybindings/printscreen/
        [wayland]=/etc/gdm3/custom.conf
    )

    local -a m=(
        'flameshot'  # 0
        'dconf-editor'  # 1
        'gawk'  # 2
    )

    [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        install_packages "${m[0]}" "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]]; then

        [[ $(grep --no-messages '#WaylandEnable' "${f[wayland]}") ]] \
            && sudo sed --in-place 's|#WaylandEnable=false|WaylandEnable=false|g' "${f[wayland]}"

        # sudo systemctl restart gdm3
        echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                sudo reboot

            elif [[ "${option:0:1}" = @(n|N) ]] ; then

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
            || ( nohup "${m[0]}" config & ) &> "${f[null]}" \
            && sleep 5s

    done

    # If these instructions below stay in for, don't works
    sudo pkill "${m[0]}" && take_a_break

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

    [[ ! $(grep --no-messages flameshot "${f[dskt]}") && "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
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
        /usr/lib/heroku/  # 0
        ~/.cache/heroku/  # 1
    )

    f+=(
        [auth]=~/.netrc
        [ppa]=/etc/apt/sources.list.d/heroku.list
    )

    local -a l=(
        'https://cli-assets.heroku.com/install-ubuntu.sh'  # 0
    )

    local -a m=(
        'heroku'  # 0
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                sudo rm --force "${f[auth]}" "${f[ppa]}"

                sudo rm --force --recursive "${d[0]}" "${d[1]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        sh -c "$(curl --silent ${l[0]})" &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    echo; read -p $'\033[1;37mWANT YOU AUTHENTICATE '"${name[random]}"$'? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            echo && heroku login -i

            # https://devcenter.heroku.com/articles/heroku-cli#login-issues
            while [[ ! -e "${f[auth]}" ]]; do

                show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!\n" 'fast'

                heroku login -i

            done

            break

        elif [[ "${option:0:1}" = @(n|N) ]] ; then

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
        /etc/udev/rules.d/  # 0
        /boot/grub/themes/  # 1
    )

    f+=(
        [config]="${d[0]}"99-hide-disks.rules
        [grub2_theme]=/tmp/grub2-theme-mint_1.2.2_all.deb
        [grub-modified]=/etc/default/grub
        [grub]=/boot/grub/grub.cfg
        [audio]=/usr/share/pulseaudio/alsa-mixer/paths/analog-output.conf.common
        [keyboard]=/etc/modprobe.d/hid_apple.conf
        [temporary]=/sys/module/hid_apple/parameters/fnmode
    )

    local -a l=(
        'https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/g/grub2-theme-mint/grub2-theme-mint_1.2.2_all.deb'  # 0
        'https://vignette4.wikia.nocookie.net/despicableme/images/6/6b/Gru_sunglasses.jpg/revision/latest?cb=20140218054928'  # 1
    )

    local -a m=(
        'devices'  # 0
        'grub2-theme-mint-2k'  # 1
        'grub2-theme-mint'  # 2
        'imagemagick'  # 3
    )

    check_devices=$(sudo fdisk --list 2>&- | grep 'Microsoft basic data' | awk '{print $1}')

    if [[ -z "${check_devices}" ]]; then

        show "\n  THERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!"

        return_menu

    else

        # --no-messages hide if file don't exists
        if [[ $(grep --no-messages ID_FS_UUID "${f[config]}") ]]; then

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${lineh:${#m[0]}} [HIDED]\n" 'fast'

            read -p $'\033[1;37mSIR, SHOULD I SHOW THEM? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    show "\n${c[RED]}S${c[WHITE]}HOWING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                    sudo rm --force "${f[config]}"

                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    return_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I SHOW THEM AGAIN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            show "${c[GREEN]}\n\tH${c[WHITE]}IDING ${c[GREEN]}WINDOWS ${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" 'fast'

            show "${c[GREEN]}H${c[WHITE]}IDING ${c[GREEN]}DEVICE${c[WHITE]}"

            for device in "${check_devices}"; do

                devices+=(${device})

            done

            [[ ! -d "${d[0]}" || $(stat --format="%U" "${d[0]}" 2>&-) != ${USER} ]] \
                && mkdir --parents "${d[0]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

            for (( iterador=0; iterador<${#devices[@]}; iterador++ )); do

                tee --append "${f[config]}" > "${f[null]}" <<< 'ENV{ID_FS_UUID}=="'"$(blkid --match-tag UUID --output value ${devices[${iterador}]})"'",ENV{UDISKS_IGNORE}="1"'

            done

            unset iterador

            read -p $'\033[1;37mSIR, DO U WANT TO INSTALL A THEME FOR GRUB? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                        && show "\nBEFORE PROCEED, WE MUST INSTALL SOME REQUIREMENTS..." \
                        && install_packages "${m[3]}"

                    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
                        && install_packages "${m[1]}"

                    if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]]; then

                        if [[ $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]]; then

                            show "\n${c[GREEN]}${m[2]^^} ${c[WHITE]}${linei:${#m[2]}} [INSTALLED]"

                        else

                            show "\n${c[YELLOW]}${m[2]^^} ${c[WHITE]}${linen:${#m[2]}} [INSTALLING]"

                            [[ ! -e "${f[grub2_theme]}" ]] \
                                && wget --quiet "${l[0]}" --output-document "${f[grub2_theme]}" \
                                && sudo dpkg --install "${f[grub2_theme]}" &> "${f[null]}" \
                                && sudo rm --force "${f[grub2_theme]}"

                        fi

                    fi

                    d+=(
                        "${d[1]}"$(find "${d[1]}" -maxdepth 1 -type d | tail -1 | awk --field-separator=/ '{print $5}')/  # 2
                    )

                    f+=(
                        [bkg_grub_jpg]="${d[2]}"background.jpg
                        [bkg_grub_png]="${d[2]}"background.png
                        [old_bkg_grub]="${d[2]}"background_old.png
                    )

                    [[ ! -d "${d[2]}" || $(stat --format="%U" "${d[2]}" 2>&-) != "${USER}" ]] \
                        && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
                        && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

                    if [[ ! -e "${f[old_bkg_grub]}" ]]; then

                        mv "${f[bkg_grub_png]}" "${f[old_bkg_grub]}"

                        [[ ! -e "${f[bkg_grub_jpg]}" ]] \
                            && wget --quiet "${l[1]}" --output-document "${f[bkg_grub_jpg]}" \
                            && convert "${f[bkg_grub_jpg]}" "${f[bkg_grub_png]}" \
                            && rm --force "${f[bkg_grub_jpg]}"

                    fi

                    [[ ! $(grep --no-messages '1920x1080' "${f[grub-modified]}") ]] \
                        && sudo sed --in-place 's|#GRUB_GFXMODE=640x480|GRUB_GFXMODE=1920x1080|g' "${f[grub-modified]}"

                    [[ ! $(grep --no-messages 'ipv6.disable=1' "${f[grub-modified]}") ]] \
                        && sudo sed --in-place 's|GRUB_CMDLINE_LINUX=""|GRUB_CMDLINE_LINUX="ipv6.disable=1"|g' "${f[grub-modified]}"

                    sudo update-grub 2>&- &> "${f[null]}"

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            echo; read -p $'\033[1;37mSIR, ARE YOU HAVING ISSUES WITH USB AUDIO? (EDIFIER SPEAKER PERHAPS) \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    # https://chrisjean.com/fix-for-usb-audio-is-too-loud-and-mutes-at-low-volume-in-ubuntu/
                    [[ ! $(grep --no-messages '^volume-limit' "${f[audio]}") ]] \
                        && sudo sed --in-place 's|^volume = merge|volume = ignore\nvolume-limit = 0.01|g' "${f[audio]}" \
                        && pulseaudio --kill

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE YOU HAVING ISSUES WITH SOUND SPEAKERS?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            # https://wiki.archlinux.org/title/Apple_Keyboard
            echo; read -p $'\033[1;37mSIR, ARE YOU HAVING ISSUES WITH KEYBOARD? (APPLE FN) \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    [[ ! -e "${f[temporary]}" ]] \
                        && sudo tee "${f[temporary]}" > "${f[null]}" <<< '0' \
                        && sudo update-initramfs -u 2>&- > "${f[null]}"

                    [[ ! $(grep --no-messages '2' "${f[keyboard]}") ]] \
                        && sudo tee "${f[keyboard]}" > "${f[null]}" <<< 'options hid_apple fnmode=2' \
                        && sudo update-initramfs -u 2>&- > "${f[null]}"

                    echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                    for (( ; ; )); do

                        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                            reboot

                        elif [[ "${option:0:1}" = @(n|N) ]] ; then

                            break

                        else

                            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                            read option

                        fi

                    done

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        'minidlna'  # 0
        'gawk'  # 1
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, WE MUST INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[1]}"

    source "${f[os_release]}" "${f[user_dirs]}"

    which_os="${PRETTY_NAME//Linux /}"

    local -a d=(
        "${XDG_VIDEOS_DIR}"  # 0
        /home/"${USER}"/.config/minidlna  # 1
        /var/lib/minidlna  # 2
    )

    f+=(
        [config]=/etc/minidlna.conf
        [dft]=/etc/default/minidlna
        [service]=/lib/systemd/system/minidlna.service
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                sudo rm --force "${f[config]}" "${f[dft]}" "${f[service]}"

                sudo rm --force --recursive "${d[1]}" "${d[2]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        install_packages "${m[0]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! $(grep --no-messages "${d[1]}" "${f[config]}") ]]; then

        # automatic discover new files
        sudo sed --in-place 's|#inotify=.*|inotify=yes|g' "${f[config]}"

        # server_name
        sudo sed --in-place "s|#friendly.*|friendly_name=${which_os}|g" "${f[config]}"

        # location database
        sudo sed --in-place "s|#db_dir=.*|db_dir=${d[1]}|g" "${f[config]}"

        # location logs
        sudo sed --in-place "s|#log_dir=.*|log_dir=${d[1]}|g" "${f[config]}"

        # media dirs
        # sudo sed --in-place --null-data "s|${d[2]}|V,${d[0]}|5" "${f[config]}"
        sudo sed --in-place --null-data "s|${d[3]}\n|V,${d[1]}\n|g" "${f[config]}"

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

    echo; read -p $'\033[1;37mSIR, AREN\'T YOUR FILES BEING REFRESHED ON MINIDLNA DATABASE? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            # forces a rescan
            sudo minidlnad -r && sudo service minidlna restart

            sudo service minidlna force-reload

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        'https://www.nvidia.com/Download/driverResults.aspx/157462/en-us'  # 0
    )

    local -a m=(
        'nvidia-driver'  # 0
        'nouveau-driver'  # 1
        'nvidia-settings'  # 2
        'dconf-editor'  # 3
        'gawk'  # 4
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[4]}"

    latest=$(curl --silent "${l[0]}" | grep -1 '"tdVersion"' | tail -1 | awk --field-separator=. '{print $1}' | xargs)

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

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

            read -p $'\033[1;37mSIR, SHOULD I RESTORE NOUVEAU DRIVER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    show "\n${c[RED]}R${c[WHITE]}ESTORING ${c[RED]}${m[1]^^}${c[WHITE]}!\n"

                    [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep graphics) ]] \
                        && sudo add-apt-repository --remove --yes ppa:graphics-drivers/ppa &> "${f[null]}"

                    sudo apt remove --purge --yes "${m[2]}" "${m[0]}-"* &> "${f[null]}"

                    sudo rm --force "${f[config]}"

                    sudo update-initramfs -u > "${f[null]}"

                    echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                    for (( ; ; )); do

                        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                            reboot

                        elif [[ "${option:0:1}" = @(n|N) ]] ; then

                            break

                        else

                            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                            read option

                        fi

                    done

                    remove_useless

                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    return_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTORE DEFAULT DRIVER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

            [[ ! $(apt search nvidia-driver-"${latest}") ]] \
                && sudo add-apt-repository --yes ppa:graphics-drivers/ppa &> "${f[null]}" \
                && update

            install_packages "${m[0]}-${latest}" "${m[2]}"

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! $(grep --no-messages nouveau "${f[config]}") ]]; then

        sudo tee "${f[config]}" > "${f[null]}" <<< 'blacklist nouveau
blacklist lbm-nouveau
alias nouveau off
alias lbm-nouveau off'

        sudo update-initramfs -u > "${f[null]}"

        echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                reboot

            elif [[ "${option:0:1}" = @(n|N) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    local=$(apt version "${m[0]}-"* 2>&-)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep graphics) ]] \
            && sudo add-apt-repository --yes ppa:graphics-drivers/ppa &> "${f[null]}"

        update && install_packages "${m[0]}-${latest}"

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
postgres_stuffs() {

    local -a d=(
        /etc/postgresql/  # 0
        /var/log/postgresql/  # 1
    )

    f+=(
        [ppa]=/etc/apt/sources.list.d/pgdg.list
        [ppa-pgadm]=/etc/apt/sources.list.d/pgadmin4.list
        [pspg_postgres]=/var/lib/postgresql/.psqlrc
        [pspg_user]=~/.psqlrc
    )

    local -a l=(
        'https://www.postgresql.org/media/keys/ACCC4CF8.asc'  # 0
        'https://www.postgresql.org/download/windows/'  # 1
        'https://www.pgadmin.org/static/packages_pgadmin_org.pub'  # 2
        'https://www.linuxmint.com/download_all.php'  # 3
    )

    local -a m=(
        'postgresql'  # 0
        'postgresql-client'  # 1
        'postgresql-contrib'  # 2
        'libpq-dev'  # 3
        'pgadmin4'  # 4
        'pspg'  # 5
        'gawk'  # 6
        'systemd'  # 7
        'lsb-release'  # 8
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") \
        && ! $(dpkg --list | awk "/ii  ${m[7]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[6]}" "${m[7]}" "${m[8]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" &> "${f[null]}"

                sudo rm --force "${f[ppa]}"

                sudo rm --force --recursive "${d[0]}" "${d[1]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        # lsb_release get os version name
        [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
            && check_codename=$(curl --silent "${l[3]}" | grep --ignore-case -2 $(lsb_release --codename --short) | tail -1 | awk '{print $3}' | sed 's|</td>||' | tr '[:upper:]' '[:lower:]')

        [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
            && check_codename=$(lsb_release --codename --short)

        # 2> hides warning
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep PostgreSQL) ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | sudo apt-key add - &> "${f[null]}"

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep pgadmin) ]] \
            && sudo wget --quiet --output-document - "${l[2]}" | sudo apt-key add - &> "${f[null]}"

        # If returns warning about architeture, please write deb [ arch=amd64 ]
        [[ ! $(grep --no-messages "${check_codename}" "${f[ppa]}") ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb [ arch=amd64 ] http://apt.postgresql.org/pub/repos/apt ${check_codename}-pgdg main"

        [[ ! $(grep --no-messages "${check_codename}" "${f[ppa-pgadm]}") ]] \
            && sudo tee "${f[ppa-pgadm]}" > "${f[null]}" <<< "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/${check_codename} pgadmin4 main"

        update

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[4]}" "${m[5]}"  # "${m[3]}"

        sudo rm --force "${f[ppa-pgadm]}"

        echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

        # Or pg_createcluster $(apt version postgresql | cut -c1-2) main --start
        # /etc/init.d/postgresql start
        d+=(
            /etc/postgresql/"$(apt version "${m[0]}" | cut --characters=1-2)"/main/conf.d/  # 3
        )

        if [[ ! -d "${d[3]}" ]]; then

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    sudo reboot

                elif [[ "${option:0:1}" = @(n|N) ]] ; then

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

    latest=$(curl --silent "${l[1]}" | grep scope | head -1 | tr --complement --delete 0-9,. | xargs)

    # Match perhaps with -10 or -11 etc (fixed installation)
    local=$(apt version "${m[0]}" 2>&-)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE POSTGRES VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                sudo apt install --assume-yes --only-upgrade "${m[0]}"* &> "${f[null]}"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    f+=(
        [cfg]="${d[0]}""${local:0:2}"/main/postgresql.conf
        [hba]="${d[0]}""${local:0:2}"/main/pg_hba.conf
    )

    sudo sed --in-place "s|#listen_addresses|listen_addresses|g" "${f[cfg]}"

    read -p $'\033[1;37m\nDO U WANT A USER TO ACCESS THE CONSOLE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            # sudo -u postgres psql
            echo; read -p $'\033[1;37mENTER THE USER ('"${USER}"$'): \033[m' user

            # if empty string
            [[ -z "${user}" ]] && user="${USER}"

            [[ $(sudo --user=postgres psql --command "SELECT 1 FROM pg_roles WHERE rolname='${user}'" | egrep "registro|row" | awk '{print $1}' | sed 's|(||') -ge 1 ]] \
                && show "\nUSER ${c[RED]}${user^^}${c[WHITE]} ALREADY EXISTS. EXITING..." \
                && break

            password=$("${f[askpass]}" $'\033[1;37mPASSWORD OF USER '"${user^^}"$':\033[m')

            sudo --user=postgres psql --command "CREATE USER ${user} WITH ENCRYPTED PASSWORD '${password}'" &> "${f[null]}"

            sudo --user=postgres psql --command "ALTER ROLE ${user} SET client_encoding TO 'utf8'" &> "${f[null]}"

            sudo --user=postgres psql --command "ALTER ROLE ${user} SET default_transaction_isolation TO 'read committed'" &> "${f[null]}"

            sudo --user=postgres psql --command "ALTER ROLE ${user} SET timezone TO 'America/Sao_Paulo'" &> "${f[null]}"

            read -p $'\033[1;37m\nDO U WANT A DATABASE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    # \c <database>
                    read -p $'\033[1;37m\nENTER THE DATABASE NAME: \033[m' database

                    [[ $(sudo --user=postgres psql --command "SELECT 1 FROM pg_database WHERE datname='${database}'" | egrep "registro|row" | awk '{print $1}' | sed 's|(||') -ge 1 ]] \
                        && show "\nDATABASE ${c[RED]}${database^^}${c[WHITE]} ALREADY EXISTS. EXITING..." \
                        && break

                    sudo --user=postgres psql --command "CREATE DATABASE ${database}" &> "${f[null]}"

                    sudo --user=postgres psql --command "GRANT ALL PRIVILEGES ON DATABASE ${database} TO ${user}" &> "${f[null]}"

                    sudo --user=postgres psql --dbname="${database}" --command "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO ${user}" &> "${f[null]}"

                    [[ "${database}" = 'rarbg' ]] \
                        && sudo --user=postgres psql --dbname="${database}" --command "CREATE TABLE IF NOT EXISTS torrent (
    id SERIAL PRIMARY KEY,
    title VARCHAR(150),
    url VARCHAR(50),
    release_date INT,
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

                    read -p $'\033[1;37mWANT CREATE MORE DATABASES? \n[Y/N] R: \033[m' option

                    if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                        continue  # Simillar to pass

                    elif [[ "${option:0:1}" = @(N|n) ]] ; then

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. WANT U CREATE MORE DATABASES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                        read option

                    fi

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        /opt/  # 0
        /opt/Postman/  # 1
        "${HOME}"/.postman/InterceptorBridge  # 2
        ~/.config/BraveSoftware/Brave-Browser/Default/Extensions/aicmkgpgakddgnaphhhpliifpcfhicfo/  # 3
        ~/.config/google-chrome/Default/Extensions/aicmkgpgakddgnaphhhpliifpcfhicfo/  # 4
    )

    local -a m=(
        'postman'  # 0
        'gawk'  # 1
        'brave-browser'  # 2
        'google-chrome-stable'  # 3
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[1]}"

    f+=(
        [file]="${XDG_DOWNLOAD_DIR}"/Postman-linux-x64-latest.tar.gz
        [bin]=/usr/local/bin/postman
        [run]="${d[1]}"Postman
        [postman]=/usr/share/applications/postman.desktop
        [int_brave]=~/.config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.postman.postmanapp.json
        [int_chrome]=~/.config/google-chrome/NativeMessagingHosts/com.postman.postmanapp.json
        [inter]="${HOME}"/.postman/InterceptorBridge/InterceptorBridge
    )

    local -a l=(
        'https://dl.pstmn.io/download/latest/linux64'  # 0
        'https://chrome.google.com/webstore/detail/postman-interceptor/aicmkgpgakddgnaphhhpliifpcfhicfo?hl=en'  # 1
    )

    if [[ -f "${f[bin]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                rm --force "${f[postman]}" "${f[bin]}"

                rm --force --recursive "${d[1]}"



                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[0]}"

        tar --extract --gzip --file="${f[file]}" --directory="${d[0]}" > "${f[null]}"

        sudo rm --force "${f[file]}"

        [[ ! -L "${f[bin]}" ]] \
            && sudo ln --force --symbolic "${f[run]}" "${f[bin]}"

        read -p $'\033[1;37m\nSIR, WANT TO INSTALL INTERCEPTOR BRIDGE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                echo; read -p $'\033[1;37mSIR, DO YOU PREFER BRAVE BROWSER OVER CHROME BROWSER? \n[Y/N] R: \033[m' option

                for (( ; ; )); do

                    if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                        [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
                            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH BRAVE?" \
                            && brave_stuffs

                        break

                    elif [[ "${option:0:1}" = @(N|n) ]] ; then

                        [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH CHROME?" \
                            && chrome_stuffs

                        break

                    else

                        echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U PREFER BRAVE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                        read option

                    fi

                done

                ( nohup "${m[1]}" & ) &> "${f[null]}"

                while [[ ! -d "${d[2]}" ]]; do

                    show "\nPLEASE, ENTER CAPTURE REQUESTS ICON AT POSTMAN AND INSTALL INTERCEPTOR BRIDGE..."

                    sleep 10s

                done

                sudo pkill postman

                ( nohup "${choice}" & ) &> "${f[null]}"

                if [[ "${choice}" = 'brave-browser' ]]; then

                    while [[ ! -d "${d[3]}" ]]; do

                        show "\nPLEASE, INSTALL POSTMAN INTERCEPTOR EXTENSION IN ${choice^^}\n${l[1]}"

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

                    while [[ ! -d "${d[4]}" ]]; do

                        show "\nPLEASE, INSTALL POSTMAN INTERCEPTOR EXTENSION IN ${choice^^}\n${l[1]}"

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

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

    echo; read -p $'\033[1;37mSIR, SHOULD I OPEN POSTMAN? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            ( nohup "${m[0]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

    f+=(
        [python_new]=/usr/bin/python
    )


    local -a l=(
        'https://pypi.org/project/pip/'  # 0
        'https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer'  # 1
        'https://www.python.org/doc/versions/'  # 2
    )

    local -a m=(
        'python-is-python3'  # 0
        'python3-pip'  # 1
        'python-dev-is-python3'  # 2
        'build-essential'  # 3
        'pyenv'  # 4
        'curl'  # 5
        'wget'  # 6
        'zlib1g-dev'  # 7
        'libreadline-dev'  # 8
        'libsqlite3-dev'  # 9
        'llvm'  # 10
        'libncurses5-dev'  # 11
        'libbz2-dev'  # 12
        'libssl-dev'  # 13
        'libffi-dev'  # 14
        'gawk'  # 15
        'dependencies'  # 16
        'git'  # 17
        'liblzma-dev'  # 18
        'tk-dev'  # 19
        'python3-venv'  # 20
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[15]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[15]}"

    # https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body
    local -a d=(
        ~/.pyenv  # 0
        ~/.pyenv/versions/$(curl --silent "${l[0]}" | grep --after-context=2 '_le' | tail -1 | awk '{print $2}')  # 1
        ~/.pyenv/shims/  # 2
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]" 'fast'

        read -p $'\033[1;37m\nSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]} AND ${c[RED]}${m[17]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                sudo sed --in-place '/pyenv/Id' "${f[bashrc]}"

                source "${f[bashrc]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[20]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # pip versions
    local=$(apt version "${m[1]}" 2>&-)

    latest=$(curl --silent "${l[0]}" | grep --after-context=2 '_le' | tail -1 | awk '{print $2}')

    ( $(dpkg --compare-versions "${local}" lt "${latest}") ) \
        && python3 -m pip install --quiet --no-warn-script-location --upgrade pip

    # python versions
    # apt version python don't works, because it shows only packages added by
    # apt and pyenv download/install packages from curl
    local=$(python -c 'from platform import python_version as v; print(v())')

    latest=$(curl --silent "${l[2]}" | grep --no-messages external | head -4 | tail -1 | awk --field-separator=/ '{print $5}')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[4]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

                # Dependencies
                install_packages "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[17]}" "${m[18]}" "${m[19]}"

                [[ -d "${d[0]}" ]] \
                    && show "\n${c[GREEN]}${m[4]^^} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]" \
                    || show "\n${c[YELLOW]}${m[4]^^} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                    && bash -c "$(curl --silent --location ${l[0]})" &> "${f[null]}"

                echo; show "INITIALIZING CONFIGS..."

                [[ ! $(grep --no-messages rehash "${f[bashrc]}") ]] \
                    && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< '
# PYENV (py upgrade) configs
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"' \
                    && source "${f[bashrc]}"

                # pyenv versions
                # pyenv install --list | grep " 3\.[678]"
                [[ ! -d "${d[1]}" ]] && pyenv install "${latest}" &> "${f[null]}"

                # check with pyenv versions
                pyenv global "${latest}" > "${f[null]}"

                sudo ln --force --symbolic "${d[2]}$(echo ${latest} | awk --field-separator='.' '{print $1 "." $2}')" "${f[python_new]}"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

    sudo apt upgrade --assume-yes &> "${f[null]}"

}
#======================#

#======================#
reduceye_stuffs() {

    local -a d=(
        ~/.config/redshift/  # 0
        ~/.config/autostart/  # 1
    )

    f+=(
        [config]="${d[0]}"redshift.conf
        [dskt]="${d[1]}"redshift-gtk.desktop
    )

    local -a m=(
        'redshift'  # 0
        'redshift-gtk'  # 1
    )

    [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                sudo rm --force "${f[dskt]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        install_packages "${m[0]}" "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[config]}" ]]; then

        [[ ! -d "${d[0]}" || $(stat --format="%U" "${d[0]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[0]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

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
        'https://www.ruby-lang.org/en/downloads/'  # 0
        'https://github.com/rbenv/rbenv.git'  # 1
        'https://github.com/rbenv/ruby-build.git'  # 2
        'https://dl.yarnpkg.com/debian/pubkey.gpg'  # 3
    )

    local -a m=(
        'ruby'  # 0
        'yarn'  # 1
        'gawk'  # 2
        'rbenv'  # 3
        'ruby-build'  # 4
        'git'  # 5
        'zlib1g-dev'  # 6
        'build-essential'  # 7
        'libssl-dev'  # 8
        'libreadline-dev'  # 9
        'libyaml-dev'  # 10
        'libsqlite3-dev'  # 11
        'sqlite3'  # 12
        'libxml2-dev'  # 13
        'libxslt1-dev'  # 14
        'libcurl4-openssl-dev'  # 15
        'software-properties-common'  # 16
        'libffi-dev'  # 17
        'ruby-dev'  # 18
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

    # https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body
    local -a d=(
        ~/.rbenv  # 0
        ~/.rbenv/versions/$(curl --silent "${l[0]}" | grep --no-messages stable | awk '{print $6}' | sed 's|.||6')  # 1
        ~/.rbenv/plugins/ruby-build  # 2
    )

   if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[18]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[VERMELHO]}U${c[WHITE]}NINSTALLING ${c[VERMELHO]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" "${m[1]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                sudo sed --in-place '/rbenv/d' "${f[bashrc]}"

                sudo sed --in-place 's|# Ruby configs||g' "${f[bashrc]}"

                source "${f[bashrc]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[VERMELHO]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESET?${c[FIM]}\n${c[WHITE]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep Yarn) ]] \
            && sudo wget --quiet --output-document - "${l[3]}" | sudo apt-key add - &> "${f[null]}"

        # [[ ! $(grep --no-messages yarnpkg "${f[ppa]}") ]] \
        #     && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb https://dl.yarnpkg.com/debian/ stable main" \
        #     && update

        install_packages "${m[0]}" "${m[1]}" "${m[18]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # ruby versions
    local=$(ruby -e 'puts "#{RUBY_VERSION}"')

    latest=$(curl --silent "${l[0]}" | grep --no-messages stable | awk '{print $6}' | sed 's|.||6')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[3]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

                # Dependencies
                install_packages "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}"

                # rbenv
                [[ -d "${d[0]}" ]] \
                    && show "\n${c[GREEN]}${m[3]^^} ${c[WHITE]}${linei:${#m[3]}} [INSTALLED]" \
                    || show "\n${c[YELLOW]}${m[3]^^} ${c[WHITE]}${linen:${#m[3]}} [INSTALLING]" \
                    && git clone --quiet "${l[1]}" "${d[0]}" \

                # Install don't comes by default on rbenv until ruby-build was installed
                [[ -d "${d[2]}" ]] \
                    && show "\n${c[GREEN]}${m[4]^^} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]" \
                    || show "\n${c[YELLOW]}${m[4]^^} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                    && git clone --quiet "${l[2]}" "${d[2]}"

                echo; show "INITIALIZING CONFIGS..."

                [[ ! $(grep --no-messages rbenv "${f[bashrc]}") ]] \
                    && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< '
# Ruby configs
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"' \
                    && source "${f[bashrc]}"

                # rbenv versions
                # rbenv install -l
                [[ ! -d "${d[1]}" ]] && rbenv install "${latest}" &> "${f[null]}"

                rbenv global "${latest}" > "${f[null]}"

                echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        ~/.config/sublime-text/  # 0
        ~/.config/sublime-text/Installed\ Packages/  # 1
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org  # 2
        ~/.pyenv/  # 3
        /.Trash-1000/  # 4
    )

    f+=(
        [config]="${d[0]}"Packages/User/Preferences.sublime-settings
        [config_merge]="${d[5]}"Packages/User/Preferences.sublime-settings
        [hosts]=/etc/hosts
        [ppa]=/etc/apt/sources.list.d/sublime-text.list
        [exec]=/opt/sublime_text/sublime_text
        [license]="${d[0]}"Local/License.sublime_license
        [license_merge]="${d[5]}"Local/License.sublime_license
        [pkg_ctrl]="${d[1]}"Package\ Control.sublime-package
        [pkgs]="${d[0]}"Packages/User/Package\ Control.sublime-settings
        [anaconda]="${d[0]}"Packages/Anaconda/Anaconda.sublime-settings
        [keymap]="${d[0]}"Packages/User/Default\ \(Linux\).sublime-keymap
        [REPL]="${d[0]}"Packages/SublimeREPL/SublimeREPL.sublime-settings
        [REPLPY]="${d[0]}"Packages/SublimeREPL/config/Python/Main.sublime-menu
        [reduce]=config/Python/Main.sublime-menu
        [REPLPYT]="${d[0]}"Packages/SublimeREPL/sublimerepl.py
        [recently_used]=~/.local/share/recently-used.xbel
        [gpg]=/etc/apt/trusted.gpg.d/sublimehq-archive.gpg
    )

    declare -a l=(
        'https://download.sublimetext.com/sublimehq-pub.gpg'  # 0
        'https://download.sublimetext.com/ apt/stable/'  # 1
        'https://packagecontrol.io/Package%20Control.sublime-package'  # 2
        'https://packagecontrol.io/packages/'  # 3
        'https://www.sublimetext.com/download'  # 4
    )

    declare -a m=(
        'apt-transport-https'  # 0
        'sublime-text'  # 1
        'gawk'  # 2
        'python-is-python3'  # 3
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]^^} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[1]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                sudo sed --in-place '/sublime_text/d' "${f[mimeapps]}"

                sudo sed --in-place '/sublime/d' "${f[hosts]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        # 2> hides
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep Sublime) ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | gpg --dearmor | sudo tee "${f[gpg]}" &> "${f[null]}"

        install_packages "${m[0]}" "${m[1]}"

        # This hides from dpkg --list
        # sudo apt-mark hold "${m[3]}" &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    local=$(subl --version | awk '{print $4}')

    latest=$(curl --silent "${l[4]}" | grep latest | awk '{print $4}' | sed 's/<[^>]*>//g')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE TRANSMISSION VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ @(s|S|y|Y) ]] ; then

                [[ ! $(grep --no-messages sublimetext "${f[ppa]}") ]] \
                    && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb ${l[1]}"

                update && sudo apt install --assume-yes "${m[1]}" &> "${f[null]}"

                sudo rm --force "${f[ppa]}"

                break

            elif [[ "${option:0:1}" =~ @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    while [[ ! -d "${d[0]}" ]]; do

        show "\nRESTARTING SUBLIME TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup subl & ) &> "${f[null]}"

        take_a_break

        sudo pkill subl

        take_a_break

    done

    if [[ $(md5sum --check <<< "7038C3B1CC79504602DA70599D4CCCE9 ${f[exec]}" 2> "${f[null]}" | grep --no-messages 'OK') ]]; then

        # https://gist.github.com/maboloshi/feaa63c35f4c2baab24c9aaf9b3f4e47
        echo 00415013: 48 31 C0 C3          | sudo xxd -revert - sublime_text

        echo 00409037: 90 90 90 90 90       | sudo xxd -revert - sublime_text

        echo 0040904F: 90 90 90 90 90       | sudo xxd -revert - sublime_text

        echo 00416CA4: 48 31 C0 48 FF C0 C3 | sudo xxd -revert - sublime_text

        echo 00414C82: C3                   | sudo xxd -revert - sublime_text

        echo 003FA310: C3                   | sudo xxd -revert - sublime_text

    fi

    # Adding license key
    [[ ! $(grep --no-messages Paying "${f[license]}") ]] \
        && sudo tee "${f[license]}" > "${f[null]}" <<< 'Paying $99 USD'

    # Remove file changes history
    # sudo rm --force "${f[recently_used]}"

    if [[ ! -e "${f[pkg_ctrl]}" ]]; then

        [[ ! -d "${d[1]}" || $(stat --format="%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

        curl --silent --output "${f[pkg_ctrl]}" --create-dirs "${l[2]}"

    fi

    [[ ! $(grep --no-messages packages "${f[pkgs]}") ]] \
        && sudo tee "${f[pkgs]}" > "${f[null]}" <<< '{
    "installed_packages": ["Anaconda", "Djaneiro", "Restart", "SublimeREPL", "Dracula Color Scheme", "AutoPEP8", "Pretty JSON", "Sync View Scroll", "MarkdownLivePreview"]
}' \
        && sudo chown "${USER}":"${USER}" "${f[pkgs]}"

    read -p $'\033[1;37m\nSIR, WANT TO INSTALL SOME ADITTIONAL PACKAGE FROM PACKAGE CONTROL? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            echo; read -p $'\033[1;37mTITLE (CASE SENSITIVE): \033[m' pkg

            [[ $(curl --silent --write-out %{http_code} --output "${f[null]}" "${l[3]}""${pkg}") -ne 200 ]] \
                && show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" 1 \
                && continue

            if ! [[ "${pkg}" =~ ^(Anaconda|Djaneiro|Restart|SublimeREPL|Sublimerge Pro|Dracula Color Scheme)$ ]]; then

                # Append new pkg to the last index of tuple
                sudo sed --in-place --regexp-extended "s|(.*)\"|\1\", \"${pkg}\"|" "${f[pkgs]}"

                echo; read -p $'\033[1;37mSIR, DO U WANT INSTALL ONE MORE? \n[Y/N] R: \033[m' option

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    continue

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL ONE MORE PACKAGE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            else

                echo; show "\t      REPO ALREADY ${c[RED]}PRE-INSTALLED${c[WHITE]}" 'fast'

            fi

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

        echo && read -p $'\033[1;37mSUBLIME ALREADY INSTALL ALL PACKAGES?\n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                sudo pkill subl && break

            elif [[ "${option:0:1}" = @(n|N) ]] ; then

                echo && show "I'LL RESTART... \n(RESTART IS REQUIRED AFTER PACKAGE CONTROL INSTALLATION)"

                sudo pkill subl && ( nohup subl & ) &> "${f[null]}"

                echo && read -p $'\033[1;37mPACKAGES ARE INSTALLED? \n[Y/N] R: \033[m' option

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SUBLIME ALREADY INSTALL PACKAGES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

        if [[ -e "${f[anaconda]}" && -e "${f[REPL]}" && -e "${f[REPLPY]}" \
            && -e "${f[REPLPY]}" ]]; then

            [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
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
    { "keys": ["ctrl+t"], "command": "toggle_sync_scroll" },
    {
        "keys": ["alt+m"],
        "command": "open_markdown_preview"
    }
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
        'tmate'  # 0
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        install_packages "${m[0]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    check_ssh

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
usefull_pkgs() {

    local -a d=(
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org/  # 0
        ~/.SpaceVim/  # 1
        ~/.config/vlc/  # 2
        /etc/  # 3
        /etc/series-renamer/  # 4
        ~/.config/autostart/  # 5
        ~/.config/Rename\ My\ TV\ Series/  # 6
        /tmp/coreutils-8.32  # 7
        ~/.local/bin  # 8
        /tmp/  # 9
    )

    f+=(
        [cfg]="${d[1]}"autoload/SpaceVim.vim
        [load]=~/.nvim/init.vim
        [lock]="${d[3]}"apt/preferences.d/nosnap.pref
        [out]=/tmp/spacevim.out
        [vlc]="${d[2]}"vlcrc
        [series]="${d[4]}"RenameMyTVSeries
        [rar-file]="${d[3]}"RenameMyTVSeries-2.0.10-Linux64bit.tar.gz
        [startup]=~/.local/share/applications/rename-series.desktop
        [icon]="${d[4]}"icons/128x128.png
        [config]=~/.config/transmission/settings.json
        [key2_cinnamon]=/org/cinnamon/desktop/keybindings/custom-keybindings/clipboard/
        [media_info]=/tmp/nemo-mediainfo-tab_1.0.4_all.deb
        [sticky_cfg]=/org/x/sticky/
        [rename_db]="${d[6]}"LocalData.sqlite3
        [daemon_rnm]=/usr/bin/rename-tv-series
        [after_torrent]=/usr/bin/torrent_completed.sh
        [cp_custom]=/tmp/coreutils-8.32.tar.xz
        [patch]=/tmp/coreutils-8.32/advcpmv-0.8-8.32.patch
        [new_cp]=~/.local/bin/cp
        [old_cp]=/tmp/coreutils-8.32/src/cp
    )

    local -a l=(
        'https://spacevim.org/install.sh'  # 0
        'https://www.tweaking4all.com/downloads/video/RenameMyTVSeries-2.0.10-Linux64bit.tar.gz'  # 1
        'https://github.com/transmission/transmission/releases/'  # 2
        'https://github.com/linux-man/nemo-mediainfo-tab/releases/download/v1.0.4/nemo-mediainfo-tab_1.0.4_all.deb'  # 3
        'https://api.pushover.net/1/messages.json'  # 4
        'http://ftp.gnu.org/gnu/coreutils/coreutils-8.32.tar.xz'  # 5
        'https://raw.githubusercontent.com/jarun/advcpmv/master/advcpmv-0.8-8.32.patch'  # 6
    )

    # Se seu vlc estiver em inglês, instale: "vlc-l10n" e remova ~/.config/vlc
    local -a m=(
        'tree'  # 0
        'vlc'  # 1
        'vim'  # 2
        'easytag'  # 3
        'telegram-desktop'  # 4
        'mlocate'  # 5
        'usefull packages'  # 6
        'soundconverter'  # 7
        'at'  # 8
        'autokey-gtk'  # 9
        'snapd'  # 10
        'compress-video'  # 11
        'spacevim'  # 12
        'dos2unix'  # 13
        'glow'  # 14
        'ffmpeg'  # 15
        'rename-tv-series'  # 16
        'sqlite3'  # 17
        'libsqlite3-dev'  # 18
        'ffmpegthumbnailer'  # 19
        'diodon'  # 20
        'neofetch'  # 21
        'nemo-mediainfo-tab'  # 22
        'transmission-gtk'  # 23
        'doublecmd-gtk'  # 24
        'libssl-dev'  # 25
        'dconf-editor'  # 26
        'python3-mediainfodll'  # 27
        'inotify-tools'  # 28
        'gcc'  # 29
        'g++'  # 30
        'make'  # 31
        'build-essential'  # 32
        'cprogressbar'  # 33
        'peek'  # 34
        'filezilla'  # 35
    )

    [[ ! -d "${d[5]}" || $(stat --format="%U" "${d[5]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[5]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[5]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[13]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[15]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[6]^^} ${c[WHITE]}${linei:${#m[6]}} [INSTALLED]" 'fast'

        read -p $'\033[1;37m\nSIR, SHOULD I UNINSTALL THEM? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}, ${c[RED]}${m[1]^^}${c[WHITE]}, ${c[RED]}${m[2]^^}${c[WHITE]}, ${c[RED]}${m[3]^^}${c[WHITE]} AND ${c[RED]}${m[4]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" &> "${f[null]}"

                sudo rm --recursive --force "${f[vimrc]}"

                sudo sed --in-place --null-data 's|video/x-matroska=vlc.desktop\nvideo/mp4=vlc.desktop||g' "${f[mimeapps]}"

                sudo sed --in-place '/vlc/d' "${f[bashrc]}"

                sudo sed --in-place '/vlc/d' "${f[mimeapps]}"

                sudo sed --in-place '/"telegram.desktop",/d' "${d[0]}"*.json

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n     I${c[WHITE]}NSTALLING ${c[GREEN]}${m[6]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 'fast'

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}"

        [[ -e "${f[lock]}" ]] && sudo rm --force "${f[lock]}"

        install_packages "${m[27]}"

        [[ ! $(dpkg --list | awk "/ii  ${m[22]}[[:space:]]/ {print }") ]] \
            && show "\n${c[GREEN]}${m[22]^^} ${c[WHITE]}${linei:${#m[22]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[22]^^} ${c[WHITE]}${linen:${#m[22]}} [INSTALLING]" \
            && sudo wget --quiet "${l[3]}" --output-document "${f[media_info]}" \
            && sudo dpkg --install "${f[media_info]}" &> "${f[null]}"

        update && install_packages "${m[4]}" "${m[5]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[13]}" "${m[15]}" "${m[17]}" "${m[18]}" "${m[19]}" "${m[20]}" "${m[21]}" "${m[24]}" "${m[25]}" "${m[26]}" "${m[28]}" "${m[29]}" "${m[30]}" "${m[31]}" "${m[32]}" "${m[34]}" "${m[35]}"

        [[ $(snap list 2>&- | grep "${m[11]}") ]] \
            && show "\n${c[GREEN]}${m[11]^^} ${c[WHITE]}${linei:${#m[11]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[11]^^} ${c[WHITE]}${linen:${#m[11]}} [INSTALLING]" \
            && snap install "${m[11]}" &> "${f[null]}"

        [[ $(snap list 2>&- | grep "${m[14]}") ]] \
            && show "\n${c[GREEN]}${m[14]^^} ${c[WHITE]}${linei:${#m[14]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[14]^^} ${c[WHITE]}${linen:${#m[14]}} [INSTALLING]" \
            && snap install "${m[14]}" &> "${f[null]}"

        [[ -d "${d[1]}" ]] \
            && show "\n${c[GREEN]}${m[12]^^} ${c[WHITE]}${linei:${#m[12]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[12]^^} ${c[WHITE]}${linen:${#m[12]}} [INSTALLING]" \
            && bash -c "$(curl --silent --location ${l[0]})" &> "${f[out]}"

        if [[ ! -e "${f[new_cp]}" ]]; then

            show "\n${c[YELLOW]}${m[33]^^} ${c[WHITE]}${linen:${#m[33]}} [INSTALLING]"

            [[ ! -d "${d[7]}" ]] \
                && wget --quiet "${l[5]}" --output-document "${f[cp_custom]}" \
                && tar --extract --file="${f[cp_custom]}" --directory="${d[9]}"

            [[ ! -e "${f[patch]}" ]] \
                && wget --quiet "${l[6]}" --output-document "${f[patch]}" \
                && patch --strip=1 --input="${f[patch]}" &> "${f[null]}" \
                && cd "${d[7]}" > "${f[null]}" \
                && sudo chmod +x configure \
                && ./configure &> "${f[null]}" \
                && make &> "${f[null]}" \
                && cd - > "${f[null]}"

            [[ ! -d "${d[8]}" || $(stat --format="%U" "${d[8]}" 2>&-) != "${USER}" ]] \
                && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
                && sudo mkdir --parents "${d[8]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[8]}"

            sudo cp "${f[old_cp]}" "${f[new_cp]}"

            [[ ! $(grep --no-messages '--progress-bar' "${f[bashrc]}") ]] \
                && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< '
alias cp="${HOME}/.local/bin/cp --progress-bar"' \
                && source "${f[bashrc]}"

        fi

        if [[ ! -e "${f[series]}" ]]; then

            show "\n${c[YELLOW]}${m[16]^^} ${c[WHITE]}${linen:${#m[16]}} [INSTALLING]"

            sudo wget --quiet "${l[1]}" --output-document "${f[rar-file]}"

            sudo mkdir --parents "${d[4]}" > "${f[null]}"

            sudo tar --extract --gzip --file="${f[rar-file]}" --directory="${d[4]}" > "${f[null]}"

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

            show "\n${c[GREEN]}${m[16]^^} ${c[WHITE]}${linei:${#m[16]}} [INSTALLED]"

        fi

        for (( ; ; )); do

            [[ $(grep --no-messages "That's it." "${f[out]}") ]] \
                && break \
                || continue

        done

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ ! -L "${f[daemon_rnm]}" ]] \
        && sudo ln --force --symbolic "${f[series]}" "${f[daemon_rnm]}"

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
        && dconf write "${f[custom_gnome]}" "['${f[custom_gnome]}custom0', '${f[custom_gnome]}custom1', '${f[custom_gnome]}custom2']" \
        && dconf write "${f[custom_gnome]}custom2/binding" "['<Super>v']" \
        && dconf write "${f[custom_gnome]}custom2/command" "'/usr/bin/diodon'" \
        && dconf write "${f[custom_gnome]}custom2/name" "'Clipboard Manager'"

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && dconf write "${f[custom_cinnamon]}" "['printscreen', 'clipboard']" \
        && dconf write "${f[key2_cinnamon]}command" "'/usr/bin/diodon'" \
        && dconf write "${f[key2_cinnamon]}binding" "['<Super>v']" \
        && dconf write "${f[key2_cinnamon]}name" "'Clipboard Manager'" \
        && dconf write "${f[sticky_cfg]}autostart" true \
        && dconf write "${f[sticky_cfg]}autostart-notes-visible" true \
        && dconf write "${f[sticky_cfg]}font" "'Monospace 14'" \
        && dconf write "${f[recent_items]}" 'uint32 10'

    if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]]; then

        local=$(apt version "${m[23]}")

        latest=$(curl --silent "${l[2]}" | grep 'class="Link--primary"' | head -1 | awk '{print $5}' | tr --complement --delete 0-9,. | xargs)

        if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

            echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE TRANSMISSION VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" =~ @(s|S|y|Y) ]] ; then

                    [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep transmissionbt) ]] \
                        && sudo add-apt-repository --yes ppa:transmissionbt/ppa &> "${f[null]}" \
                        && update

                    sudo apt install --assume-yes --only-upgrade "${m[23]}" &> "${f[null]}"

                    while [[ ! -e "${f[config]}" ]]; do

                        show "\nRESTARTING TRANSMISSION TO GENERATE CONFIG FILES.\nWAIT..."

                        ( nohup "${m[23]}" & ) &> "${f[null]}"

                        take_a_break

                        sudo pkill "${m[23]}"

                        take_a_break

                    done

                    sudo sed --in-place 's|"download-queue-size".*|"download-queue-size": 50,|g' "${f[config]}"

                    sudo sed --in-place 's|"trash-original-torrent-files": false,|"trash-original-torrent-files": true,|g' "${f[config]}"

                    break

                elif [[ "${option:0:1}" =~ @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UPGRADE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        fi

    fi

    echo; read -p $'\033[1;37mSIR, SHOULD I NOTIFY YOU WHEN TORRENTS BY TRANSMISSION-GTK ARE DONE? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            echo; show "SIR, PLEASE CREATE AN ACCOUNT IN https://pushover.net/signup\nAFTER THAT, CREATE AN APPLICATION AND PASTE TOKEN BELOW."

            for (( ; ; )); do

                echo; read -p $'\033[1;37mAPI TOKEN: \033[m' app
                
                read -p $'\033[1;37mTOKEN USER '"${e[silent_monkey]}"$': \033[m' user

                [[ $(curl --silent --form-string "token=${app}" --form-string "user=${user}" \
                    --form-string "message=ALFRED DOING SOME TESTS" "${l[4]}" | jq --raw-output .user) = 'invalid' ]] \
                    && show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" \
                    || break

            done

            [[ ! $(grep --no-messages 'curl' "${f[after_torrent]}") ]] \
                && sudo tee "${f[after_torrent]}" > "${f[null]}" <<< '#!/usr/bin/env bash

declare -a values=(
    '\"${app}\"'  # 0
    '\"${user}\"'  # 1
    "0"  # 2
    "siren"  # 3
    "Torrent Complete!"  # 4
    "<b><i>${TR_TORRENT_NAME:u}</i></b> finished downloading at ${TR_TIME_LOCALTIME}. Check it in ${TR_TORRENT_DIR}"  # 5
    "1"  # 6
    "https://api.pushover.net/1/messages.json"  # 7
)

curl --silent --form-string "token=${values[0]}" \
     --form-string "user=${values[1]}"  --form-string "timestamp=$(date +%s)" \
     --form-string "priority=${values[2]}" --form-string "sound=${values[3]}" \
     --form-string "title=${values[4]}" --form-string "message=${values[5]}" \
     --form-string "html=${values[6]}" "${values[7]}"'

            [[ $(stat --format='%a' "${f[after_torrent]}") -ne 755 ]] \
                && sudo chmod 755 "${f[after_torrent]}"

            sudo sed --in-place 's|"script-torrent-done-enabled".*|"script-torrent-done-enabled": true,|g' "${f[config]}"
            
            sudo sed --in-place 's|"script-torrent-done-filename".*|"script-torrent-done-filename": '\""${f[after_torrent]}"\"',|g' "${f[config]}"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I NOTIFY YOU?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    while [[ ! -e "${f[vlc]}" ]]; do

        show "\nRESTARTING VLC TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[1]}" & ) &> "${f[null]}"

        take_a_break

        sudo pkill "${m[1]}"

        take_a_break

    done

    sudo sed --in-place 's|#avcodec-hw=any|avcodec-hw=none|g' "${f[vlc]}"

    sudo sed --in-place 's|#freetype-rel-fontsize=0|freetype-rel-fontsize=12|g' "${f[vlc]}"

    sudo sed --in-place 's|#freetype-color=16777215|freetype-color=16776960|g' "${f[vlc]}"

    sudo sed --in-place 's|#video-title-show=1|video-title-show=0|g' "${f[vlc]}"

    while [[ ! -d "${d[6]}" ]]; do

        show "\nRESTARTING RENAME-SERIES TO GENERATE CONFIG FILES.\nWAIT..."

        ( nohup "${m[16]}" & ) &> "${f[null]}"

        take_a_break

        kill -9 $(pidof RenameMyTVSeries rename-tv-series) &> "${f[null]}"

        take_a_break

    done

    sqlite3 "${f[rename_db]}" "UPDATE preferences SET CheckForUpdates = 0;" "" > "${f[null]}"

    sqlite3 "${f[rename_db]}" "UPDATE preferences SET FileNameFormatString = '%E. %T';" "" > "${f[null]}"

    sqlite3 "${f[rename_db]}" "UPDATE preferences SET SeasonNrAtLeast2Chars = 0;" "" > "${f[null]}"

    sqlite3 "${f[rename_db]}" 'DELETE FROM replacechars WHERE replacement = "`";' "" > "${f[null]}"

    sqlite3 "${f[rename_db]}" 'UPDATE replacechars SET replacement = "／" WHERE original = "/";' "" > "${f[null]}"

    # These character class match once only, so we need +
    # https://www.petefreitag.com/cheatsheets/regex/character-classes/
    [[ $(grep --no-messages --extended-regexp '([[:space:]]+ = )1' "${f[cfg]}") ]] \
        && sed --in-place --regexp-extended 's|([[:space:]]+ = )1|\10|g' "${f[cfg]}"

    # set wrap breaks line when is too long
    # set mouse allow mouse highligh text
    [[ ! $(grep --no-messages mouse "${f[load]}") ]] \
        && sudo tee --append "${f[load]}" > "${f[null]}" <<< 'set mouse=a
set wrap'

    [[ ! $(grep --no-messages 'alias vk' "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
alias vk='kill -9 \$(pidof vlc) &> ${f[null]}'" \
        && source "${f[bashrc]}"

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
workspace_stuffs() {

    local -a d=(
        /workspace/  # 0
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
        'https://api.github.com/user'  # 0
        'https://api.github.com/repos/'  # 1
        'git@github.com:'  # 2
    )

    local -a m=(
        'dconf-editor'  # 0
    )

    if [[ -d "${d[0]}" || $(stat --format="%U" "${d[0]}" 2>&-) = ${USER} ]]; then

        show "\n${c[GREEN]}${d[0]^^} ${c[WHITE]}${linec:${#d[0]}} [CREATED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I REMOVE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}R${c[WHITE]}EMOVING ${c[RED]}${d[0]^^}${c[WHITE]}!\n"

                sudo rm --force --recursive "${d[0]}"

                [[ $(grep --no-messages workspace "${f[bookmarks]}") ]] \
                    && sudo sed --in-place $'s|file:///workspace \360\237\221\211 Workspace||g' "${f[bookmarks]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t C${c[WHITE]}REATING ${c[GREEN]}${d[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" 'fast'

        show "${c[GREEN]}C${c[WHITE]}REATING ${c[GREEN]}${d[0]^^}${c[WHITE]}"

        sudo mkdir --parents "${d[0]}" > "${f[null]}"

        sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

        install_packages "${m[0]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && dconf write "${f[bookmarks_in]}" true \
        && dconf write "${f[expand]}" true \
        && dconf write "${f[show]}" true

    # Lost your bookmarks? Run xdg-user-dirs-gtk-update
    [[ ! $(grep --no-messages workspace "${f[bookmarks]}") ]] \
        && sudo tee --append "${f[bookmarks]}" > "${f[null]}" <<< $'file:///workspace \360\237\221\211 Workspace'

    echo; read -p $'\033[1;37mSIR, SHOULD I DOWNLOAD ANY REPO FROM UR GITHUB ACCOUNT? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            [[ ! $(yes "" | ssh -T git@github.com 2>&- | grep --no-messages "You've successfully") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH GITHUB?" \
                && github_stuffs

            user_gh=$(grep --no-messages oauth_token: "${f[token]}" | awk '{print $2}')

            read -p $'\033[1;37m\nSIR, WHICH REPOSITORY DO U WANT?\nR: \033[m' repo

            for (( ; ; )); do

                [[ -d "${d[0]}${repo}" ]] \
                    && show "\n\t\t${c[RED]}REPO ALREADY DOWNLOADED" 1 \
                    && break

                if [[ $(grep successfully "${f[ssh]}") ]]; then

                    if [[ ! -z $(curl --silent "${l[1]}$(curl --silent --header "Authorization: Bearer ${user_gh}" "${l[0]}" | jq --raw-output .login)/${repo}" | jq .id) ]]; then

                        git clone --quiet "${l[2]}$(curl --silent --header "Authorization: Bearer ${user_gh}" "${l[0]}" | jq --raw-output .login)/${repo}.git" "${d[0]}${repo}" 2> "${f[null]}"

                        clear

                        read -p $'\033[1;37mWANT DOWNLOAD MORE REPO? \n[Y/N] R: \033[m' option

                        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                            repo='$'

                            read -p $'\033[1;37mWHICH IS \n[Y/N] R: \033[m' option

                            continue  # Simillar to pass

                        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        ~/.config/autostart/  # 0
    )

    f+=(
        [screen_saver]=~/.xscreensaver
        [gluqlo]=/tmp/gluqlo_1.1-1ubuntu2~xenial1_amd64.deb
        [screensaver_cinnamon]=/org/cinnamon/desktop/session/idle-delay
        [dskt]="${d[0]}"xscreensaver.desktop
        [new_gluqlo]=/usr/libexec/xscreensaver/gluqlo
        [old_gluqlo]=/usr/lib/xscreensaver/gluqlo
        [fix-broken]=/tmp/check_upgrade
    )

    local -a l=(
        'https://launchpad.net/~alexanderk23/+archive/ubuntu/ppa/+files/gluqlo_1.1-1ubuntu2~xenial1_amd64.deb'  # 0
    )

    local -a m=(
        'xscreensaver'  # 0
        'xscreensaver-gl-extra'  # 1
        'xscreensaver-data-extra'  # 2
        'gluqlo'  # 3
        'build-essential'  # 4
        'libsdl1.2-dev'  # 5
        'libsdl-ttf2.0-dev'  # 6
        'libsdl-gfx1.2-dev'  # 7
        'libx11-dev'  # 8
        'xscreensaver-demo'  # 9
        'dconf-editor'  # 10
    )

    [[ ! -d "${d[0]}" || $(stat --format="%U" "${d[0]}" 2>&-) != "${USER}" ]] \
        && show "\nBEFORE PROCEED, GIVING PERMISSIONS..." \
        && sudo mkdir --parents "${d[0]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 'fast'

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"



                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                return_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 'fast'

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[10]}"

        [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
            && show "\n${c[YELLOW]}${m[4]^^} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
            && sudo wget --quiet "${l[1]}" --output-document "${f[gluqlo]}" \
            && sudo dpkg --install "${f[gluqlo]}" &> "${f[null]}" \
            || show "\n${c[GREEN]}${m[4]^^} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]"

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

        ( nohup "${m[0]}" & ) &> "${f[null]}"

        sleep 6s

        sudo pkill "${m[0]}"

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

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && dconf write "${f[screensaver_cinnamon]}" 'uint32 0'

    [[ ! $(grep --no-messages 'gluqlo' "${f[screen_saver]}") ]] \
        && sudo sed --in-place '47 a\'"$(printf '%.s ' {0..7})"'gluqlo -root \n\\' "${f[screen_saver]}"

    # Changes not being applied?
    # xrdb -load ~/.xscreensaver && killall xscreensaver && xscreensaver -no-splash &
    sudo sed --in-place 's|lock:.*|lock:  True|g' "${f[screen_saver]}"

    sudo sed --in-place 's|mode:.*|mode:  one|g' "${f[screen_saver]}"

    sudo sed --in-place 's|selected:.*|selected:  1|g' "${f[screen_saver]}"

    sudo sed --in-place 's|lockTimeout:.*|LockTimeout: 0:03:00|g' "${f[screen_saver]}"

    echo; read -p $'\033[1;37mSIR, SHOULD I OPEN XSCREENSAVER? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            ( nohup "${m[9]}" & ) &> "${f[null]}"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

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
        [util_extract]=/etc/manage_files.sh
        [cron]=/var/spool/cron/"${USER}"
        [cron_bin]=/usr/bin/crontab
        [unattended]=/etc/apt/apt.conf.d/50unattended-upgrades
    )

    local -a l=(
        'https://raw.githubusercontent.com/marcopaganini/gnome-cedilla-fix/master/fix-cedilla'  # 0
        'https://gist.githubusercontent.com/rafaelribeiroo/d94647481b907cc3062c8ab594c5b89c/raw/08a660dc44a6cd6d7420e0b74a4595b452d234d5/manage_files.sh'  # 1
    )

    local -a m=(
        'dconf-editor'  # 0
        'numlockx'  # 1
        'vlc'  # 2
        'sublime-text'  # 3
        'brave-browser'  # 4
        'google-chrome-stable'  # 5
        'inotify-tools'  # 6
        'unattended-upgrades'  # 7
        'update-notifier-common'  # 8
        'language-pack-pt-base'  # 9
        'language-pack-gnome-pt-base'  # 10
        'hyphen-fi'  # 11
        'hyphen-ga'  # 12
        'hyphen-id'  # 13
    )

    install_packages "${m[0]}" "${m[1]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}"

    echo; read -p $'\033[1;37mSIR, DO YOU WANT UNPACK AUTOMATICALLY AT DOWNLOADS FOLDER? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            install_packages "${m[6]}"

            [[ ! -e "${f[util_extract]}" ]] \
                && sudo wget --quiet "${l[1]}" --output-document "${f[util_extract]}"

            [[ $(stat --format="%U" "${f[util_extract]}" 2>&-) != ${USER} ]] \
                && sudo chown "${USER}":"${USER}" "${f[util_extract]}"

            # crontab -u ${USER} -l
            [[ ! $(grep --no-messages upgrade "${f[cron]}") ]] \
                && sudo tee "${f[cron]}" > "${f[null]}" <<< "# MINUTE HOUR MONTH_DAY MONTH  WEEKDAY COMMAND
# 0-59    0-23 1-31       1-12 0-7           zsh MY_SCRIPT.sh
@reboot zsh ${f[util_extract]}" \
                && "${f[cron_bin]}" "${f[cron]}"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. DO YOU WANT A AUTOMATICALLY EXTRACT?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    echo; read -p $'\033[1;37mSIR, ARE YOU FACING ISSUES TO TYPE Ç ON YOUR KEYBOARD? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            [[ ! -e "${f[cedilha]}" ]] \
                && sudo curl --silent --location --output "${f[cedilha]}" --create-dirs "${l[0]}"

            [[ $(stat --format='%a' "${f[cedilha]}") -ne 755 ]] \
                && sudo chmod 755 "${f[cedilha]}"

            ( nohup "${f[cedilha]}" & ) &> "${f[out]}"

            for (( ; ; )); do

                [[ $(grep --no-messages 'Operation complete.' "${f[out]}") ]] \
                    && break \
                    || continue

            done

            echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    sudo reboot

                elif [[ "${option:0:1}" = @(n|N) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. ARE YOU HAVING ISSUES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    # STARTS UPGRADE AUTOMATICALLY
    if [[ ! $(grep --no-messages 'Update-Package' "${f[auto_upgrade]}") ]]; then

        install_packages "${m[7]}" "${m[8]}"

        echo; read -p $'\033[1;37mENTER YOUR EMAIL, '"${name[random]}"$': \033[m' email

        sudo sed --in-place "s|//Unattended-Upgrade::Mail \"\";|Unattended-Upgrade::Mail \"${email}\";|g" "${f[unattended]}"

        sudo sed --in-place 's|//Unattended-Upgrade::MailReport "on-change";|Unattended-Upgrade::MailReport "only-on-error";|g' "${f[unattended]}"

        sudo sed --in-place 's|//    "${distro_id}:${distro_codename}-updates";|    "${distro_id}:${distro_codename}-updates";|g' "${f[unattended]}"

        # sudo unattended-upgrades --dry-run --debug
        # Check periodically /lib/systemd/system/apt-daily.timer
        sudo tee "${f[auto_upgrade]}" > "${f[null]}" <<< 'APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "7";'

    fi  # ENDS UPGRADE AUTOMATICALLY

    # START GUI CHANGES
    dconf write "${f[paste]}" "'<Ctrl>v'"

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
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

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
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

    echo; read -p $'\033[1;37mSIR, CAN I TURN APPLICATIONS DEFAULT? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH USEFULL PACKAGES?" \
                && usefull_pkgs

            [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH SUBLIME TEXT?" \
                && sublime_stuffs

            echo; read -p $'\033[1;37mSIR, DO YOU PREFER BRAVE BROWSER OVER CHROME BROWSER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
                        && show "\nFIRST THINGS FIRST. DO U PASS THROUGH BRAVE?" \
                        && brave_stuffs

                    prefer='brave-browser'

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

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

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U WANT TO APPLY DEFAULT APPLICATIONS?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

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
audio/mpeg=rhythmbox.desktop

[Added Associations]
audio/mpeg=rhythmbox.desktop
video/x-matroska=vlc.desktop;
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

}
#======================#

#======================#
evoke_functions() {

    case "${choice}" in

        0|00) close_menu &> "${f[null]}" ;;
        1|01) alexa_stuffs && return_menu ;;
        2|02) bash_stuffs && return_menu ;;
        3|03) brave_stuffs && return_menu ;;
        4|04) deemix_stuffs && return_menu ;;
        5|05) docky_stuffs && return_menu ;;
        6|06) dualmonitor_stuffs && return_menu ;;
        7|07) github_stuffs && return_menu ;;
        8|08) chrome_stuffs && return_menu ;;
        9|09) flameshot_stuffs && return_menu ;;
        10) heroku_stuffs && return_menu ;;
        11) hide_devices && return_menu ;;
        12) minidlna_stuffs && return_menu ;;
        13) nvidia_stuffs && return_menu ;;
        14) postgres_stuffs && return_menu ;;
        15) postman_stuffs && return_menu ;;
        16) python_stuffs && return_menu ;;
        17) reduceye_stuffs && return_menu ;;
        18) ruby_stuffs && return_menu ;;
        19) sublime_stuffs && return_menu ;;
        20) tmate_stuffs && return_menu ;;
        21) usefull_pkgs && return_menu ;;
        22) workspace_stuffs && return_menu ;;
        23) xscreensaver_stuffs && return_menu ;;
        24) echo; show "KNOW YOUR LIMITS ${name[random]}..."

        echo; read -p $'\033[1;37mSIR, DO U TRUST ME TO DO MY OWN CHANGES? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                change_panelandgui

                echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                break

            else

                echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I DO MY OWN CHANGES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

        alexa_stuffs
        bash_stuffs
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

        sleep 0.1s; show "${c[RED]}=======================================================" 'fast'

        for line in "${!logo[@]}"; do

            show "    ${c[RED]}${logo[${line}]}" 'fast' && sleep 0.1s

        done

        sleep 0.1s; show "${c[RED]}=======================================================" 'fast'
        sleep 0.1s; show "${c[RED]}[ 00 ] ${c[WHITE]}EXIT ${e[door]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 01 ] ${c[WHITE]}ALEXA SKILLS ${e[alexa]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 02 ] ${c[WHITE]}BASH COLORFUL (OH-MY-BASH) ${e[paint]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 03 ] ${c[WHITE]}BRAVE BROWSER ${e[leo]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 04 ] ${c[WHITE]}DEEMIX ${e[headphone]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 05 ] ${c[WHITE]}DOCKY ${e[control]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 06 ] ${c[WHITE]}DUAL MONITOR SETUP ${e[landscape]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 07 ] ${c[WHITE]}GIT/GITHUB ${e[octopus]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 08 ] ${c[WHITE]}GOOGLE CHROME ${e[globe]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 09 ] ${c[WHITE]}FLAMESHOT ${e[camera]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 10 ] ${c[WHITE]}HEROKU ${e[rocket]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 11 ] ${c[WHITE]}HIDE WINDOWS DEVICES (DUAL BOOT) ${e[blind_monkey]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 12 ] ${c[WHITE]}MINIDLNA ${e[popcorn]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 13 ] ${c[WHITE]}NVIDIA DRIVER ${e[n]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 14 ] ${c[WHITE]}POSTGRES ${e[elephant]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 15 ] ${c[WHITE]}POSTMAN ${e[satellite]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 16 ] ${c[WHITE]}PYTHON ${e[snake]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 17 ] ${c[WHITE]}REDUCE EYE STRAIN ${e[moon]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 18 ] ${c[WHITE]}RUBY ${e[ruby]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 19 ] ${c[WHITE]}SUBLIME TEXT ${e[letters]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 20 ] ${c[WHITE]}TMATE ${e[magnet]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 21 ] ${c[WHITE]}USEFULL PROGRAMS ${e[diamond]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 22 ] ${c[WHITE]}WORKSPACE ${e[suitcase]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 23 ] ${c[WHITE]}XSCREENSAVER ${e[screensaver]}" 'fast'
        sleep 0.1s; show "${c[RED]}[ 24 ] ${c[WHITE]}ALL ${e[whale]}" 'fast'
        sleep 0.1s; show "${c[RED]}=======================================================" 'fast'

        read -n 2 -p $'\033[1;31m[    ]\033[m\033[4D' choice

        # The read command above is inline, so we need this echo to breakline
        echo

        [[ "${choice}" =~ ^[[:alpha:]]$ ]] \
            && echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}${c[WHITE]}\n\t\tPLEASE, ONLY NUMBERS!\n\n${c[WHITE]}WANT YOU RETURN SIR?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]} \
            && read trash_typed || evoke_functions "${choice}"

            [[ "${trash_typed:0:1}" == @(s|S|y|Y) ]] && return_menu \
            || close_menu && break

    done

}
#======================#

check_source