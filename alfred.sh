#!/usr/bin/env bash

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
)

# usefull files
declare -A f=(
    [askpass]=/lib/cryptsetup/askpass
    [bashrc]=~/.bashrc
    [custom_gnome]=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings
    [custom_first]=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/
    [custom_second]=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/
    [custom_print]=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/
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

    # If script is not being sourced
    if [[ "${BASH_SOURCE[0]}" -ef "${0}" ]]; then

        show "\n${c[RED-BLINK]}PLEASE, RUNS: source alfred.sh\n" 1 && exit

    else

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

            pip install --quiet "${package}"

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

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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
bash_stuffs() {

    source "${f[user_dirs]}"

    local -a d=(
        ~/.oh-my-bash  # 0
        ~/.fonts  # 1
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
        'curl'  # 1
        'git'  # 2
        'xdotool'  # 3
        'ble.sh'  # 4
    )

    if [[ -d "${d[0]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_packages "${m[1]}" "${m[2]}" "${m[3]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        # First /dev/null hide download progress, second hide thirty commands
        0> "${f[null]}" sh -c "$(curl --silent --show-error --fail --location ${l[0]})" &> "${f[null]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[powerline_otf]}" ]]; then

        # Hidden directories are owned by root, we must change owner to bash "read"
        # 2>&- hides: "can't stat: no such file..."
        [[ ! -d "${d[1]}" || $(stat -c "%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}" # Close error output

        # --location follows to last URL (github provides a few redirects)
        # --output write content to file
        curl --silent --location --output "${f[powerline_otf]}" --create-dirs "${l[1]}"

        # Update font cache
        sudo fc-cache --force "${d[1]}"

    fi

    if [[ ! -e "${f[powerline_conf]}" ]]; then

        [[ ! -d "${d[2]}" || $(stat -c "%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]%conf.d}"

        curl --silent --location --output "${f[powerline_conf]}" --create-dirs "${l[2]}"

        # Workaround to prevent terminal restart
        xdotool key Ctrl+plus && xdotool key Ctrl+minus

    fi

    # If show error when open oh-my-base, run command below
    # [[ $(grep --no-messages "check_for_upgrade.sh" "${f[config]}") ]] \
    #     && sudo sed --in-place --null-data 's|if \[ "$DISABLE_AUTO_UPDATE" != "true" \]; then\n  env OSH=$OSH DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT bash -f $OSH/tools/check_for_upgrade.sh\nfi||g' "${f[config]}"

    # Hide username from tty (hide #) and accepts pip freeze > requirements.txt
    [[ ! $(grep --no-messages DEFAULT_USER "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
# Hides user from terminal
#DEFAULT_USER=${USER}

# pip freeze > requirements.txt causes an error without it
set +o noclobber" # tee is an "sudo echo" that works, -a to append (>>)

    [[ ! $(grep --no-messages agnoster "${f[bashrc]}") && ! $(grep --no-messages 'plugins=(git' "${f[bashrc]}") ]] \
        && sudo sed --in-place 's|font|agnoster|g' "${f[bashrc]}" \
        && sudo sed --in-place --null-data 's|plugins=(\n  git\n  bashmarks\n)|plugins=(git python pip virtualenv)|g' "${f[bashrc]}"

    echo; read -p $'\033[1;37mSIR, SHOULD I INSTALL AUTOCOMPLETE LIKE IN OH-MY-ZSH? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            if [[ ! -e "${f[ble]}" ]]; then

                [[ ! -d "${d[3]}" ]] \
                    && show "\n${c[YELLOW]}${m[4]^^} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                    && git clone --quiet "${l[3]}" "${d[3]}"

                make --quiet --directory="${d[3]}" install PREFIX="${d[4]}"

                sudo rm --force --recursive "${d[3]}"

            else

                show "\n${c[GREEN]}${m[4]^^} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]"

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
    )

    f+=(
        [gpg]=/etc/apt/trusted.gpg.d/brave-browser-release.gpg
        [ppa]=/etc/apt/sources.list.d/brave-browser-release.list
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

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                sudo sed --in-place '/brave/d' "${d[0]}"*.json

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

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

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
        "${XDG_MUSIC_DIR}"/  # 0
        ~/.pyenv  # 1
        ~/Musicas\ Deemix/  # 2
        ~/.cache/thumbnails/fail  # 3
        ~/.config/deemix  # 4
        /etc/  # 5
    )

    f+=(
        [file]="${d[0]}"linux-x86_64-latest.deb
        [py_versions]=~/.pyenv/versions/
        [decrypt]=/etc/browser_cookie3_n.py
        [cookies]=/tmp/cookies
        [arl_value]=~/.config/deemix/.arl
        [cfg]=~/.config/deemix/config.json
    )

    local -a l=(
        'https://download.deemix.app/gui/linux-x86_64-latest.deb'  # 0
        'https://raw.githubusercontent.com/rachpt/lanzou-gui/master/lanzou/browser_cookie3_n.py'  # 1
        'https://www.python.org/doc/versions/'  # 2
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
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" =~ @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"





                remove_useless

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

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # Dependencies
        install_packages "${m[0]}" "${m[1]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[0]}"

        sudo dpkg --install "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

        latest=$(curl --silent "${l[2]}" | grep release/ | head -2 | tail -1 | awk --field-separator=/ '{print $5}')

        [[ ! -d "${d[1]}" && ! -e "${f[py_versions]}${latest}" ]] \
            && show "\nFIRST THINGS FIRST. DO U PASS THROUGH PY UPGRADE?" \
            && python_stuffs

        show "${c[GREEN]}\n\t    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[22]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_pip "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[15]}" "${m[16]}" "${m[17]}" "${m[18]}" "${m[19]}" "${m[20]}" "${m[21]}"

        if [[ ! -e "${f[decrypt]}" ]]; then

            show "\n${c[YELLOW]}${m[22]^^} ${c[WHITE]}${linen:${#m[22]}} [INSTALLING]"

            sudo wget --quiet "${l[1]}" --output-document "${f[decrypt]}"

        else

            show "\n${c[GREEN]}${m[22]^^} ${c[WHITE]}${linei:${#m[22]}} [INSTALLED]"

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    while [[ ! -e "${d[4]}" ]]; do

        show "\nRESTARTING DEEMIX TO GENERATE A LOT OF CONFIG FILES.\nWAIT..."

        ( nohup "${m[0]}" & ) &> "${f[null]}"

        take_a_break

        sudo pkill "${m[0]}"

    done

    if [[ ! -e "${f[arl_value]}" ]]; then

        for (( ; ; )); do

            python "${f[decrypt]}" &> "${f[cookies]}"

            [[ ! $(grep --no-messages 'Cookie arl' "${f[cookies]}") ]] \
                && show "\nDO U NEED TO LOG IN INTO DEEZER FROM CHROME BEFORE PROCEED" \
                && continue \
                || sudo tee --append "${f[arl_value]}" > "${f[null]}" <<< "$(grep --extended-regexp --only-matching 'Cookie arl=.{,192}' ${f[cookies]} | awk --field-separator== '{print $2}')" \
                && break

        done

    fi

    source "${f[locale]}"

    [[ $(echo "${LANG}" | awk --field-separator=. '{print $1}') = 'en_US' ]] \
        && sudo sed --in-place "s|\"downloadLocation\": \"${XDG_MUSIC_DIR}/deemix Music/\",|\"downloadLocation\": \"${XDG_MUSIC_DIR}/\",|g" "${f[cfg]}"

    sudo sed --in-place 's|"saveArtwork": true,|"saveArtwork": false,|g' "${f[cfg]}"

    sudo sed --in-place 's|"explicit": false,|"explicit": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"syncedLyrics": false,|"syncedLyrics": true,|g' "${f[cfg]}"

    sudo sed --in-place 's|"queueConcurrency": 9,|"queueConcurrency": 50,|g' "${f[cfg]}"

    # In pt_BR language, deemix not recognizes ú from Músicas.
    if [[ $(echo "${LANG}" | awk --field-separator=. '{print $1}') = 'pt_BR' ]]; then

        [[ ! -d "${d[2]}" || $(stat -c "%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

        sudo sed --in-place "s|\"downloadLocation\": \"${XDG_MUSIC_DIR}/deemix Music/\",|\"downloadLocation\": \"${d[2]}\",|g" "${f[cfg]}"

    fi

    [[ ! $(grep --no-messages '"albumTracknameTemplate": "%artist% - %title%"' "${f[cfg]}") ]] \
        && sudo sed --in-place 's|"albumTracknameTemplate": "%tracknumber% - %title%",|"albumTracknameTemplate": "%artist% - %title%",|g' "${f[cfg]}"

    [[ ! $(grep --no-messages 'alias ct' "${f[zshrc]}") ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
alias ct='rm --recursive --force ${d[3]}'"

    echo; read -p $'\033[1;37mSIR, SHOULD I OPEN DEEMIX? \n[Y/N] R: \033[m' option

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

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
dualmonitor_stuffs() {

    local -a d=(
        /usr/share/backgrounds/customized  # 0
    )

    f+=(
        [starwars]=/usr/share/backgrounds/customized/sw.jpg
        [stormtrooper]=/usr/share/backgrounds/customized/st.jpg
        [fightclub]=/usr/share/backgrounds/customized/cl.png
        [kyloren]=/usr/share/backgrounds/customized/kr.jpg
        [default]=/usr/share/backgrounds/customized/default_background.jpg
        [picture]=/org/cinnamon/desktop/background/picture-uri
        [picture_gnome]=/org/gnome/desktop/background/picture-uri
        [option]=/org/cinnamon/desktop/background/picture-options
        [option_gnome]=/org/gnome/desktop/background/picture-options
        [slideshow]=/org/cinnamon/desktop/background/slideshow/slideshow-enabled
        [source]=/org/cinnamon/desktop/background/slideshow/image-source
        [delay]=/org/cinnamon/desktop/background/slideshow/delay
    )

    # 3840x1080 wallpaper
    local -a l=(
        'https://images3.alphacoders.com/673/673177.jpg'  # 0
        'https://images4.alphacoders.com/885/885300.png'  # 1
        'https://www.dualmonitorbackgrounds.com/albums/SDuaneS/the-force-awakens-8.jpg'  # 2
        'https://www.dualmonitorbackgrounds.com/albums/SDuaneS/the-force-awakens-20.jpg'  # 3
    )

    local -a m=(
        'wallpapers'  # 0
        'dconf-editor'  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && -e "${d[0]}" ]]; then
        # 2>&- if dconf not installed

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linec:${#m[0]}} [APPLIED]\n" 1

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

        show "${c[GREEN]}\n\t  S${c[WHITE]}ETING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # --word-regexp don't match with disconnected
    # dual monitor wallpaper
    if [[ $(xrandr --query | grep --count --word-regexp connected) -eq 2 ]] ; then

        [[ ! -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[0]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

        [[ ! -e "${f[left]}" ]] \
            && curl --silent --output "${f[starwars]}" --create-dirs "${l[0]}"

        [[ ! -e "${f[fightclub]}" ]] \
            && curl --silent --output "${f[fightclub]}" --create-dirs "${l[1]}"

        [[ ! -e "${f[stormtrooper]}" ]] \
            && curl --silent --output "${f[stormtrooper]}" --create-dirs "${l[2]}"

        [[ ! -e "${f[kyloren]}" ]] \
            && curl --silent --output "${f[kyloren]}" --create-dirs "${l[3]}"

        [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*GNOME ]] \
            && dconf write "${f[picture_gnome]}" "'file://${f[starwars]}'" \
            && dconf write "${f[option_gnome]}" "'spanned'"

        [[ "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
            && dconf write "${f[picture]}" "'file://${f[starwars]}'" \
            && dconf write "${f[option]}" "'spanned'" \
            && dconf write "${f[slideshow]}" true \
            && dconf write "${f[source]}" "'directory://${d[1]}'" \
            && dconf write "${f[delay]}" 15

    else

        show "\nYOU DON'T HAVE DUAL MONITOR SETUP. EXITING..."

    fi

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
github_stuffs() {

    f+=(
        [config]=~/.gitconfig
        [config-ssh]=~/.ssh/config
        [tmp_success]=/tmp/check_success
        [all_title_gh]=/tmp/all_title
    )

    local -a l=(
        'https://api.github.com/user/keys'  # 0
        'https://git-scm.com/'  # 1
        'keyserver.ubuntu.com'  # 2
        'https://cli.github.com/packages'  # 3
        'https://api.github.com/rate_limit'  # 4
        'hkp://keyserver.ubuntu.com:80'  # 5
    )

    local -a m=(
        'git'  # 0
        'vim'  # 1
        'git-cola'  # 2
        'jq'  # 3
        'cryptsetup'  # 4
        'dconf-editor'  # 5
        'gh'  # 6
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[4]}"

    # We put ii  <pkg>[[:space:]] to get only what we need, git shows in more places (in version by the way)
    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") && \
        $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\t    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

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

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep "${l[3]}") && "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
            && sudo add-apt-repository --yes "${l[3]}" &> "${f[null]}" \
            && update

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[5]}" "${m[6]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

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
        && [[ ! $(grep --no-messages dark "${f[config]}") && $(dconf read "${f[gtk_theme_gnome]}") =~ .*dark.* ]] \
            && git config --global cola.icontheme dark

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && [[ ! $(grep --no-messages dark "${f[config]}") && $(dconf read "${f[gtk_theme]}") =~ .*Dark.* ]] \
            && git config --global cola.icontheme dark

    local=$(git --version | awk '{print $3}')

    latest=$(curl --silent "${l[1]}" | grep --after-context=1 '"version"' | tail -1 | xargs)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep git-core) ]] \
            && sudo add-apt-repository --yes ppa:git-core/ppa &> "${f[null]}"

        update && sudo apt install --assume-yes "${m[0]}" &> "${f[null]}"

    fi

    check_ssh

    [[ ! $(grep --no-messages github "${f[config-ssh]}") ]] \
        && sudo tee --append "${f[config-ssh]}" > "${f[null]}" <<< 'Host github.com
    Hostname ssh.github.com
    Port 443'

    echo; read -p $'\033[1;37mENTER YOUR USERNAME FROM GITHUB: \033[m' user

    # GITHUB STUFF
    for (( ; ; )); do

        echo; show "${c[RED]}${user^^}${c[WHITE]}, PLEASE CREATE A TOKEN IN https://github.com/settings/tokens\nPLEASE, ENABLE ${c[RED]}REPO/ADMIN:ORG/ADMIN:PUBLIC_KEY" 1

        echo; read -p $'\033[1;37mPASTE HERE YOUR TOKEN: \033[m' token

        [[ ! -e "${f[tmp_tk]}" ]] && sudo touch "${f[tmp_tk]}"

        sudo tee "${f[tmp_tk]}" > "${f[null]}" <<< "${token}"

        gh auth login --with-token < "${f[tmp_tk]}" &> "${f[tmp_success]}"

        # let --ignore-case as below, api github always changing sensitive case
        # best way to grep AND
        [[ \
            $(curl --silent --head --header "Authorization: token $(cat ${f[tmp_tk]})" "${l[0]}" | grep --extended-regexp --ignore-case '^x-oauth-scopes' | grep 'admin:org' | grep 'admin:public_key' | grep 'repo') &&
            ! -z "${f[tmp_success]}" \
        ]] \
            && break || show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" 1
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

                    show "\nTHERE'S AN INCONSISTENCY IN YOUR LOCAL/REMOTE KEYS\nFIXING..." 1

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


    ssh -o BatchMode=yes -T git@github.com &> "${f[ssh]}"

    [[ ! $(grep successfully "${f[ssh]}") ]] \
        && ssh -o BatchMode=yes -o StrictHostKeyChecking=no git@github.com &> "${f[null]}"

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

    source "${f[user_dirs]}"

    f+=(
        [file]="${XDG_DOWNLOAD_DIR}"/google-chrome-stable_current_amd64.deb
        [garbage]=/etc/default/google-chrome
    )

    local -a l=(
        'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'  # 0
    )

	if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

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
        ~/.config/Dharkael  # 0
        /tmp/  # 1
    )

    f+=(
        [config]=~/.config/Dharkael/flameshot.ini
        [config_gnome]=~/.config/flameshot/flameshot.ini
        [dskt]=~/.config/autostart/Flameshot.desktop
        [screenshot]=/org/cinnamon/desktop/keybindings/media-keys/screenshot
        [area_screenshot]=/org/cinnamon/desktop/keybindings/media-keys/area-screenshot
        [cmd]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/command
        [bdg]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/binding
        [name]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/name
        [custom]=/org/cinnamon/desktop/keybindings/custom-list
        [wayland]=/etc/gdm3/custom.conf
    )

    local -a m=(
        'flameshot'  # 0
        'dconf-editor'  # 1
        'gawk'  # 2
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}" "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    sudo sed --in-place 's|#WaylandEnable=false|WaylandEnable=false|g' "${f[wayland]}"

    # sudo systemctl restart gdm3
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

    source "${f[user_dirs]}"

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
        && dconf write "${f[prtscr1_gnome]}" "['']" \
        && dconf write "${f[prtscr2_gnome]}" "['']" \
        && dconf write "${f[prtscr3_gnome]}" "['']" \
        && dconf write "${f[custom_gnome]}" "['${f[custom_first]}', '${f[custom_second]}']" \
        && dconf write "${f[custom_print]}binding" "'Print'" \
        && dconf write "${f[custom_print]}command" "'flameshot gui --path ${XDG_PICTURES_DIR}'" \
        && dconf write "${f[custom_print]}name" "'Take a PrintScreen'"

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && dconf write "${f[screenshot]}" "['']" \
        && dconf write "${f[area_screenshot]}" "['']" \
        && dconf write "${f[cmd]}" "'flameshot gui --path ${XDG_PICTURES_DIR}'" \
        && dconf write "${f[bdg]}" "['Print', '<Shift>Print']" \
        && dconf write "${f[name]}" "'Flameshot'" \
        && dconf write "${f[custom]}" "['screenshot']"

    for (( ; ; )); do

        [[ -e "${f[config]}" || -e "${f[config_gnome]}" ]] \
            && break \
            || flameshot full -p "${d[1]}" \
            && show "\nSAVING A SCREENSHOT TO CREATE DEFAULT FILES..."

    done

    # If these instructions below stay in for, don't works
    sudo pkill "${m[0]}" && take_a_break

    [[ ! $(grep --no-messages '@Variant' "${f[config]}") && "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && source "${f[user_dirs]}" \
        && sudo tee "${f[config]}" > "${f[null]}" <<< "[General]
buttons=@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\x3\0\0\0\x3\0\0\0\n\0\0\0\v)
contastUiColor=@Variant(\0\0\0\x43\x2\xff\xff\x8aT\xff\xff\xff\xff\0\0)
disabledTrayIcon=true
drawColor=@Variant(\0\0\0\x43\x1\xff\xff\x80\x80\0\0\x80\x80\0\0)
drawThickness=0
savePath=${XDG_PICTURES_DIR}"

    [[ ! $(grep --no-messages '@Variant' "${f[config_gnome]}") && "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
        && source "${f[user_dirs]}" \
        && sudo tee "${f[config_gnome]}" > "${f[null]}" <<< "[General]
buttons=@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\x3\0\0\0\x3\0\0\0\n\0\0\0\v)
contastUiColor=@Variant(\0\0\0\x43\x2\xff\xff\x8aT\xff\xff\xff\xff\0\0)
disabledTrayIcon=true
drawColor=@Variant(\0\0\0\x43\x1\xff\xff\x80\x80\0\0\x80\x80\0\0)
drawThickness=0
savePath=${XDG_PICTURES_DIR}"

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

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

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

                show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!\n" 1

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
        /etc/udev/rules.d  # 0
    )

    f+=(
        [config]=/etc/udev/rules.d/99-hide-disks.rules
    )

    local -a m=(
        'devices'  # 0
    )

    check_devices=$(sudo fdisk --list 2>&- | grep 'HPFS/NTFS/exFAT' | awk '{print $1}')

    if [[ -z "${check_devices}" ]]; then

        show "\n  THERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!"

        return_menu

    else

        # --no-messages hide if file don't exists
        if [[ $(grep --no-messages ID_FS_UUID "${f[config]}") ]]; then

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${lineh:${#m[0]}} [HIDED]\n" 1

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

            show "${c[GREEN]}\n\tH${c[WHITE]}IDING ${c[GREEN]}WINDOWS ${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" 1

            show "${c[GREEN]}H${c[WHITE]}IDING ${c[GREEN]}DEVICE${c[WHITE]}"

            for device in "${check_devices}"; do

                devices+=(${device})

            done

            [[ ! -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) != ${USER} ]] \
                && mkdir --parents "${d[0]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

            for (( iterador=0; iterador<${#devices[@]}; iterador++ )); do

                tee --append "${f[config]}" > "${f[null]}" <<< 'ENV{ID_FS_UUID}=="'"$(blkid --match-tag UUID --output value ${devices[${iterador}]})"'",ENV{UDISKS_IGNORE}="1"'

            done

        fi

    fi

    echo; show "INITIALIZING CONFIGS..."

    sudo udevadm control --reload-rules && sudo udevadm trigger

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

    source "${f[user_dirs]}"

    local -a d=(
        "${XDG_VIDEOS_DIR}"  # 0
    )

    f+=(
        [config]=/etc/minidlna.conf
        [dft]=/etc/default/minidlna
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge --yes "${m[0]}" &> "${f[null]}"

                sudo rm --force "${f[config]}" "${f[default_minidlna]}"

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

        show "${c[GREEN]}\n\t I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! $(grep --no-messages Mídias "${f[config]}") ]]; then

        # automatic discover new files
        sudo sed --in-place "s|#inotify=yes|inotify=yes|g" "${f[config]}"

        # server_name
        sudo sed --in-place "s|#friendly_name=|friendly_name=Mídias|g" "${f[config]}"

        # location database
        sudo sed --in-place "s|#db_dir=/var/cache/minidlna|db_dir=...|g" "${f[config]}"

        # location logs
        sudo sed --in-place "s|#log_dir=/var/log|log_dir=...|g" "${f[config]}"

        # user to access this database
        sudo sed --in-place "s|#user=minidlna|user=root|g" "${f[config]}"

        sudo sed --in-place --null-data "s|/var/lib/minidlna|V,${d[0]}|5" "${f[config]}"

        sudo sed --in-place 's|#USER="minidlna"|USER="root"|g' "${f[dft]}"

        [[ $(systemctl is-active minidlna.service) = active ]] \
            && sudo service minidlna restart \
            && sudo service minidlna force-reload \
            || sudo service minidlna start

    fi

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

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

            show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

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

    local=$(apt show "${m[0]}-"* 2>&- | grep 'Version:' | awk --field-separator=':' '{print $2}' | xargs)

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
        [pspg]=$(which pspg)  # /usr/bin/pspg
    )

    local -a l=(
        'https://www.postgresql.org/media/keys/ACCC4CF8.asc'  # 0
        'https://www.postgresql.org/download/windows/'  # 1
        'https://www.linuxmint.com/download_all.php'  # 2
        'https://www.pgadmin.org/static/packages_pgadmin_org.pub'  # 3
    )

    local -a m=(
        'postgresql'  # 0
        'postgresql-client'  # 1
        'postgresql-contrib'  # 2
        'libpq-dev'  # 3
        'pgadmin4'  # 4
        'pspg'  # 5
        'gawk'  # 6
        'cryptsetup'  # 7
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[6]}[[:space:]]/ {print }") \
        && ! $(dpkg --list | awk "/ii  ${m[7]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[6]}" "${m[7]}"

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # lsb_release get os version name
        check_codename=$(curl --silent "${l[2]}" | grep --ignore-case -1 $(lsb_release --codename --short) | tail -1 | awk '{print $2}' | sed 's|</TD>||' | tr '[:upper:]' '[:lower:]')

        # 2> hides warning
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep PostgreSQL) ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | sudo apt-key add - &> "${f[null]}"

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep pgadmin) ]] \
            && sudo wget --quiet --output-document - "${l[3]}" | sudo apt-key add - &> "${f[null]}"

        # If returns warning about architeture, please write deb [ arch=amd64 ]
        [[ ! $(grep --no-messages "${check_codename}" "${f[ppa]}") ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb http://apt.postgresql.org/pub/repos/apt/ ${check_codename}-pgdg main" \
            && update

        [[ ! $(grep --no-messages "${check_codename}" "${f[ppa-pgadm]}") ]] \
            && sudo tee "${f[ppa-pgadm]}" > "${f[null]}" <<< "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/${check_codename} pgadmin4 main" \
            && update

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[4]}"  # "${m[3]}"

        echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

        # Or pg_createcluster 9.3 (version_number) main --start
        # /etc/init.d/postgresql start
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

    echo; show "INITIALIZING CONFIGS..."

    latest=$(curl --silent "${l[1]}" | grep scope | head -1 | tr --complement --delete 0-9,.)

    # Match perhaps with -10 or -11 etc (fixed installation)
    local=$(apt show "${m[0]}" 2>&- | grep 'Version:' | awk --field-separator=':' '{print $2}' | xargs)

    ( $(dpkg --compare-versions "${local}" lt "${latest}") ) \
        && show "\nPOSTGRES IS IN VERSION ${c[GREEN]}${latest}${c[WHITE]}, NOT IN ${c[RED]}${local:0:2} ${c[WHITE]}ANYMORE.\n" \
        && upgrade

    check_version=$(apt show "${m[0]}" 2>&- | grep Version | awk '{print $2}')

    f+=(
        [cfg]=/etc/postgresql/"${check_version:0:2}"/main/postgresql.conf
        [hba]=/etc/postgresql/"${check_version:0:2}"/main/pg_hba.conf
    )

    sudo sed --in-place "s|#listen_addresses|listen_addresses|g" "${f[cfg]}"

    read -p $'\033[1;37m\nDO U WANT A USER TO ACCESS THE CONSOLE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

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

                    read -p $'\033[1;37m\nENTER THE DATABASE NAME: \033[m' database

                    [[ $(sudo --user=postgres psql --command "SELECT 1 FROM pg_database WHERE datname='${database}'" | egrep "registro|row" | awk '{print $1}' | sed 's|(||') -ge 1 ]] \
                        && show "\nDATABASE ${c[RED]}${database^^}${c[WHITE]} ALREADY EXISTS. EXITING..." \
                        && break

                    sudo --user=postgres psql --command "CREATE DATABASE ${database}" &> "${f[null]}"

                    sudo --user=postgres psql --command "GRANT ALL PRIVILEGES ON DATABASE ${database} TO ${user}" &> "${f[null]}"

                    sudo --user=postgres psql --dbname="${database}" --command "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO ${user}" &> "${f[null]}"

                    # Check this resource running: "psql -U <user> -d <database>" and selecting all data from some table.
                    install_packages "${m[5]}"

                    [[ ! -e "${f[pspg_postgres]}" && ! -e "${f[pspg_user]}" ]] \
                        && sudo tee "${f[pspg_postgres]}" "${f[pspg_user]}" > "${f[null]}" <<< "\pset linestyle unicode
\pset border 2
\setenv PAGER '${f[pspg]} -bX --no-mouse'" \
                        && sudo chown postgres:postgres "${f[pspg_postgres]}" \
                        && sudo chown "${user}":"${user}" "${f[pspg_user]}"

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read resposta

                fi

            done

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read resposta

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
        "${XDG_DOWNLOAD_DIR}"/  # 1
        "${XDG_DOWNLOAD_DIR}"/InterceptorBridge_Linux_1.0.1  # 2
        /opt/Postman  # 3
        /tmp/  # 4
    )

    local -a m=(
        'postman'  # 0
        'gawk'  # 1
        'interceptor bridge'  # 2
        'google-chrome-stable'  # 3
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[1]}"

    f+=(
        [file]="${XDG_DOWNLOAD_DIR}"/Postman-linux-x64-latest.tar.gz
        [interceptor]="${XDG_DOWNLOAD_DIR}"/InterceptorBridge_Linux_1.0.1.zip
        [exe]="${XDG_DOWNLOAD_DIR}"/InterceptorBridge_Linux_1.0.1/InterceptorBridge_Linux/install_host.sh
        [uninstall]="${XDG_DOWNLOAD_DIR}"/InterceptorBridge_Linux_1.0.1/InterceptorBridge_Linux/uninstall_host.sh
        [bin]=/usr/local/bin/postman
        [run]=/opt/Postman/Postman
        [postman]=/usr/share/applications/postman.desktop
        [out]=/tmp/interceptor.out
        [principal]="${HOME}"/.postman/InterceptorBridge
    )

    local -a l=(
        'https://dl.pstmn.io/download/latest/linux64'  # 0
        'https://go.pstmn.io/interceptor-bridge-linux'  # 1
    )

    if [[ -f "${f[bin]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                rm --force "${f[postman]}" "${f[bin]}"

                rm --force --recursive "${d[3]}"

                [[ ! -e "${f[interceptor]}" ]] \
                    && wget --quiet "${l[1]}" --output-document "${f[interceptor]}"

                unzip "${d[1]}"*.zip -d "${d[4]}" &> "${f[null]}"

                sudo rm --force "${f[interceptor]}"

                [[ $(stat -c '%a' "${f[exe]}") -ne 776 ]] \
                    && sudo chmod 776 "${f[exe]}"

                ( nohup sudo "${f[exe]}" & ) &> "${f[out]}"

                for (( ; ; )); do

                    [[ $(grep --no-messages 'has been uninstalled' "${f[out]}") ]] \
                        && sudo rm --force --recursive "${d[2]}" \
                        && break \
                        || continue

                done

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

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]"

        [[ ! -e "${f[file]}" ]] \
            && curl --silent --location --output "${f[file]}" --create-dirs "${l[0]}"

        tar --extract --gzip --file="${f[file]}" --directory="${d[0]}" > "${f[null]}"

        sudo rm --force "${f[file]}"

        [[ ! -L "${f[bin]}" ]] \
            && sudo ln --symbolic "${f[run]}" "${f[bin]}"

        [[ ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
            && show "\nI NEED A BROWSER TO INSTALL INTERCEPTOR BRIDGE, TRANSFERRING..." \
            && chrome_stuffs

        if [[ ! -e "${f[principal]}" ]]; then

            show "\n${c[YELLOW]}${m[2]^^} ${c[WHITE]}${linen:${#m[2]}} [INSTALLING]"

            [[ ! -e "${f[interceptor]}" ]] \
                && wget --quiet "${l[1]}" --output-document "${f[interceptor]}"

            unzip "${d[1]}"*.zip -d "${d[4]}" &> "${f[null]}"

            sudo rm --force "${f[interceptor]}"

            ( nohup sudo "${f[exe]}" & ) &> "${f[out]}"

            for (( ; ; )); do

                [[ $(grep --no-messages 'has been installed' "${f[out]}") ]] \
                    && sudo rm --force --recursive "${d[2]}" \
                    && break \
                    || continue

            done

        else

            show "\n${c[GREEN]}${m[2]^^} ${c[WHITE]}${linei:${#m[2]}} [INSTALLED]"

        fi

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
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[15]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[15]}"

    # https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body
    local -a d=(
        ~/.pyenv  # 0
        ~/.pyenv/versions/$(curl --silent "${l[2]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]" 1

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

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # pip versions
    local=$(apt show "${m[1]}" 2>&- | grep 'Version:' | awk --field-separator=':' '{print $2}' | xargs)

    latest=$(curl --silent "${l[0]}" | grep --after-context=2 '_le' | tail -1 | awk '{print $2}')

    ( $(dpkg --compare-versions "${local}" lt "${latest}") ) \
        && pip install --no-warn-script-location --quiet --upgrade pip

    # python versions
    # apt version python don't works, because it shows only packages added by
    # apt and pyenv download/install packages from curl
    local=$(python -c 'from platform import python_version as v; print(v())')

    latest=$(curl --silent "${l[2]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        echo; read -p $'\033[1;37mSIR, SHOULD I UPGRADE VERSION FROM '${local}' TO '${latest}$'? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[4]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

                # Dependencies
                install_packages "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" "${m[12]}" "${m[13]}" "${m[14]}" "${m[17]}"

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

    f+=(
        [apt_history]=/var/log/apt/history.log
    )

    # Get last upgrades
    last=$(grep --no-messages Start-Date "${f[apt_history]}" | tail -1 | awk '{print $2}')

    # Best data format, dd/mm/yyyy
    date=$(date -d "${last}" +"%d/%m/%Y")

    [[ -e "${f[apt_history]}" ]] && show "UPGRADING PACKAGES... (LAST TIME: ${c[CYAN]}${date}${c[WHITE]})" \
        || show "UPGRADING PACKAGES... (LAST TIME: ${c[CYAN]}NEVER${c[WHITE]})"

    sudo apt update &> "${f[null]}"; sudo apt upgrade --yes &> "${f[null]}"

}
#======================#

#======================#
reduceye_stuffs() {

    local -a d=(
        ~/.config/redshift/  # 0
    )

    f+=(
        [config]=~/.config/redshift/redshift.conf
        [dskt]=~/.config/autostart/redshift-gtk.desktop
    )

    local -a m=(
        'redshift'  # 0
        'redshift-gtk'  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\t I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}" "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[config]}" ]]; then

        [[ ! -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) != ${USER} ]] \
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

   if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep Yarn) ]] \
            && sudo wget --quiet --output-document - "${l[3]}" | sudo apt-key add - &> "${f[null]}"

        [[ ! $(grep --no-messages yarnpkg "${f[ppa]}") ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb https://dl.yarnpkg.com/debian/ stable main" \
            && update

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

                show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[3]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

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
        ~/.config/sublime-text  # 0
        ~/.config/sublime-text/Installed\ Packages  # 1
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org  # 2
        ~/.pyenv  # 3
        /.Trash-1000/  # 4
    )

    f+=(
        [file]=~/.pyenv/shims/python
        [config]=~/.config/sublime-text/Packages/User/Preferences.sublime-settings
        [hosts]=/etc/hosts
        [ppa]=/etc/apt/sources.list.d/sublime-text.list
        [exec]=/opt/sublime_text/sublime_text
        [license]=~/.config/sublime-text/Local/License.sublime_license
        [pkg_ctrl]=~/.config/sublime-text/Installed\ Packages/Package\ Control.sublime-package
        [pkgs]=~/.config/sublime-text/Packages/User/Package\ Control.sublime-settings
        [anaconda]=~/.config/sublime-text/Packages/Anaconda/Anaconda.sublime-settings
        [keymap]=~/.config/sublime-text/Packages/User/Default\ \(Linux\).sublime-keymap
        [REPL]=~/.config/sublime-text/Packages/SublimeREPL/SublimeREPL.sublime-settings
        [REPLPY]=~/.config/sublime-text/Packages/SublimeREPL/config/Python/Main.sublime-menu
        [REPLPYT]=~/.config/sublime-text/Packages/SublimeREPL/sublimerepl.py
        [recently_used]=~/.local/share/recently-used.xbel
    )

    declare -a l=(
        'https://download.sublimetext.com/sublimehq-pub.gpg'  # 0
        'https://download.sublimetext.com/ apt/stable/'  # 1
        'https://packagecontrol.io/Package%20Control.sublime-package'  # 2
        'https://www.python.org/doc/versions/'  # 3
        'https://packagecontrol.io/packages/'  # 4
    )

    declare -a m=(
        'apt-transport-https'  # 0
        'sublime-text'  # 1
        'gawk'  # 2
    )

    [[ ! $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") ]] \
        && show "\nBEFORE PROCEED, LET'S INSTALL SOME REQUIREMENTS..." \
        && install_packages "${m[2]}"

	if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[1]^^} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

		# 2> hides
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
		[[ ! $(sudo apt-key list 2> "${f[null]}" | grep Sublime) ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | sudo apt-key add - &> "${f[null]}"

        [[ ! $(grep --no-messages sublimetext "${f[ppa]}") ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb ${l[1]}" \
            && update

        install_packages "${m[0]}" "${m[1]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    while [[ ! -e "${d[0]}" ]]; do

        show "\nRESTARTING SUBLIME TO GENERATE A LOT OF CONFIG FILES.\nWAIT..."

        ( nohup subl & ) &> "${f[null]}"

        take_a_break

        sudo pkill subl

    done






    # Adding license key
    [[ ! $(grep --no-messages You "${f[license]}") ]] \
        && sudo tee "${f[license]}" > "${f[null]}" <<< 'Paying $99 USD For A License Is Stupid.'

    # Remove file changes history
    # sudo rm --force "${f[recently_used]}"

    if [[ ! -e "${f[pkg_ctrl]}" ]]; then

        [[ ! -d "${d[1]}" || $(stat -c "%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}"

        curl --silent --output "${f[pkg_ctrl]}" --create-dirs "${l[2]}"

    fi

    [[ ! $(grep --no-messages packages "${f[pkgs]}") ]] \
        && sudo tee "${f[pkgs]}" > "${f[null]}" <<< '{
    "installed_packages": ["Anaconda", "Djaneiro", "Restart", "SublimeREPL", "Sublimerge Pro", "Dracula Color Scheme", "AutoPEP8", "Pretty JSON"]
}' \
        && sudo chown "${USER}":"${USER}" "${f[pkgs]}"

    read -p $'\033[1;37m\nSIR, WANT TO INSTALL SOME ADITTIONAL PACKAGE FROM PACKAGE CONTROL? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            echo; read -p $'\033[1;37mTITLE (CASE SENSITIVE): \033[m' pkg

            [[ $(curl --silent --write-out %{http_code} --output "${f[null]}" "${l[4]}""${pkg}") -ne 200 ]] \
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

                echo; show "\t\t  REPO ALREADY ${c[RED]}PRE-INSTALLED${c[WHITE]}"

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

            latest=$(curl --silent "${l[3]}" | grep release | head -2 | tail -1 | awk --field-separator=/ '{print $5}')

            [[ ! -d "${d[3]}" && ! -e "${f[file]}${latest}" ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH PY UPGRADE?" \
                && python_stuffs

            sudo sed --in-place 's|"swallow_startup_errors": false|"swallow_startup_errors": true|g' "${f[anaconda]}"

            sudo tee "${f[keymap]}" > "${f[null]}" <<< '[
    { "keys": ["ctrl+p"], "command": "run_existing_window_command", "args": {
        "id": "repl_python_run", "file": "config/Python/Main.sublime-menu" }
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

            [[ ! $(grep --no-messages '"view_id"' "${f[REPLPY]}") ]] \
                && sudo sed --in-place 's|Language",|Language",\n\t\t\t\t\t\t"view_id": "*REPL* [python]",|g' "${f[REPLPY]}"

            sudo sed --in-place 's|if view.id|if view.name|g' "${f[REPLPYT]}"

            # PY don't run if mix tabs with space
            [[ ! $(grep --no-messages 'focus_view(found)' "${f[REPLPYT]}") ]] \
                && sudo sed --in-place "s|found = view|found = view\n                    window.focus_view(found)|g" "${f[REPLPYT]}"

            break

        fi

    done

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
upgrade() {

    f+=(
        [apt_history]=/var/log/apt/history.log
    )

    # Get last upgrades
    last=$(grep --no-messages Start-Date "${f[apt_history]}" | tail -1 | awk '{print $2}')

    # Best data format, dd/mm/yyyy
    date=$(date -d "${last}" +"%d/%m/%Y")

    [[ -e "${f[apt_history]}" ]] && show "UPGRADING PACKAGES... (LAST TIME: ${c[CYAN]}${date}${c[WHITE]})" \
        || show "UPGRADING PACKAGES... (LAST TIME: ${c[CYAN]}NEVER${c[WHITE]})"

    sudo apt update &> "${f[null]}"; sudo apt upgrade --yes &> "${f[null]}"

}
#======================#

#======================#
tmate_stuffs() {

    local -a m=(
        'tmate'  # 0
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" 1

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

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

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
        ~/.SpaceVim  # 1
        ~/.config/vlc/  # 2
        /etc/  # 3
        /etc/series-renamer  # 4
    )

    f+=(
        [cfg]=~/.SpaceVim/autoload/SpaceVim.vim
        [load]=~/.config/nvim/init.vim
        [autokey]=~/.config/autostart/autokey-gtk.desktop
        [lock]=/etc/apt/preferences.d/nosnap.pref
        [out]=/tmp/spacevim.out
        [vlc]=~/.config/vlc/vlcrc
        [series]=/etc/series-renamer/RenameMyTVSeries
        [rar-file]=/etc/RenameMyTVSeries-2.0.10-Linux64bit.tar.gz
        [startup]=~/.local/share/applications/rename-series.desktop
        [icon]=/etc/series-renamer/icons/128x128.png
    )

    local -a l=(
        'https://spacevim.org/install.sh'  # 0
        'https://www.tweaking4all.com/downloads/video/RenameMyTVSeries-2.0.10-Linux64bit.tar.gz'  # 1
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
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[4]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[5]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[13]}[[:space:]]/ {print }") \
        && $(dpkg --list | awk "/ii  ${m[15]}[[:space:]]/ {print }") ]]; then

        show "\n${c[GREEN]}${m[6]^^} ${c[WHITE]}${linei:${#m[6]}} [INSTALLED]" 1

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

        show "${c[GREEN]}\n     I${c[WHITE]}NSTALLING ${c[GREEN]}${m[6]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}"

        [[ -e "${f[lock]}" ]] && sudo rm --force "${f[lock]}"

        update && install_packages "${m[4]}" "${m[5]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[13]}" "${m[15]}" "${m[17]}" "${m[18]}"

        [[ $(snap list 2>&- | grep "${m[11]}") ]] \
            && show "\n${c[GREEN]}${m[11]^^} ${c[WHITE]}${linei:${#m[11]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[11]^^} ${c[WHITE]}${linen:${#m[11]}} [INSTALLING]" \
            && snap install "${m[11]}" &> "${f[null]}"

        [[ $(snap list 2>&- | grep "${m[14]}") ]] \
            && show "\n${c[GREEN]}${m[14]^^} ${c[WHITE]}${linei:${#m[14]}} [INSTALLED]" \
            || show "\n${c[YELLOW]}${m[14]^^} ${c[WHITE]}${linen:${#m[14]}} [INSTALLING]" \
            && snap install "${m[14]}" &> "${f[null]}"

        [[ -d "${d[1]}" ]] \
            && show "\n${c[GREEN]}${m[12]^^} ${c[WHITE]}${linei:${#m[12]}} [INSTALLED]"
            || show "\n${c[YELLOW]}${m[12]^^} ${c[WHITE]}${linen:${#m[12]}} [INSTALLING]" \
            && bash -c "$(curl --silent --location ${l[0]})" &> "${f[out]}"

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

            echo; read -p $'\033[1;37mSIR, SHOULD I OPEN RENAME TV SERIES? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    ( nohup "${f[series]}" & ) &> "${f[null]}"

                    break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I OPEN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            show "\n${c[GREEN]}${m[16]^^} ${c[WHITE]}${linei:${#m[16]}} [INSTALLED]"

        fi

        for (( ; ; )); do

            [[ $(grep --no-messages "Updating font cache" "${f[out]}") ]] \
                && break \
                || continue

        done

    fi

    echo; show "INITIALIZING CONFIGS..."

    while [[ ! -e "${d[2]}" ]]; do

        show "\nRESTARTING VLC TO GENERATE A LOT OF CONFIG FILES.\nWAIT..."

        ( nohup "${m[1]}" & ) &> "${f[null]}"

        take_a_break

        sudo pkill "${m[1]}"

    done

    sudo sed --in-place 's|#avcodec-hw=any|avcodec-hw=none|g' "${f[vlc]}"

    sudo sed --in-place 's|#freetype-rel-fontsize=0|freetype-rel-fontsize=12|g' "${f[vlc]}"

    sudo sed --in-place 's|#freetype-color=16777215|freetype-color=16776960|g' "${f[vlc]}"

    # These character class match once only, so we need +
    # https://www.petefreitag.com/cheatsheets/regex/character-classes/
    [[ $(grep --no-messages --extended-regexp '([[:space:]]+ = )1' "${f[cfg]}") ]] \
        && sed --in-place --regexp-extended 's|([[:space:]]+ = )1|\10|g' "${f[cfg]}"

    [[ ! $(grep --no-messages AutoKey "${f[autokey]}") ]] \
        && sudo tee "${f[autokey]}" > "${f[null]}" <<< '[Desktop Entry]
Name=AutoKey
GenericName=Keyboard Automation
Comment=Program keyboard shortcuts
Exec=autokey-gtk -c
Terminal=false
Type=Application
Icon=autokey
Categories=GNOME;GTK;Utility;
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
Name[en_US]=AutoKey
Comment[en_US]=Program keyboard shortcuts
X-GNOME-Autostart-Delay=0'

    # set wrap breaks line when is too long
    # set mouse allow mouse highligh text
    [[ ! $(grep --no-messages mouse "${f[load]}") ]] \
        && sudo tee --append "${f[load]}" > "${f[null]}" <<< 'set mouse=a
set wrap'

    [[ ! $(grep --no-messages 'alias vk' "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
alias vk='kill -9 \$(ps aux | grep vlc | awk \"{print \$2}\") &> ${f[null]}'"

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
    )

    # only here is global because invokes a new function
    l=(
        git@github.com:"${user}"/  # 0
    )

    if [[ -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) = ${USER} ]]; then

        show "\n${c[GREEN]}${d[0]^^} ${c[WHITE]}${linec:${#d[0]}} [CREATED]\n" 1

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

        show "${c[GREEN]}\n\t  C${c[WHITE]}REATING ${c[GREEN]}${d[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" 1

        show "${c[GREEN]}C${c[WHITE]}REATING ${c[GREEN]}${d[0]^^}${c[WHITE]}"

        sudo mkdir --parents "${d[0]}" > "${f[null]}"

        sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

    fi

    echo; show "INITIALIZING CONFIGS..."

    # Lost your bookmarks? Run xdg-user-dirs-gtk-update
    [[ ! $(grep --no-messages workspace "${f[bookmarks]}") ]] \
        && sudo tee --append "${f[bookmarks]}" > "${f[null]}" <<< $'file:///workspace \360\237\221\211 Workspace'

    echo; read -p $'\033[1;37mSIR, SHOULD I DOWNLOAD ANY REPO FROM UR GITHUB ACCOUNT? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            [[ ! -e "${f[tmp_tk]}" ]] \
                && show "\nWE NEED YOUR GITHUB CREDENTIALS, TRANSFERRING..." \
                && github_stuffs
                # || return 1

            read -p $'\033[1;37m\nSIR, WHICH REPOSITORY DO U WANT?\nR: \033[m' repo

            for (( ; ; )); do

                [[ -d "${d[0]}${repo}" ]] \
                    && show "\n\t\t${c[RED]}REPO ALREADY DOWNLOADED" 1 \
                    && break

                ssh -o BatchMode=yes -T git@github.com &> "${f[ssh]}"

                if [[ $(grep successfully "${f[ssh]}") ]]; then

                    git ls-remote "${l[0]}${repo}" &> "${f[check_repo]}"

                    if [[ $(grep HEAD "${f[check_repo]}") ]]; then

                        git clone --quiet "${l[0]}${repo}.git" "${d[0]}${repo}" 2> "${f[null]}"

                        clear

                        read -p $'\033[1;37mWANT DOWNLOAD MORE REPO? \n[Y/N] R: \033[m' option

                        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                            clear && continue  # Simillar to pass

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

                    show "\nDID YOU MISS SOME CONFIG AT GITHUB?"

                    github_stuffs

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
change_panelandgui() {

    local -a d=(
        ~/.local/share/cinnamon/applets/  # 0
        ~/.local/share/cinnamon/applets/betterlock  # 1
        ~/.local/share/cinnamon/applets/separator2@zyzz  # 2
        ~/.rbenv  # 3
        ~/.local/share/cinnamon/applets/force-quit@cinnamon.org  # 4
        /boot/grub/themes/linuxmint-2k/  # 5
        /usr/share/icons  # 6
        ~/.oh-my-bash/  # 7
        ~/.fonts  # 8
        ~/.config/autostart  # 9
    )

    f+=(
        [automount]=/org/cinnamon/desktop/media-handling/automount
        [automount_open]=/org/cinnamon/desktop/media-handling/automount-open
        [background_grub_jpg]=/boot/grub/themes/*/background.jpg
        [background_grub_png]=/boot/grub/themes/*/background.png
        [old_background_grub]=/boot/grub/themes/*/background_old.png
        [open_folder]=/org/cinnamon/desktop/media-handling/autorun-x-content-open-folder
        [start_app]=/org/cinnamon/desktop/media-handling/autorun-x-content-start-app
        [autostart_blacklist]=/org/cinnamon/cinnamon-session/autostart-blacklist
        [calendar]=~/.cinnamon/configs/calendar@cinnamon.org/
        [capslock]=~/.local/share/cinnamon/applets/betterlock.zip
        [computer_icon]=/org/nemo/desktop/computer-icon-visible
        [forceqt]=~/.local/share/cinnamon/applets/force-quit@cinnamon.org.zip
        [grouped]=~/.cinnamon/configs/grouped-window-list@cinnamon.org/
        [grub-modified]=/etc/default/grub
        [volumes_icon]=/org/nemo/desktop/volumes-visible
        [default_sort_order]=/org/nemo/preferences/default-sort-order
        [default_sort_reverse]=/org/nemo/preferences/default-sort-in-reverse-order
        [default_sort_reverse_gnome]=/org/gnome/nautilus/preferences/default-sort-in-reverse-order
        [grub]=/boot/grub/grub.cfg
        [home_icon]=/org/nemo/desktop/home-icon-visible
        [icon_theme]=/org/cinnamon/desktop/interface/icon-theme
        [icon_theme_gnome]=/org/gnome/desktop/interface/icon-theme
        [login-file]=/org/cinnamon/sounds/login-file
        [looking_glass]=/org/cinnamon/desktop/keybindings/looking-glass-keybinding
        [numlock]=/etc/lightdm/slick-greeter.conf
        [paste]=/org/gnome/terminal/legacy/keybindings/paste
        [path-ogg]=/usr/share/mint-artwork/sounds/manias.ogg
        [separator2]=~/.local/share/cinnamon/applets/separator2@zyzz.zip
        [screensaver]=/org/cinnamon/desktop/keybindings/media-keys/screensaver
        [show_hidden]=/org/nemo/preferences/show-hidden-files
        [show_hidden_gnome]=/org/gnome/nautilus/preferences/show-hidden-files
        [thumbnail-limit]=/org/nemo/preferences/thumbnail-limit
        [thumbnail-limit-gnome]=/org/gnome/nautilus/preferences/thumbnail-limit
        [reverse-order]=/org/nemo/preferences/default-sort-in-reverse-order
        [default-order]=/org/nemo/preferences/default-sort-order
        [alfred]=/usr/share/icons/jenkins-128x128.png
        [meslo]=~/.fonts/Meslo.zip
        [grub2_theme]=/tmp/grub2-theme-mint_1.2.2_all.deb
        [trash_gnome]=/org/gnome/shell/extensions/dash-to-dock/show-trash
        [mount_gnome]=/org/gnome/shell/extensions/dash-to-dock/show-mounts
    )

    local -a l=(
        'https://cinnamon-spices.linuxmint.com/files/applets/betterlock.zip'  # 0
        'https://cinnamon-spices.linuxmint.com/files/applets/separator2@zyzz.zip'  # 1
        'https://docs.google.com/uc?export=download&id=1gQQ6Xj2egQBZW9xugCK02NSnQEQPjE3V'  # 2
        'https://cinnamon-spices.linuxmint.com/files/applets/force-quit@cinnamon.org.zip'  # 3
        'https://vignette4.wikia.nocookie.net/despicableme/images/6/6b/Gru_sunglasses.jpg/revision/latest?cb=20140218054928'  # 4
        'https://icon-icons.com/downloadimage.php?id=170552&root=2699/PNG/128/&file=jenkins_logo_icon_170552.png'  # 5
        'https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip'  # 6
        'https://ftp5.gwdg.de/pub/linux/debian/mint/packages/pool/main/g/grub2-theme-mint/grub2-theme-mint_1.2.2_all.deb'  # 7
    )

    local -a m=(
        'dconf-editor'  # 0
        'numlockx'  # 1
        'grub2-theme-mint-2k'  # 2
        'ruby'  # 3
        'colorls'  # 4
        'transmission-gtk'  # 5
        'nemo-mediainfo-tab'  # 6
        'neofetch'  # 7
        'ruby-colorize'  # 8
        'imagemagick'  # 9
        'gawk'  # 10
        'grub2-theme-mint'  # 11
    )

    # START ADITTION ICON ALFRED
    [[ ! -d "${d[6]}" || $(stat -c "%U" "${d[6]}" 2>&-) != "${USER}" ]] \
        && sudo mkdir --parents "${d[6]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[6]}"

    [[ ! -e "${f[alfred]}" ]] \
        && curl --silent --location --output "${f[alfred]}" --create-dirs "${l[5]}"  # END ICON

    install_packages "${m[0]}" "${m[1]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}"

    # START AUTOSTART APPLICATIONS
    [[ ! -d "${d[9]}" || $(stat -c "%U" "${d[9]}" 2>&-) != "${USER}" ]] \
        && sudo mkdir --parents "${d[9]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[9]}"  # END AUTOSTART APPLICATIONS

    # START GRUB WALLPAPER CHANGE
    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && install_packages "${m[2]}"

    if [[ $(dpkg --list | awk "/ii  ${m[11]}[[:space:]]/ {print }") && "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]]; then

        show "\n${c[GREEN]}${m[11]^^} ${c[WHITE]}${linei:${#m[11]}} [INSTALLED]"

    else

        show "\n${c[YELLOW]}${m[11]^^} ${c[WHITE]}${linen:${#m[11]}} [INSTALLING]"

        [[ ! -e "${f[grub2_theme]}" ]] \
            && wget --quiet "${l[7]}" --output-document "${f[grub2_theme]}" \
            && sudo dpkg --install "${f[grub2_theme]}" &> "${f[null]}" \
            && sudo rm --force "${f[file]}"

    fi

    [[ ! -d "${d[5]}" || $(stat -c "%U" "${d[5]}" 2>&-) != "${USER}" ]] \
        && sudo mkdir --parents "${d[5]}" > "${f[null]}" \
        && sudo chown --recursive "${USER}":"${USER}" "${d[5]}"

    [[ ! -e "${f[old_background_grub]}" && -e "${f[background_grub_png]}" ]] \
        && mv "${f[background_grub_png]}" "${f[old_background_grub]}" \
        && [[ ! -e "${f[background_grub_jpg]}" ]] \
            && wget --quiet "${l[5]}" --output-document "${f[background_grub_jpg]}" \
            && convert "${f[background_grub_jpg]}" "${f[background_grub_png]}" \
            && rm --force "${f[background_grub_jpg]}"  # END WALLPAPER CHANGE

    # START GRUB RESOLUTION CHANGE
    [[ ! $(grep --no-messages '1920x1080' "${f[grub-modified]}") ]] \
        && sudo sed --in-place 's|#GRUB_GFXMODE=640x480|GRUB_GFXMODE=1920x1080|g' "${f[grub-modified]}" \
        && sudo update-grub &> "${f[null]}" # END RESOLUTION

    # START FIXING CHROME DETECTING NETWORK CHANGE (CONNECTION WAS INTERRUPTED)
    [[ ! $(grep --no-messages 'ipv6.disable=1' "${f[grub-modified]}") ]] \
        && sudo sed --in-place 's|GRUB_CMDLINE_LINUX=""|GRUB_CMDLINE_LINUX="ipv6.disable=1"|g' "${f[grub-modified]}" \
        && sudo update-grub &> "${f[null]}"  # END

    # START PPA ADDITION
    [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep transmissionbt) && "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && sudo add-apt-repository --yes ppa:transmissionbt/ppa &> "${f[null]}" \
        && update \
        && sudo apt install --assume-yes "${m[5]}" &> "${f[null]}"  # END PPA

    # START PPA ADDITION
    [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"* | grep caldas-lopes) ]] \
        && sudo add-apt-repository --yes ppa:caldas-lopes/ppa &> "${f[null]}" \
        && update \
        && sudo apt install --assume-yes "${m[6]}" &> "${f[null]}"  # END PPA

    # START APPLETS STUFFS
    if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]]; then
        if [[ ! -d "${d[1]}" && ! -d "${d[2]}" && ! -d "${d[4]}" ]]; then

            [[ ! -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) != "${USER}" ]] \
                && sudo mkdir --parents "${d[0]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

            [[ ! -e "${f[capslock]}" ]] \
                && wget --quiet "${l[0]}" --output-document "${f[capslock]}" \
                && unzip "${d[0]}"*.zip -d "${d[0]}" &> "${f[null]}" \
                && sudo rm --force "${f[capslock]}"

            [[ ! -e "${f[separator2]}" ]] \
                && wget --quiet "${l[1]}" --output-document "${f[separator2]}" \
                && unzip "${d[0]}"*.zip -d "${d[0]}" &> "${f[null]}" \
                && sudo rm --force "${f[separator2]}"

            [[ ! -e "${f[forceqt]}" ]] \
                && wget --quiet "${l[3]}" --output-document "${f[forceqt]}" \
                && unzip "${d[0]}"*.zip -d "${d[0]}" &> "${f[null]}" \
                && sudo rm --force "${f[forceqt]}"

            dconf write "${f[enabled_applets]}" "['panel1:left:0:menu@cinnamon.org:0', 'panel1:left:1:show-desktop@cinnamon.org:1', 'panel1:left:2:grouped-window-list@cinnamon.org:2', 'panel1:right:3:removable-drives@cinnamon.org:3', 'panel1:right:4:separator@cinnamon.org:4', 'panel1:right:5:separator@cinnamon.org:5', 'panel1:right:6:notifications@cinnamon.org:6', 'panel1:right:7:separator@cinnamon.org:7', 'panel1:right:8:separator@cinnamon.org:8', 'panel1:right:9:force-quit@cinnamon.org:9', 'panel1:right:10:separator@cinnamon.org:10', 'panel1:right:11:separator@cinnamon.org:11', 'panel1:right:12:xapp-status@cinnamon.org:12', 'panel1:right:13:separator@cinnamon.org:13', 'panel1:right:14:separator@cinnamon.org:14', 'panel1:right:15:network@cinnamon.org:15', 'panel1:right:16:separator@cinnamon.org:16', 'panel1:right:17:separator@cinnamon.org:17', 'panel1:right:18:betterlock:18', 'panel1:right:19:separator2@zyzz:19', 'panel1:right:20:calendar@cinnamon.org:20']"

            # use custom format
            sudo sed --in-place --null-data 's|false|true|3' "${f[calendar]}"*.json

            sudo sed --in-place --null-data 's|false|true|4' "${f[calendar]}"*.json

            sudo sed --in-place --null-data 's|%A, %B %e, %H:%M|%e.  %B, %H:%M|2' "${f[calendar]}"*.json

        fi
    fi  # END APPLETS

    # START NUMLOCK ALWAYS ACTIVE AT STARTUP
    [[ ! -e "${f[numlock]}" && "${XDG_CURRENT_DESKTOP:u}" =~ .*CINNAMON ]] \
        && sudo tee "${f[numlock]}" > "${f[null]}" <<< '[Greeter]
activate-numlock=true'

    [[ $(grep --no-messages false "${f[numlock]}") ]] \
        && sudo sed --in-place 's|false|true|g' "${f[numlock]}"  # END NUMLOCK

    # START STARTUP SONG CHANGE
    if [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]]; then

        source "${f[locale]}"

        if [[ $(echo "${LANG}" | awk --field-separator=. '{print $1}') = 'pt_BR' ]]; then

            [[ ! -e "${f[ogg_file]}" ]] \
                && curl --silent --location --output "${f[path-ogg]}" --create-dirs "${l[2]}"

            dconf write "${f[login-file]}" "'${f[path-ogg]}'"

        fi
    fi  # END

    # START CHANGE DESCRIPTION WINDOWS IN GRUB
    [[ ! $(grep --no-messages 'Boot Manager' "${f[grub]}") ]] \
        && sudo sed --in-place 's|Boot Manager|11|g' "${f[grub]}"  # END

    # START CHECK UNSTAGED DIRECTORIES
    [[ ! $(grep --no-messages unstaged "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
alias c='clear'

alias remove_all_pip_packages='pip freeze | xargs pip uninstall -y'

declare -A c=(
    [WHITE]='\033[1;37m'
    [END]='\e[0m'
)

alias unstaged='find -type d -name .git | while read dir; do sh -c \"cd \${dir}/../ && echo \"\${c[WHITE]}GIT STATUS IN \${dir%%.git}\${c[END]}\" && git status --short\"; done'" \
        && sudo sed --in-place 's|echo "\${c\[W|echo \\"${c[W|g' "${f[bashrc]}" \
        && sudo sed --in-place 's|\[END]}"|[END]}\\"|g' "${f[bashrc]}"  # END

    echo; read -p $'\033[1;37mSIR, DO U WANT TO INSTALL A COLORFUL LS? \n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            [[ ! -d "${d[3]}" || ! $(dpkg --list | awk "/ii  ${m[3]}[[:space:]]/ {print }") ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH RUBY STUFFS?" \
                && ruby_stuffs

            [[ ! -d "${d[7]}" ]] \
                && show "\nFIRST THINGS FIRST. DO U PASS THROUGH BASH COLORFUL?" \
                && bash_stuffs

            [[ $(gem list 2>&- | grep --no-messages "${m[4]}") ]] \
                && show "\n${c[GREEN]}${m[4]^^} ${c[WHITE]}${linei:${#m[4]}} [INSTALLED]" \
                || show "\n${c[YELLOW]}${m[4]^^} ${c[WHITE]}${linen:${#m[4]}} [INSTALLING]" \
                && gem install --silent "${m[4]}"

            if [[ ! -e "${f[meslo]}" ]]; then

                [[ ! -d "${d[8]}" || $(stat -c "%U" "${d[8]}" 2>&-) != ${USER} ]] \
                    && sudo mkdir --parents "${d[8]}" > "${f[null]}" \
                    && sudo chown --recursive "${USER}":"${USER}" "${d[8]}"

                wget --quiet "${l[6]}" --output-document "${f[meslo]}"

                unzip "${d[8]}"*.zip -d "${d[8]}" &> "${f[null]}"

                rm --force "${f[meslo]}" *Windows*

                sudo fc-cache --force "${d[8]}"

            fi

            [[ ! $(grep --no-messages "${m[4]}" "${f[bashrc]}") ]] \
                && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "
# Colorls stuffs
source $(dirname $(gem which ${m[4]}))/tab_complete.sh

alias ls='${m[4]}'"

            break

        elif [[ "${option:0:1}" = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[flame]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[flame]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I INSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

        fi

    done

    # START NOMATCH
    [[ ! $(grep --no-messages nomatch "${f[zshrc]}") && "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
        && sudo tee --append "${f[zshrc]}" > "${f[null]}" <<< "
# Hides default behavior from zsh in grep: no matches found.
setopt +o nomatch" \
        && source "${f[zshrc]}"  # END NOMATCH

    # START NOMENCLATURE ICON ARRANGEMENT
    [[ ! $(grep --no-messages sublime_text "${f[grouped]}"*.json) && "${XDG_CURRENT_DESKTOP^^}" =~ .*CINNAMON ]] \
        && sudo sed --in-place --null-data 's|"firefox.desktop",|"brave-browser.desktop",|2' "${f[grouped]}"*.json \
        && sudo sed --in-place '166 a\'"$(printf '%.s ' {0..11})"'"firefox.desktop",' "${f[grouped]}"*.json \
        && sudo sed --in-place '167 a\'"$(printf '%.s ' {0..11})"'"transmission-gtk.desktop",' "${f[grouped]}"*.json \
        && sudo sed --in-place --null-data 's|"org.gnome.Terminal.desktop",|"nemo.desktop",|2' "${f[grouped]}"*.json \
        && sudo sed --in-place --null-data 's|"nemo.desktop"|"org.gnome.Terminal.desktop"|3' "${f[grouped]}"*.json \
        && sudo sed --in-place '166 a\'"$(printf '%.s ' {0..11})"'"telegramdesktop.desktop",' "${f[grouped]}"*.json \
        && sudo sed --in-place '170 a\'"$(printf '%.s ' {0..11})"'"sublime_text.desktop",' "${f[grouped]}"*.json  # END

    # START GUI CHANGES
    dconf write "${f[paste]}" "'<Ctrl>v'"

    [[ "${XDG_CURRENT_DESKTOP^^}" =~ .*GNOME ]] \
        && dconf write "${f[show_hidden]}" true \
        && dconf write "${f[thumbnail-limit]}" 'uint64 34359738368' \
        && dconf write "${f[default_sort_reverse]}" false \
        && dconf write "${f[gtk_theme_gnome]}" "'Yaru-viridian-dark'" \
        && dconf write "${f[icon_theme]}" "'Yaru-viridian'" \
        && dconf write "${f[custom_gnome]}" "['${f[custom_first]}']" \
        && dconf write "${f[custom_first]}binding" "'<Super>e'" \
        && dconf write "${f[custom_first]}command" "'nautilus'" \
        && dconf write "${f[custom_first]}name" "'Raise Nautilus'" \
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
        && dconf write "${f[autostart_blacklist]}" "['gnome-settings-daemon', 'org.gnome.SettingsDaemon', 'gnome-fallback-mount-helper', 'gnome-screensaver', 'mate-screensaver', 'mate-keyring-daemon', 'indicator-session', 'gnome-initial-setup-copy-worker', 'gnome-initial-setup-first-login', 'gnome-welcome-tour', 'xscreensaver-autostart', 'nautilus-autostart', 'caja', 'xfce4-power-manager', 'mintwelcome']"  # END GUI

}
#======================#

#======================#
evoke_functions() {

    case "${choice}" in

        0|00) close_menu &> "${f[null]}" ;;
        1|01) bash_stuffs && return_menu ;;
        2|02) brave_stuffs && return_menu ;;
        3|03) deemix_stuffs && return_menu ;;
        4|04) dualmonitor_stuffs && return_menu ;;
        5|05) github_stuffs && return_menu ;;
        6|06) chrome_stuffs && return_menu ;;
        7|07) flameshot_stuffs && return_menu ;;
        8|08) heroku_stuffs && return_menu ;;
        9|09) hide_devices && return_menu ;;
        10) minidlna_stuffs && return_menu ;;
        11) nvidia_stuffs && return_menu ;;
        12) postgres_stuffs && return_menu ;;
        13) postman_stuffs && return_menu ;;
        14) python_stuffs && return_menu ;;
        15) reduceye_stuffs && return_menu ;;
        16) ruby_stuffs && return_menu ;;
        17) sublime_stuffs && return_menu ;;
        18) tmate_stuffs && return_menu ;;
        19) usefull_pkgs && return_menu ;;
        20) workspace_stuffs && return_menu ;;
        21) echo; show "KNOW YOUR LIMITS ${name[random]}..."

        echo; read -p $'\033[1;37mSIR, DO U TRUST ME TO DO MY OWN GUI CHANGES? \n[Y/N] R: \033[m' option

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

        bash_stuffs
        brave_stuffs
        deemix_stuffs
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

        [[ -e "${f[mimeapps]}" ]] \
            && sudo cp "${f[mimeapps]}" "${f[mimebkp]}"

        sudo tee "${f[mimeapps]}" > "${f[null]}" <<< '[Default Applications]
text/html=google-chrome.desktop
x-scheme-handler/http=google-chrome.desktop
x-scheme-handler/https=google-chrome.desktop
x-scheme-handler/about=google-chrome.desktop
x-scheme-handler/unknown=google-chrome.desktop
x-scheme-handler/mailto=google-chrome.desktop
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
application/x-subrip=sublime_text.desktop;'

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

		for line in "${!logo[@]}"; do

            show "    ${c[RED]}${logo[${line}]}" 1 && sleep 0.1s

        done

        sleep 0.1s; show "${c[RED]}=======================================================" 1
        sleep 0.1s; show "${c[RED]}[ 00 ] ${c[WHITE]}EXIT ${e[door]}" 1
        sleep 0.1s; show "${c[RED]}[ 01 ] ${c[WHITE]}BASH COLORFUL (OH-MY-BASH) ${e[paint]}" 1
        sleep 0.1s; show "${c[RED]}[ 02 ] ${c[WHITE]}BRAVE BROWSER ${e[leo]}" 1
        sleep 0.1s; show "${c[RED]}[ 03 ] ${c[WHITE]}DEEMIX ${e[headphone]}" 1
        sleep 0.1s; show "${c[RED]}[ 04 ] ${c[WHITE]}DUAL MONITOR SETUP ${e[landscape]}" 1
        sleep 0.1s; show "${c[RED]}[ 05 ] ${c[WHITE]}GIT/GITHUB ${e[octopus]}" 1
        sleep 0.1s; show "${c[RED]}[ 06 ] ${c[WHITE]}GOOGLE CHROME ${e[globe]}" 1
        sleep 0.1s; show "${c[RED]}[ 07 ] ${c[WHITE]}FLAMESHOT ${e[camera]}" 1
        sleep 0.1s; show "${c[RED]}[ 08 ] ${c[WHITE]}HEROKU ${e[rocket]}" 1
        sleep 0.1s; show "${c[RED]}[ 09 ] ${c[WHITE]}HIDE WINDOWS DEVICES ${e[blind_monkey]}" 1
        sleep 0.1s; show "${c[RED]}[ 10 ] ${c[WHITE]}MINIDLNA ${e[popcorn]}" 1
        sleep 0.1s; show "${c[RED]}[ 11 ] ${c[WHITE]}NVIDIA DRIVER ${e[n]}" 1
        sleep 0.1s; show "${c[RED]}[ 12 ] ${c[WHITE]}POSTGRES ${e[elephant]}" 1
        sleep 0.1s; show "${c[RED]}[ 13 ] ${c[WHITE]}POSTMAN ${e[satellite]}" 1
        sleep 0.1s; show "${c[RED]}[ 14 ] ${c[WHITE]}PYTHON ${e[snake]}" 1
        sleep 0.1s; show "${c[RED]}[ 15 ] ${c[WHITE]}REDUCE EYE STRAIN ${e[moon]}" 1
        sleep 0.1s; show "${c[RED]}[ 16 ] ${c[WHITE]}RUBY ${e[ruby]}" 1
        sleep 0.1s; show "${c[RED]}[ 17 ] ${c[WHITE]}SUBLIME TEXT ${e[letters]}" 1
        sleep 0.1s; show "${c[RED]}[ 18 ] ${c[WHITE]}TMATE ${e[magnet]}" 1
        sleep 0.1s; show "${c[RED]}[ 19 ] ${c[WHITE]}USEFULL PROGRAMS ${e[diamond]}" 1
        sleep 0.1s; show "${c[RED]}[ 20 ] ${c[WHITE]}WORKSPACE ${e[suitcase]}" 1
        sleep 0.1s; show "${c[RED]}[ 21 ] ${c[WHITE]}ALL ${e[whale]}" 1
        sleep 0.1s; show "${c[RED]}=======================================================" 1

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
