#!/usr/bin/env bash

# /usr/bin/env no lugar de /bin/bash por causa da portabilidade, já que nem em
# todas as distros, ele estará em /bin/bash, faço isso pra alcançar mais users

#======================#
# ALFRED, programa de provisionamento de distro linux.
#======================#

#==========TRY=========#
# find . -type d -name '.git' | while read dir ; do sh -c "cd $dir/../ && echo -e \"\nGIT STATUS IN ${dir//\.git/}\" && git status -s" ; done
# Se não aparecer imagens nos arquivos de música
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

# ${#string} retorna o tamanho da string
# ${#string[@]} retorna a quantidade de elementos no array
# $((above)) síntaxe para subtrair um número do conjunto
name=(
    'MASTER WAYNE'
    'MASTER BRUCE'
    'MR. WAYNE'
    'MR. BRUCE'
)

random=$(shuf -i 0-$((${#name[@]}-1)) -n 1)

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
e=(
    $'\360\237\232\252'  #  0 (porta): exit
    $'\360\237\216\250'  #  1 (pintor): bash colorful
    $'\360\237\216\247'  #  2 (headphone): deezloader
    $'\360\237\214\211'  #  3 (paisagem): dualmonitor
    $'\360\237\220\231'  #  4 (polvo): git
    $'\360\237\214\215'  #  5 (globo): chrome
    $'\360\237\223\267'  #  6 (câmera): flameshot
    $'\360\237\232\200'  #  7 (foguete): heroku
    $'\360\237\231\210'  #  8 (macaco vendado): hide devices
    $'\360\237\215\277'  #  9 (pipoca): minidlna
    $'\360\235\223\235'  # 10 (n): nvidia
    $'\360\237\220\230'  # 11 (elefante): postgres
    $'\360\237\220\215'  # 12 (cobra): py libraries/upgrade
    $'\360\237\224\244'  # 13 (letras): sublime
    $'\360\237\247\262'  # 14 (imã): tmate
    $'\360\237\222\216'  # 15 (diamante): usefull programs
    $'\360\237\222\274'  # 16 (maleta): workspace
    $'\360\237\220\213'  # 17 (baleia): all
    $'\360\237\224\245'  # 18 (fogo): some men...
    $'\360\237\231\212'  # 19 (macaco calado): password
    $'\360\237\246\207'  # 20 (morcego): why do we fall...
)

# usefull files
declare -A f=(
    [askpass]=/lib/cryptsetup/askpass
    [bashrc]=~/.bashrc
    [gtk_theme]=/org/cinnamon/desktop/interface/gtk-theme
    [mimeapps]=~/.config/mimeapps.list
    [null]=/dev/null
    [public_ssh]=~/.ssh/id_rsa.pub
    [user_dirs]=~/.config/user-dirs.dirs
    [srcs]=/etc/apt/sources.list
    [srcs_list]=/etc/apt/sources.list.d
    [ssh]=/tmp/check_connection
)
#======================#

#======================#
check_distro() {

    f+=(
        [os_release]=/etc/os-release
    )

    check_os=$(cat "${f[os_release]}" | grep --word-regexp NAME | awk '{print $2}' | sed 's|"||')

    unset f

    if [[ "${check_os}" != 'Mint' ]]; then

        show "\n   ${e[20]} ${c[RED]}WHY DO WE FALL ${name[random]}? ${e[20]}\n${c[CYAN]}SO WE CAN LEARN TO PICK OURSELVES UP \n"

        show "${c[RED]}YOU MUST RUN AT GOTHAM FOR A BETTER EXPERIENCE ${c[GREEN]}\n\t\t(MINT)\n"

        read -p $'\033[1;37mDID U WANNA CONTINUE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                check_source

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                # Após a invocação de outro chamado, ele não sai completamente
                # do loop, sendo necessário a invocação e a interrupção do msm
                encerra_menu && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U WANNA CONTINUE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

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
	if dpkg-query -s "${1}" &> "${f[null]}"; then

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
    if [[ ${BASH_SOURCE[0]} -ef "${0}" ]]; then

        show "\n${c[RED-BLINK]}PLEASE, RUNS: source alfred.sh\n" "1" && exit

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
encerra_menu() {

    show "\n   ${c[RED]}FOR YOUR OWN SAKE,\n${c[CYAN]}THERE IS NO TURNING BACK...\n"

    [[ ${BASH_SOURCE[0]} -ef "${0}" ]] && exit || return 0

}
#======================#

#======================#
show() {

    echo -e ${c[WHITE]}"${1}"${c[END]}

    # Don't sleep if 2ø parameter contains 1
    [[ "${2}" != "1" ]] && take_a_break

}
#======================#

#======================#
install_packages() {

    # $@: Trick to unpack all received values
    for package in "$@"; do

    	if check_pkg "${package}"; then

            echo && show "${c[GREEN]}${package^^} ${c[WHITE]}${linei:${#package}} [INSTALLED]"

        else

            if test "${?}" -eq 1; then

                echo && show "${c[YELLOW]}${package^^} ${c[WHITE]}${linen:${#package}} [INSTALLING]"

                sudo apt install -y "${package}" &> "${f[null]}"

            fi

        fi

    done

}
#======================#

#======================#
remove_useless() {

    sudo apt autoremove -y &> "${f[null]}"

    sudo apt autoclean > "${f[null]}"

}
#======================#

#======================#
retorna_menu() {

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

    [[ "${1}" -ne 1 ]] && show "${c[RED]}––––––––––––––––––––––– ${c[YELLOW]}END ${c[GREEN]}${escolha} ${c[RED]}––––––––––––––––––––––––" "1"

}

#======================#
update() {

    # &> redirects stdout and stderr to file
    sudo apt update &> "${f[null]}"

}
#======================#

#======================#
uninstall_or_configure() {

    echo; show "${c[RED]}––––––––––––––––––– ${c[YELLOW]}YOUR CHOICE: ${c[GREEN]}${escolha} ${c[RED]}–––––––––––––––––––" "1"

    if [[ "${1}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!"

                return 0

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I COMEBACK TO STATUS QUO?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        "${2}" "1"

        "${3}"

    fi

    show "INITIALIZING CONFIGS..."

    return 1

}
#======================#

#======================#
bash_stuffs() {

    d=(
        ~/.oh-my-bash  # 0
        ~/.fonts  # 1
        ~/.config/fontconfig/conf.d  # 2
    )

    f+=(
        [powerline_otf]=~/.fonts/PowerlineSymbols.otf
        [powerline_conf]=~/.config/fontconfig/conf.d/10-powerline-symbols.conf
        [original]=/etc/skel/.bashrc
        [config]=~/.oh-my-bash/oh-my-bash.sh
        [bkp]=~/.bashrc.pre-oh-my-bash
    )

    l=(
        'https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh'  # 0
        'https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf'  # 1
        'https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf'  # 2
    )

    m=(
        'oh-my-bash'  # 0
        'curl'  # 1
        'git'  # 2
    )

    if [[ -d "${d[0]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                # --force: ignore nonexistent files, never prompt
                # --recursive: remove directories
                sudo rm --force --recursive "${d[0]}"

                sudo rm --force "${f[powerline_otf]}" "${f[powerline_conf]}" "${f[bkp]}" "${f[bashrc]}"

                # Could be mv "${f[bkp]}" "${f[bashrc]}", but if user format
                # disk and maintain home intact, returns error
                cp "${f[original]}" "${f[bashrc]}" &> "${f[null]}"

                source "${f[bashrc]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" "1"

        install_packages "${m[1]}" "${m[2]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]\n"

        # First /dev/null hide download progress, second hide thirty commands
        0> "${f[null]}" sh -c "$(curl --show-error --fail --silent --location ${l[0]})" &> "${f[null]}"

    fi

    show "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[powerline_otf]}" ]]; then

        # Hidden directories are owned by root, we must change owner to bash "read"
        # 2>&- hides: "can't stat: no such file..."
        [[ ! -d "${d[1]}" || $(stat -c "%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}" # Close error output

        # --location follows to last URL (github provides a few redirects)
        # --output write content to file
        curl --location --silent --output "${f[powerline_otf]}" --create-dirs "${l[1]}"

        # Update font cache
        sudo fc-cache -vf "${d[1]}" > "${f[null]}"

    fi

    if [[ ! -e "${f[powerline_conf]}" ]]; then

        [[ ! -d "${d[2]}" || $(stat -c "%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" > "${f[null]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]%conf.d}"

        curl --location --silent --output "${f[powerline_conf]}" --create-dirs "${l[2]}"

    fi

    # If show error when open oh-my-base, run command below
    # [[ $(grep --no-messages "check_for_upgrade.sh" "${f[config]}") ]] \
    #     && sudo sed -zi 's|if \[ "$DISABLE_AUTO_UPDATE" != "true" \]; then\n  env OSH=$OSH DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT bash -f $OSH/tools/check_for_upgrade.sh\nfi||g' "${f[config]}"

    # Hide username from tty (hide #) and accepts pip freeze > requirements.txt
    [[ ! $(grep --no-messages DEFAULT_USER "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< "#DEFAULT_USER=${USER}
set +o noclobber" # tee is an "sudo echo" that works, -a to append (>>)

    [[ ! $(grep --no-messages agnoster "${f[bashrc]}") && ! $(grep --no-messages 'plugins=(git' "${f[bashrc]}") ]] \
        && sudo sed -i 's|OSH_THEME="font"|OSH_THEME="agnoster"|g' "${f[bashrc]}" \
        && sudo sed -zi 's|plugins=(\n  git\n  bashmarks\n)|plugins=(git django python pyenv pip virtualenv)|g' "${f[bashrc]}"

    # Load changes
    source "${f[bashrc]}"

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
deezloader_stuffs() {

    d=(
        ~/Deezloader\ Music  # 0
        ~/.config/Deezloader\ Remix  # 1
        ~/$(cat "${f[user_dirs]}" | awk --field-separator=/ '/MUSIC/ {print $2}' | sed 's|"||')/  # 2
    )

    l=(
        'https://notabug.org/RemixDevs/DeezloaderRemix/wiki/Downloads'  # 0
        'https://notabug.org/RemixDevs/DeezloaderRemix'  # 1
    )

    f+=(
        [file]="${d[2]}"$(curl --silent "${l[1]}" | grep --no-messages 64.AppImage | awk --field-separator='>' '{print $2}' | sed 's|</td||')
        [config]=~/.config/Deezloader\ Remix/config.json
    )

    m=(
        'deezloader'  # 0
        'megatools'  # 1
        # If preview not show, try run: rm -rf ~/.cache/thumbnails/fail*
        'xplayer'  # 2
    )

    link_latest=$(curl --silent "${l[0]}" | grep -6 'Linux x64' | tail -1 | awk --field-separator='"' '{print $2}' | sed 's|%..|!|g')

    if [[ -e "${f[file]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo rm --force "${f[file]}"

                sudo rm --force --recursive "${d[0]}" "${d[1]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" "1"

        install_packages "${m[1]}" "${m[2]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]\n"

        megadl --no-progress "${link_latest}" --path "${d[2]}"

    fi

    show "INITIALIZING CONFIGS..."

    # Checa permissão. Se não for executável, torna-o
    [[ $(stat -c "%a" "${f[file]}" 2>&-) -ne 755 ]] \
        && sudo chmod +x "${f[file]}"

    local=$(stat -c "%n" "${d[2]}"Deez* | awk --field-separator=_ '{print $3}' | sed 's|-x86||')

    latest=$(curl --silent "${l[0]}" | grep -1 "markdown" | tail -1 | awk '{print $3}' | sed 's|</h2>||')

    # Remove old deezloader and updates
    ( $(dpkg --compare-versions "${local}" lt "${latest}") ) \
        && sudo rm --force "${d[2]}"Deez* \
        && megadl --no-progress "${link_latest}" --path "${d[2]}"

    if [[ ! $(grep --no-messages "${d[2]#~/}" "${f[config]}") ]]; then

        # Run deezloader and free tty
        ( nohup "${f[file]}" & ) &> "${f[null]}"

        read -p $'\033[1;37m\nHAVE YOU LOGON? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                if [[ ! -e "${f[config]}" ]]; then

                    echo -ne ${c[WHITE]}"\nNO, YOU DON'T\n[Y/N] R: "${c[END]}

                    read option

                else

                    kill -9 $(ps -aux | grep --no-messages "Deezlo0" | head -1 | awk '{print $2}')

                    sudo sed -i "s|Deezloader Music/|${d[2]#~/}|g" "${f[config]}"

                    ( nohup "${f[file]}" & ) &> "${f[null]}"

                    break

                fi

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo -ne ${c[WHITE]}"\nTHEN DO IT! WAITING...\n[Y/N] R: "${c[END]}

                read option

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. DO U HAVE COMPLETE LOGIN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
dualmonitor_stuffs() {

    d=(
        /usr/share/backgrounds/linuxmint-random  # 0
    )

    f+=(
        [starwars]=/usr/share/backgrounds/linuxmint-random/sw.jpg
        [stormtrooper]=/usr/share/backgrounds/linuxmint-random/st.jpg
        [fightclub]=/usr/share/backgrounds/linuxmint-random/cl.png
        [kyloren]=/usr/share/backgrounds/linuxmint-random/kr.jpg
        [default]=/usr/share/backgrounds/linuxmint/default_background.jpg
        [src]=/usr/share/cinnamon-background-properties/linuxmint-random.xml
        [picture]=/org/cinnamon/desktop/background/picture-uri
        [option]=/org/cinnamon/desktop/background/picture-options
        [slideshow]=/org/cinnamon/desktop/background/slideshow/slideshow-enabled
        [source]=/org/cinnamon/desktop/background/slideshow/image-source
        [delay]=/org/cinnamon/desktop/background/slideshow/delay
    )

    # 3840x1080 wallpaper
    l=(
        'https://images3.alphacoders.com/673/673177.jpg'  # 0
        'https://images4.alphacoders.com/885/885300.png'  # 1
        'https://www.dualmonitorbackgrounds.com/albums/SDuaneS/the-force-awakens-8.jpg'  # 2
        'https://www.dualmonitorbackgrounds.com/albums/SDuaneS/the-force-awakens-20.jpg'  # 3
    )

    m=(
        'wallpapers'  # 0
        'dconf-editor'  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }" | wc -l) -ge 1 \
        && $(dconf read "${f[option]}" 2>&-) = "'spanned'" ]]; then
        # 2>&- if dconf not installed

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linec:${#m[0]}} [APPLIED]\n" "1"

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

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  S${c[WHITE]}ETING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

        install_packages "${m[1]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

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

        dconf write "${f[picture]}" "'${f[starwars]}'"

        dconf write "${f[option]}" "'spanned'"

        dconf write "${f[slideshow]}" true

        dconf write "${f[source]}" "'xml://${f[src]}'"

        dconf write "${f[delay]}" 15

        [[ ! -e "${f[src]}" ]] \
            && sudo tee "${f[src]}" > "${f[null]}" <<< '<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "cinnamon-wp-list.dtd">
<wallpapers>

<wallpaper deleted="false">
    <name>Jedi vs Sith</name>
    <filename>/usr/share/backgrounds/linuxmint-random/sw.jpg</filename>
    <options>spanned</options>
    <shade_type>solid</shade_type>
    <pcolor>#000000</pcolor>
    <scolor>#333333</scolor>
    <artist>Torino GT</artist>
</wallpaper>
<wallpaper deleted="false">
    <name>Stormtrooper</name>
    <filename>/usr/share/backgrounds/linuxmint-random/st.jpg</filename>
    <options>spanned</options>
    <shade_type>solid</shade_type>
    <pcolor>#000000</pcolor>
    <scolor>#333333</scolor>
    <artist>Duane</artist>
</wallpaper>
<wallpaper deleted="false">
    <name>Fight Club</name>
    <filename>/usr/share/backgrounds/linuxmint-random/cl.jpg</filename>
    <options>spanned</options>
    <shade_type>solid</shade_type>
    <pcolor>#000000</pcolor>
    <scolor>#333333</scolor>
    <artist>Joker Boy</artist>
</wallpaper>
<wallpaper deleted="false">
    <name>Kylo Ren</name>
    <filename>/usr/share/backgrounds/linuxmint-random/kr.jpg</filename>
    <options>spanned</options>
    <shade_type>solid</shade_type>
    <pcolor>#000000</pcolor>
    <scolor>#333333</scolor>
    <artist>Duane</artist>
</wallpaper>

</wallpapers>'

    else

        show "\nYOU DON'T HAVE DUAL MONITOR SETUP. EXITING..."

    fi

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
github_stuffs() {

    f+=(
        [config]=~/.gitconfig
        [config-ssh]=~/.ssh/config
    )

    l=(
        'https://api.github.com/user/keys'  # 0
        'https://git-scm.com/'  # 1
    )

    m=(
        'git'  # 0
        'vim'  # 1
        'git-cola'  # 2
        'jq'  # 3
    )

    # We put ii  <pkg>[[:space:]] to get only what we need, git shows in more places (in version by the way)
    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" "${m[2]}" "${m[3]}" &> "${f[null]}"

                sudo rm --force "${f[config]}"

                [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"/* | grep "${m[0]}") ]] \
                    && sudo add-apt-repository --remove -y ppa:git-core/ppa &> "${f[null]}"

                sudo sed -zi 's|Host github.com\nHostname ssh.github.com\nPort 443||g' "${f[config-ssh]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" "1"

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    # Any changes pushed to GitHub, BitBucket, GitLab or another Git host
    # server in a later lesson will include this information.
    # from: https://swcarpentry.github.io/git-novice/02-setup/
    [[ ! $(grep --no-messages @ "${f[config]}") ]] \
        && read -p $'\033[1;37m\nENTER YOUR EMAIL, '"${name[random]}"$': \033[m' email \
        && read -p $'\033[1;37mNAME '"${e[19]}"$': \033[m' nome \
        && git config --global user.email "${email}" \
        && git config --global user.name "${nome}" \
        && git config --global core.editor "vim" \
        && git config --global core.autocrlf input

    [[ ! $(grep --no-messages dark "${f[config]}") && $(dconf read "${f[gtk_theme]}") =~ .*Dark.* ]] \
        && git config --global cola.icontheme dark

    local=$(git --version | awk '{print $3}')

    latest=$(curl --silent "${l[1]}" | grep -1 '<span class="version">' | tail -1 | awk '{print $1}')

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"/* | grep "${m[0]}") ]] \
            && sudo add-apt-repository -y ppa:git-core/ppa &> "${f[null]}"

        update && sudo apt install -y "${m[0]}" &> "${f[null]}"

    fi

    check_ssh

    [[ ! $(grep --no-messages github "${f[config-ssh]}") ]] \
        && sudo tee --append "${f[config-ssh]}" > "${f[null]}" <<< 'Host github.com
    Hostname ssh.github.com
    Port 443'

    # GITHUB STUFF
    for (( ; ; )); do

        read -p $'\033[1;37m\nENTER YOUR USERNAME FROM GITHUB: \033[m' user

        password=$("${f[askpass]}" $'\033[1;37mPASSWORD:\033[m')

        # Ver se dá pra fazer com awk '{print $2}'
        # Opções curl: s de silent, i de informações a mais, u de usuário
        check_integrity=$(curl --silent --include --user "${user}":"${password}" "${l[0]}" | grep Status | awk '{print $2}')

        # Poupamos a condição abaixo, já que as mensagens de sucesso é 200 até 226
        # [[ "${check_integrity}" -eq 401 || "${check_integrity}" -eq 403 ]]
        [[ "${check_integrity}" -gt 400 ]] \
            && show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" \
            || break

    done

    # Se não existir nenhuma chave no github
    if [[ -z $(curl --silent --user "${user}":"${password}" "${l[0]}") ]]; then

        curl --silent --include --user "${user}":"${password}" --data '{"title": "Enviado do meu iPhone","key": "'"$(cat "${f[public_ssh]}")"'"}' "${l[0]}" > "${f[null]}"

        echo

    else

        install_packages "${m[3]}"

        [[ \
            $(cat "${f[public_ssh]}" | awk '{print $2}') != \
            $(curl --silent --user "${user}":"${password}" "${l[0]}" | jq ".[] | .key" | awk '{print $2}' | sed 's|"||') \
        ]] \
            && show "\nTHERE'S AN INCONSISTENCY IN YOUR LOCAL/REMOTE KEYS\nFIXING..." \
            && curl --user "${user}":"${password}" --request DELETE "${l[0]}"/"$(curl --silent --user "${user}":"${password}" "${l[0]}" | jq '.[] | .id')" \
            && curl --silent --include --user "${user}":"${password}" --data '{"title": "Enviado do meu iPhone","key": "'"$(cat "${f[public_ssh]}")"'"}' "${l[0]}" > "${f[null]}" \
            && echo

    fi

    [[ ! $(cat "${f[ssh]}" | grep successfully) ]] \
        && ssh -o BatchMode=yes -o StrictHostKeyChecking=no git@github.com

    unset f l m

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
chrome_stuffs() {

    d=(
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org  # 0
    )

    f+=(
        [file]=~/$(cat "${f[user_dirs]}" | awk --field-separator=/ '/DOWNLOAD/ {print $2}' | sed 's|"||')/google-chrome-stable_current_amd64.deb
        [garbage]=/etc/default/google-chrome
    )

    l=(
        'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'  # 0
    )

    m=(
        'google-chrome-stable'  # 0
        'libappindicator1'  # 1
        'libindicator7'  # 2
        'libxss1'  # 3
    )

	if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                # Only libappindicator1 doesn't come default in debian distros
                sudo apt remove --purge -y "${m[0]}" "${m[1]}" &> "${f[null]}"

                sudo sed -zi 's|text/html=google-chrome.desktop\nx-scheme-handler/http=google-chrome.desktop\nx-scheme-handler/https=google-chrome.desktop\nx-scheme-handler/about=google-chrome.desktop\nx-scheme-handler/unknown=google-chrome.desktop\nx-scheme-handler/mailto=google-chrome.desktop||g' "${f[mimeapps]}"

                sudo sed -i '\|"google-chrome.desktop",|d' "${d[0]}"/*.json

                sudo rm --force "${f[garbage]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" "1"

        # Dependências
        install_packages "${m[1]}" "${m[2]}" "${m[3]}"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]\n"

        [[ ! -e "${f[file]}" ]] \
            && curl --location --silent --output "${f[file]}" --create-dirs "${l[0]}"

        sudo dpkg -i "${f[file]}" &> "${f[null]}"

        sudo rm --force "${f[file]}"

    fi

    show "INITIALIZING CONFIGS..."

    [[ ! $(grep --no-messages google-chrome "${f[mimeapps]}") ]] \
        && sudo tee "${f[mimeapps]}" > "${f[null]}" <<< '[Default Applications]
text/html=google-chrome.desktop
x-scheme-handler/http=google-chrome.desktop
x-scheme-handler/https=google-chrome.desktop
x-scheme-handler/about=google-chrome.desktop
x-scheme-handler/unknown=google-chrome.desktop
x-scheme-handler/mailto=google-chrome.desktop'

    # Nomenclature icon arrangement
    [[ ! $(grep --no-messages google-chrome "${d[0]}"/*.json) ]] \
        && sudo sed -i 's|"firefox.desktop",|"google-chrome.desktop",\n\t\t\t"firefox.desktop",\n\t\t\t"transmission-gtk.desktop",|g' "${d[0]}"/*.json \
        && sudo sed -zi 's|"org.gnome.Terminal.desktop",|"nemo.desktop",\n\t\t\t"org.gnome.Terminal.desktop"|2' "${d[0]}"/*.json \
        && sudo sed -i '/"nemo.desktop"/,2d' "${d[0]}"/*.json \
        && sudo sed -zi 's|"org.gnome.Terminal.desktop",|"org.gnome.Terminal.desktop"|1' "${d[0]}"/*.json \
        && sudo sed -zi 's|"transmission-gtk.desktop",|"transmission-gtk.desktop",\n\t\t\t"nemo.desktop",|2' "${d[0]}"/*.json

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
flameshot_stuffs() {

    d=(
        ~/.config/Dharkael  # 0
    )

    f+=(
        [config]=~/.config/Dharkael/flameshot.ini
        [dskt]=~/.config/autostart/Flameshot.desktop
        [screenshot]=/org/cinnamon/desktop/keybindings/media-keys/screenshot
        [cmd]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/command
        [bdg]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/binding
        [name]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/name
        [custom]=/org/cinnamon/desktop/keybindings/custom-list
    )

    m=(
        'flameshot'  # 0
        'dconf-editor'  # 1
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

        install_packages "${m[0]}" "${m[1]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    if [[ $(dconf read "${f[screenshot]}" 2>&-) != "['']" ]]; then

        dconf write "${f[screenshot]}" "['']"

        # -F: field-separator to cut
        dconf write "${f[cmd]}" "'flameshot gui --path /home/${USER}/$(cat "${f[user_dirs]}" | awk --field-separator=/ '/PICTURES/ {print $2}' | sed 's|"||')'"

        dconf write "${f[bdg]}" "['Print']"

        dconf write "${f[name]}" "'Flameshot'"

        dconf write "${f[custom]}" "['screenshot']"

    fi

    for (( ; ; )); do

        [[ ! -e "${f[config]}" ]] \
            && flameshot full -p /tmp/ \
            && show "\nSAVING A SCREENSHOT TO CREATE DEFAULT FILES..." \
            || break

    done

    # If these instructions below stay in for, don't works
    sudo pkill flameshot

    take_a_break

    [[ ! $(grep --no-messages disabledTrayIcon "${f[config]}") ]] \
        && sudo tee "${f[config]}" > "${f[null]}" <<< "[General]
buttons=@Variant(\0\0\0\x7f\0\0\0\vQList<int>\0\0\0\0\x3\0\0\0\x3\0\0\0\n\0\0\0\v)
contastUiColor=@Variant(\0\0\0\x43\x2\xff\xff\x8aT\xff\xff\xff\xff\0\0)
disabledTrayIcon=true
drawColor=@Variant(\0\0\0\x43\x1\xff\xff\x80\x80\0\0\x80\x80\0\0)
drawThickness=0
savePath=~/$(cat ${f[user_dirs]} | awk --field-separator=/ '/PICTURES/ {print $2}' | sed 's|"||')/"

    [[ ! $(grep --no-messages flameshot "${f[dskt]}") ]] \
        && sudo tee "${f[dskt]}" > "${f[null]}" <<< '[Desktop Entry]
Name=flameshot
Icon=flameshot
Exec=flameshot
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true'

    unset d f m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
heroku_stuffs() {

    d=(
        /usr/lib/heroku/  # 0
        ~/.cache/heroku/  # 1
    )

    f+=(
        [auth]=~/.netrc
        [ppa]=/etc/apt/sources.list.d/heroku.list
    )

    l=(
        'https://cli-assets.heroku.com/install-ubuntu.sh'  # 0
    )

    m=(
        'heroku'  # 0
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" &> "${f[null]}"

                sudo rm --force "${f[auth]}" "${f[ppa]}"

                sudo rm --force --recursive "${d[0]}" "${d[1]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

        show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]\n"

        sh -c "$(curl --silent ${l[0]})" &> "${f[null]}"

    fi

    show "INITIALIZING CONFIGS..."

	echo; read -p $'\033[1;37mWANT YOU AUTHENTICATE '"${name[random]}"$'? \n[Y/N] R: \033[m' option

	for (( ; ; )); do

		if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

    		echo && heroku login -i

            # https://devcenter.heroku.com/articles/heroku-cli#login-issues
            while [[ ! -e "${f[auth]}" ]]; do

                show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!\n" "1"

                heroku login -i

            done

            echo && break

		elif [[ "${option:0:1}" = @(n|N) ]] ; then

            echo && break

	    else

            echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. WANT YOU AUTHENTICATE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

    	fi

    done

    unset d f l m

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
hide_devices() {

    d=(
        /etc/udev/rules.d  # 0
    )

    f+=(
        [config]=/etc/udev/rules.d/99-hide-disks.rules
    )

    m=(
        'devices'  # 0
    )

    check_devices=$(sudo fdisk --list | grep --extended-regexp "Microsoft dados básico|Microsoft basic data" | awk '{print $1}')

    if [[ -z "${check_devices}" ]]; then

        show "\n  THERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!"

        retorna_menu

    else

        # --no-messages hide if file don't exists
        if [[ $(grep --no-messages ID_FS_UUID "${f[config]}") ]]; then

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${lineh:${#m[0]}} [HIDED]\n" "1"

            read -p $'\033[1;37mSIR, SHOULD I SHOW THEM? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    show "\n${c[RED]}S${c[WHITE]}HOWING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                    sudo rm --force "${f[config]}"

                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    retorna_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    echo && break

                else

                    echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I SHOW THEM AGAIN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            show "${c[GREEN]}\n\t\tH${c[WHITE]}IDING ${c[RED]}$((${#check_devices[@]} + 1))${c[WHITE]} WINDOWS ${c[GREEN]}${m[0]^^}${c[WHITE]}!" "1"

            for device in "${check_devices}"; do

                devices+=(${device})

            done

            [[ ! -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) != ${USER} ]] \
                && mkdir --parents "${d[0]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

            for (( iterador=0; iterador<${#devices[@]}; iterador++ )); do

                tee --append "${f[config]}" > "${f[null]}" <<< 'ENV{ID_FS_UUID}=="'"$(blkid -s UUID -o value ${devices[${iterador}]})"'",ENV{UDISKS_IGNORE}="1"'

            done

            echo

        fi

    fi

    show "INITIALIZING CONFIGS..."

    sudo udevadm control --reload-rules && sudo udevadm trigger

    unset d f m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
minidlna_stuffs() {

    d=(
        ~/$(cat "${f[user_dirs]}" | awk --field-separator=/ '/VIDEO/ {print $2}' | sed 's|"||')/  # 0
    )

    f+=(
        [config]=/etc/minidlna.conf
        [dft]=/etc/default/minidlna
    )

    m=(
        'minidlna'  # 0
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" &> "${f[null]}"

                sudo rm --force "${f[config]}" "${f[default_minidlna]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

        install_packages "${m[0]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    if [[ ! $(grep --no-messages Mídias "${f[config]}") ]]; then

        # automatic discover new files
        sudo sed -i "s|#inotify=yes|inotify=yes|g" "${f[config]}"

        # server_name
        sudo sed -i "s|#friendly_name=|friendly_name=Mídias|g" "${f[config]}"

        # location database
        sudo sed -i "s|#db_dir=/var/cache/minidlna|db_dir=...|g" "${f[config]}"

        # location logs
        sudo sed -i "s|#log_dir=/var/log|log_dir=...|g" "${f[config]}"

        # user to access this database
        sudo sed -i "s|#user=minidlna|user=root|g" "${f[config]}"

        sudo sed -zi "s|/var/lib/minidlna|V,${d[0]}|5" "${f[config]}"

        sudo sed -i 's|#USER="minidlna"|USER="root"|g' "${f[dft]}"

        [[ $(systemctl is-active minidlna.service) = active ]] \
            && sudo service minidlna restart \
            && sudo service minidlna force-reload \
            || sudo service minidlna start

    fi

    unset d f m

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

    l=(
        'https://www.nvidia.com/Download/driverResults.aspx/157462/en-us'  # 0
    )

    m=(
        'nvidia-driver'  # 0
        'nouveau-driver'  # 1
        'nvidia-settings'  # 2
    )

    latest=$(curl --silent "${l[0]}" | grep -1 '"tdVersion"' | tail -1 | awk --field-separator=. '{print $1}' | sed 's| ||g')

    # https://4fasters.com.br/2018/04/26/benchmark-nvidia-driver-do-fabricante-vs-driver-open-source-no-linux/
    # -class: Show reduced data
    check_nvidia_existence=$(sudo lshw -class display | grep --extended-regexp "fabricante|vendor" | awk '{print $2}')

    if [[ "${check_nvidia_existence}" != 'NVIDIA' ]]; then

        show "\n\tTHERE'S NO NVIDIA CARD IN YOUR MACHINE!"

        retorna_menu

    else

        # Identify actual driver.
        check_driver=$(lsmod | grep drm_kms_helper | head -1 | awk '{print $4}')

        if [[ "${check_driver%%_drm}" = "nvidia" ]]; then

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

            read -p $'\033[1;37mSIR, SHOULD I RESTORE NOUVEAU DRIVER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    show "\n${c[RED]}R${c[WHITE]}ESTORING ${c[RED]}${m[1]^^}${c[WHITE]}!\n"

                    [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"/* | grep graphics) ]] \
                        && sudo add-apt-repository --remove -y ppa:graphics-drivers/ppa &> "${f[null]}"

                    sudo apt remove --purge -y "${m[0]}-"* &> "${f[null]}"

                    sudo rm --force "${f[config]}"

                    sudo update-initramfs -u > "${f[null]}"

                    echo && read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

                    for (( ; ; )); do

                        if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                            reboot

                        elif [[ "${option:0:1}" = @(n|N) ]] ; then

                            echo && break

                        else

                            echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                            read option

                        fi

                    done

                    remove_useless

                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    retorna_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    echo && break

                else

                    echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTORE DEFAULT DRIVER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

            [[ ! $(apt search nvidia-driver-"${latest}") ]] \
                && sudo add-apt-repository -y ppa:graphics-drivers/ppa &> "${f[null]}" \
                && update

            install_packages "${m[0]}-${latest}" "${m[2]}" && echo

        fi

    fi

    show "INITIALIZING CONFIGS..."

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

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

        	fi

        done

    fi

    local=$(apt version "${m[0]}-"*)

    if ( $(dpkg --compare-versions "${local}" lt "${latest}") ); then

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"/* | grep graphics) ]] \
            && sudo add-apt-repository -y ppa:graphics-drivers/ppa &> "${f[null]}"

        update && install_packages "${m[0]}-${latest}"

    fi

    unset f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
postgres_stuffs() {

    d=(
        /etc/postgresql/  # 0
    )

    f+=(
        [ppa]=/etc/apt/sources.list.d/pgdg.list
        [config]=/etc/postgresql/11/main/postgresql.conf
        [postgres_hba]=/etc/postgresql/11/main/pg_hba.conf
        [pspg_postgres]=/var/lib/postgresql/.psqlrc
        [pspg_user]=~/.psqlrc
        [pspg]=/usr/bin/pspg
    )

    l=(
        'https://www.postgresql.org/media/keys/ACCC4CF8.asc'  # 0
        'https://www.postgresql.org/'  # 1
        'https://www.linuxmint.com/download_all.php'  # 2
    )

    m=(
        'postgresql'  # 0
        'postgresql-client'  # 1
        'postgresql-contrib'  # 2
        'libpq-dev'  # 3
        'pgadmin4'  # 4
        'pspg'  # 5
    )

    check_name=$(lsb_release -cs)

    check_version=$(curl --silent "${l[2]}" | grep -1 "${check_version^}" | tail -1 | awk '{print $2}' | sed 's|</TD>||')

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" &> "${f[null]}"

                sudo rm --force "${f[ppa]}"

                sudo rm --force --recursive "${d[0]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" "1"

        # 2> hides warning
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep PostgreSQL) ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | sudo apt-key add - &> "${f[null]}"

    	[[ ! $(grep --no-messages "${check_version}" "${f[ppa]}") ]] \
    		&& sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb http://apt.postgresql.org/pub/repos/apt/ ${check_version,}-pgdg main" \
            && update

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    sudo sed -i "s|#listen_addresses|listen_addresses|g" "${f[config]}"

    latest=$(curl --silent "${l[1]}" | grep --no-messages '""' | head -1 | awk --field-separator=. '{print $1}' | sed 's|<li class=""><strong>||' | sed 's| ||g')

    # Match perhaps with -10 or -11 etc (fixed installation)
    local=$(apt version "${m[0]}"???)

    ( $(dpkg --compare-versions "${local}" lt "${latest}") ) \
        && show "\nPOSTGRES IS IN VERSION ${c[GREEN]}${latest}${c[WHITE]}, NOT IN ${c[RED]}${local:0:2} ${c[WHITE]}ANYMORE.\n" \
        && upgrade

    read -p $'\033[1;37m\nDO U WANT A USER TO ACCESS THE CONSOLE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ ${option:0:1} = @(s|S|y|Y) ]] ; then

            read -p $'\033[1;37m\nENTER THE USER ('"${USER}"$'): \033[m' user

            # if empty string
            [[ -z "${user}" ]] && user="${USER}"

            [[ $(sudo -u postgres psql --command "SELECT 1 FROM pg_roles WHERE rolname='${user}'" | grep --extended-regexp "registro|row" | awk '{print $1}' | sed 's|(||') -ge 1 ]] \
                && show "\nUSER ${c[RED]}${user^^}${c[WHITE]} ALREADY EXISTS. EXITING..." \
                && break

            password=$("${f[askpass]}" $'\033[1;37mPASSWORD OF USER '"${user^^}"$':\033[m')

            sudo -u postgres psql --command "CREATE USER ${user} WITH ENCRYPTED PASSWORD '${password}'" &> "${f[null]}"

            sudo -u postgres psql --command "ALTER ROLE ${user} SET client_encoding TO 'utf8'" &> "${f[null]}"

            sudo -u postgres psql --command "ALTER ROLE ${user} SET default_transaction_isolation TO 'read committed'" &> "${f[null]}"

            sudo -u postgres psql --command "ALTER ROLE ${user} SET timezone TO 'America/Sao_Paulo'" &> "${f[null]}"

            read -p $'\033[1;37m\nDO U WANT A DATABASE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ ${option:0:1} = @(s|S|y|Y) ]] ; then

                    read -p $'\033[1;37m\nENTER THE DATABASE NAME: \033[m' database

                    [[ $(sudo -u postgres psql --command "SELECT 1 FROM pg_database WHERE datname='${database}'" | grep --extended-regexp "registro|row" | awk '{print $1}' | sed 's|(||') -ge 1 ]] \
                        && show "\nDATABASE ${c[RED]}${database^^}${c[WHITE]} ALREADY EXISTS. EXITING..." \
                        && break

                    sudo -u postgres psql --command "CREATE DATABASE ${database}" &> "${f[null]}"

                    sudo -u postgres psql --command "GRANT ALL PRIVILEGES ON DATABASE ${database} TO ${user}" &> "${f[null]}"

                    sudo -u postgres psql -d "${database}" --command "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO ${user}"

                    # Check this resource running: "psql -U <user> -d <database>" and selecting all data from some table.
                    install_packages "${m[5]}"

                    [[ ! -e "${f[pspg_postgres]}" && ! -e "${f[pspg_user]}" ]] \
                        && tee "${f[pspg_postgres]}" "${f[pspg_user]}" > "${f[null]}" <<< "\pset linestyle unicode
\pset border 2
\setenv PAGER '${f[pspg]} -bX --no-mouse'" \
                        && sudo chown postgres:postgres "${f[pspg_postgres]}" \
                        && sudo chown "${user}":"${user}" "${f[pspg_user]}"

                    break

                elif [[ ${option:0:1} = @(N|n) ]] ; then

                    break

                else

                    echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read resposta

                fi

            done

            break

        elif [[ ${option:0:1} = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read resposta

        fi

    done

    if [[ ! $(sudo grep --no-messages 'local   all             postgres                                md5' "${f[postgres_hba]}") ]]; then

        # Before change cryptography, we need add a password for postgres
        password=$("${f[askpass]}" $'\033[1;37m\nPASSWORD OF USER POSTGRES \033[31;1m(root)\033[1;37m:\033[m')

        sudo -u postgres psql --command "ALTER USER postgres WITH ENCRYPTED PASSWORD '${password}'" &> "${f[null]}"

        sudo sed -i "s|local   all             postgres                                peer|local   all             postgres                                md5|g" "${f[postgres_hba]}"

    fi

    [[ $(systemctl is-active postgresql.service) = active ]] \
        && sudo service postgresql restart \
        || sudo service postgresql start

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
py_libraries() {

    l=(
        'https://pypi.org/project/pip/'  # 0
    )

    m=(
        'python-pip'  # 0
        'python-dev'  # 1
        'build-essential'  # 2
        'libraries py'  # 3
    )

    if [[ $(dpkg --list | awk "/ii  ${m[0]}[[:space:]]/ {print }" | wc -l) -ge 1 \
        && $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }" | wc -l) -ge 1 \
        && $(dpkg --list | awk "/ii  ${m[2]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[3]^^} ${c[WHITE]}${linei:${#m[3]}} [INSTALLED]" "1"

        read -p $'\033[1;37m\nSIR, SHOULD I UNINSTALL THEM? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}, ${c[RED]}${m[1]^^}${c[WHITE]} AND ${c[RED]}${m[2]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" "${m[1]}" "${m[2]}" &> "${f[null]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[3]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    local=$(apt version "${m[0]}")

    latest=$(curl --silent "${l[0]}" | grep --no-messages -2 _le | tail -1  | awk '{print $2}')

    ( $(dpkg --compare-versions "${local}" lt "${latest}") ) \
        && pip install --quiet --upgrade pip

    unset l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
upgrade_py() {

    l=(
        'https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer'  # 0
        'https://www.python.org/doc/versions/'  # 1
    )

    d=(
        ~/.pyenv  # 0
        # https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body
        ~/.pyenv/versions/$(curl --silent "${l[1]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')  # 1
    )

    m=(
        'pyenv'  # 0
        'python'  # 1
        'curl'  # 2
        'wget'  # 3
        'zlib1g-dev'  # 4
        'libreadline-dev'  # 5
        'libsqlite3-dev'  # 6
        'llvm'  # 7
        'libncurses5-dev'  # 8
        'libbz2-dev'  # 9
        'libssl-dev'  # 10
        'libffi-dev'  # 11
        'and'  # 12
    )

    # apt version python don't works, because it shows only packages added by
    # apt and pyenv download/install packages from curl
    local=$(python -c 'from sys import version_info as v; print(".".join(map(str, v[:3])))')

    latest=$(curl --silent "${l[1]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')

    install_packages "${m[1]}"

    if ( $(dpkg --compare-versions "${local}" eq "${latest}") ); then

        show "\n${c[GREEN]}${m[12]^^} ${c[WHITE]}${lineu:${#m[12]}} [UPGRADED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I DOWNGRADE VERSION? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[VERMELHO]}R${c[WHITE]}ESETING ${c[VERMELHO]}${m[1]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                sudo sed -zi 's|export PATH="$HOME/.pyenv/bin:$PATH"\neval "$(pyenv init - --no-rehash)"\neval "$(pyenv virtualenv-init -)"||g' "${f[bashrc]}"

                source "${f[bashrc]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESET?${c[FIM]}\n${c[WHITE]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" "1"

        # Dependencies
        install_packages "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}"

        [[ ! -d "${d[0]}" ]] \
            && show "\n${c[YELLOW]}${m[0]^^} ${c[WHITE]}${linen:${#m[0]}} [INSTALLING]" \
            && bash -c "$(curl --location --silent ${l[0]})" &> "${f[null]}" \
            || show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]"

        echo

    fi

    show "INITIALIZING CONFIGS..."

    [[ ! $(grep --no-messages rehash "${f[bashrc]}") ]] \
        && sudo tee --append "${f[bashrc]}" > "${f[null]}" <<< 'export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"' \
        && source "${f[bashrc]}"

    # pyenv versions
    # pyenv install --list | grep " 3\.[678]"
    [[ ! -d "${d[1]}" ]] && pyenv install "${latest}" &> "${f[null]}"

    pyenv global "${latest}" > "${f[null]}"

    unset l d m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
sublime_stuffs() {

    d=(
        ~/.config/sublime-text-3  # 0
        ~/.config/sublime-text-3/Installed\ Packages  # 1
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org  # 2
    )

    f+=(
        [config]=~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
        [hosts]=/etc/hosts
        [ppa]=/etc/apt/sources.list.d/sublime-text.list
        [exec]=/opt/sublime_text/sublime_text
        [license]=~/.config/sublime-text-3/Local/License.sublime_license
        [pkg_ctrl]=~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package
        [pkgs]=~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
        [anaconda]=~/.config/sublime-text-3/Packages/Anaconda/Anaconda.sublime-settings
        [keymap]=~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
        [REPL]=~/.config/sublime-text-3/Packages/SublimeREPL/SublimeREPL.sublime-settings
        [REPL_pyI]=~/.config/sublime-text-3/Packages/SublimeREPL/config/Python/Main.sublime-menu
        [REPL_pyII]=~/.config/sublime-text-3/Packages/SublimeREPL/sublimerepl.py
        [recently_used]=~/.local/share/recently-used.xbel
    )

    l=(
        'https://download.sublimetext.com/sublimehq-pub.gpg'  # 0
        'https://download.sublimetext.com/ apt/stable/'  # 1
        'https://packagecontrol.io/Package%20Control.sublime-package'  # 2
    )

    m=(
        'apt-transport-https'  # 0
        'sublime-text'  # 1
    )

	if [[ $(dpkg --list | awk "/ii  ${m[1]}[[:space:]]/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[1]^^} ${c[WHITE]}${linei:${#m[1]}} [INSTALLED]\n" "1"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[1]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[1]}" &> "${f[null]}"

                sudo rm --force --recursive "${d[0]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[1]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" "1"

		# 2> hides
        # Warning: apt-key output should not be parsed (stdout is not a terminal)
		[[ ! $(sudo apt-key list 2> "${f[null]}" | grep Sublime) ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | sudo apt-key add - &> "${f[null]}"

        [[ ! $(grep --no-messages sublimetext "${f[ppa]}") ]] \
            && sudo tee "${f[ppa]}" > "${f[null]}" <<< "deb ${l[1]}" \
            && update

        install_packages "${m[0]}" "${m[1]}"

    fi

    show "INITIALIZING CONFIGS..."

    while [[ ! -e "${d[0]}" ]]; do

        show "\nOPENING SUBLIME TO GENERATE A LOT OF CONFIG FILES.\nWAIT..."

        ( nohup subl & ) &> "${f[null]}"

        sleep 10s

        sudo pkill subl

    done

    # hexed.it: get position and convert to decimal, put in seek
    # Change executable binary sequence
    [[ $(xxd -p -seek 158612 -l 3 "${f[exec]}") =~ 97940d ]] \
        && sudo pkill subl \
        && printf '\00\00\00' | sudo dd of="${f[exec]}" bs=1 seek=158612 count=3 conv=notrunc status=none

    # Adding license key
    [[ ! $(grep --no-messages Member "${f[license]}") ]] \
        && sudo tee "${f[license]}" > "${f[null]}" <<< '----- BEGIN LICENSE -----
Member J2TeaM
Single User License
EA7E-1011316
D7DA350E 1B8B0760 972F8B60 F3E64036
B9B4E234 F356F38F 0AD1E3B7 0E9C5FAD
FA0A2ABE 25F65BD8 D51458E5 3923CE80
87428428 79079A01 AA69F319 A1AF29A4
A684C2DC 0B1583D4 19CBD290 217618CD
5653E0A0 BACE3948 BB2EE45E 422D2C87
DD9AF44B 99C49590 D2DBDEE1 75860FD2
8C8BB2AD B2ECE5A4 EFC08AF2 25A9B864
------ END LICENSE ------'

    # 2 simple tricks to block two sublime text servers, hides: "Your license key is not longer valid, and has been removed"
    [[ ! $(grep --no-messages sublimetext "${f[hosts]}") ]] \
        && sudo sed -i "3 a 127.0.0.1   www.sublimetext.com\n127.0.0.1   license.sublimehq.com\n" "${f[hosts]}"

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
    "installed_packages": ["Anaconda", "Djaneiro", "Restart", "SublimeREPL"]
}'

    [[ ! $(grep --no-messages rulers "${f[config]}") ]] \
        && sudo tee "${f[config]}" > "${f[null]}" <<< '{
    "ensure_newline_at_eof_on_save": true,
    "font_size": 12,
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
    "wrap_width": 80
}'

    while true; do

        ( nohup subl & ) &> "${f[null]}"

        echo && read -p $'\033[1;37mSUBLIME ALREADY INSTALL ALL PACKAGES? (SHOWS ASIDE BOTTOM LEFT) \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                sudo pkill subl && break

            elif [[ "${option:0:1}" = @(n|N) ]] ; then

                echo && show "I'LL RESTART... \n(RESTART IS REQUIRED AFTER PACKAGE CONTROL INSTALLATION)"

                sudo pkill subl && ( nohup subl & ) &> "${f[null]}"

                echo && read -p $'\033[1;37mPACKAGES ARE INSTALLED? \n[Y/N] R: \033[m' option

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SUBLIME ALREADY INSTALL PACKAGES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

        if [[ -e "${f[anaconda]}" ]]; then

            # Lint for python 3.6
            sudo sed -i 's|"python"|"/usr/bin/python3.6"|g' "${f[anaconda]}"

            sudo sed -i 's|"swallow_startup_errors": false|"swallow_startup_errors": true|g' "${f[anaconda]}"

            sudo tee "${f[keymap]}" > "${f[null]}" <<< '[
    // Key binding to run scripts py
    { "keys": ["ctrl+p"], "command": "run_existing_window_command", "args": {
        "id": "repl_python_run", "file": "config/Python/Main.sublime-menu" }
    },
    // Auto-pair escaped parentheses
    { "keys": ["("], "command": "insert_snippet", "args": {"contents": "($0)"}, "context":
        [
            { "key": "setting.auto_match_enabled", "operator": "equal", "operand": true },
            { "key": "selection_empty", "operator": "equal", "operand": true, "match_all": true },
            { "key": "following_text", "operator": "regex_contains", "operand": "^\"(?:\t| |\\)|]|;|\\}|\\\"|$)", "match_all": true }
        ]
    },
    // Auto-pair escaped curly brackets
    { "keys": ["{"], "command": "insert_snippet", "args": {"contents": "{$0}"}, "context":
        [
            { "key": "setting.auto_match_enabled", "operator": "equal", "operand": true },
            { "key": "selection_empty", "operator": "equal", "operand": true, "match_all": true },
            { "key": "following_text", "operator": "regex_contains", "operand": "^\"(?:\t| |\\)|]|;|\\}|\\\"|$)", "match_all": true }
        ]
    },
    // Auto-pair escaped braces
    { "keys": ["["], "command": "insert_snippet", "args": {"contents": "[$0]"}, "context":
        [
            { "key": "setting.auto_match_enabled", "operator": "equal", "operand": true },
            { "key": "selection_empty", "operator": "equal", "operand": true, "match_all": true },
            { "key": "following_text", "operator": "regex_contains", "operand": "^\"(?:\t| |\\)|]|;|\\}|\\\"|$)", "match_all": true }
        ]
    }
]'

            # Removes autocomplete at runtime
            sudo sed -zi 's|true|false|7' "${f[REPL]}"

            # Reuse same tab for multiple runtimes
            # https://github.com/wuub/SublimeREPL/issues/481
            sudo sed -zi 's|"R"|"r"|1' "${f[REPL_pyI]}"

            sudo sed -i 's|"R"|"d"|g' "${f[REPL_pyI]}"

            sudo sed -i 's|"P"|"p"|g' "${f[REPL_pyI]}"

            sudo sed -i 's|"I"|"p"|g' "${f[REPL_pyI]}"

            sudo sed -i 's|"D"|"d"|g' "${f[REPL_pyI]}"

            [[ ! $(grep --no-messages '"view_id"' "${f[REPL_pyI]}") ]] \
                && sudo sed -i 's|tmLanguage",|tmLanguage",\n\t\t\t\t\t\t"view_id": "*REPL* [python]",|g' "${f[REPL_pyI]}"

            sudo sed -zi 's|view.id|view.name|1' "${f[REPL_pyII]}"

            # PY don't run if mix tabs with space
            [[ ! $(grep --no-messages 'focus_view(found)' "${f[REPL_pyII]}") ]] \
                && sudo sed -i "s|found = view|found = view\n                    window.focus_view(found)|g" "${f[REPL_pyII]}"

            # Set python3 for runtime
            sudo sed -i 's|"python", |"python3", |g' "${f[REPL_pyI]}"

            sudo sed -zi 's|"python3", |"python", |4' "${f[REPL_pyI]}"

            sudo sed -zi 's|"python3", |"python", |5' "${f[REPL_pyI]}"

            echo && break

        fi

    done

    [[ ! $(grep --no-messages sublime "${f[mimeapps]}") ]] \
        && sudo tee --append "${f[mimeapps]}" > "${f[null]}" <<< 'text/plain=sublime_text.desktop
text/csv=sublime_text.desktop
application/xml=sublime_text.desktop
text/html=sublime_text.desktop
text/css=sublime_text.desktop
text/markdown=sublime_text.desktop
application/json=sublime_text.desktop
application/javascript=sublime_text.desktop
text/x-python=sublime_text.desktop
application/x-shellscript=sublime_text.desktop
application/x-subrip=sublime_text.desktop'

    [[ ! $(grep --no-messages sublime_text "${d[2]}"/*.json) ]] \
        && sudo sed -i 's|"nemo.desktop",|"nemo.desktop",\n\t\t\t"sublime_text.desktop",|g' "${d[2]}"/*.json

    unset d f l m

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

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

    sudo apt update &> "${f[null]}"; sudo apt upgrade -y &> "${f[null]}"

    unset f

}
#======================#

#======================#
tmate_stuffs() {  # Okzão

    m=(
        'tmate'  # 0
    )

    if [[ $(dpkg --list | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" &> "${f[null]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

        install_packages "${m[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    check_ssh

    unset m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
usefull_pkgs() {

    d=(
        ~/.cinnamon/configs/grouped-window-list@cinnamon.org  # 0
    )

    f+=(
        [vimrc]=~/.vimrc
    )

    # Se seu vlc estiver em inglês, instale: "vlc-l10n" e remova ~/.config/vlc
    m=(
        'tree'  # 0
        'vlc'  # 1
        'vim'  # 2
        'easytag'  # 3
        'telegram'  # 4
        'usefull packages'  # 4
    )

    if [[ $(dpkg --list | awk "/${m[0]}/ {print }" | wc -l) -ge 1 \
        && $(dpkg --list | awk "/${m[1]}/ {print }" | wc -l) -ge 1 \
        && $(dpkg --list | awk "/${m[2]}/ {print }" | wc -l) -ge 1 \
        && $(dpkg --list | awk "/${m[3]}/ {print }" | wc -l) -ge 1 \
        && $(dpkg --list | awk "/${m[4]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[5]^^} ${c[WHITE]}${linei:${#m[5]}} [INSTALLED]"

        read -p $'\033[1;37m\nSIR, SHOULD I UNINSTALL THEM? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}, ${c[RED]}${m[1]^^}${c[WHITE]}, ${c[RED]}${m[2]^^}${c[WHITE]}, ${c[RED]}${m[3]^^}${c[WHITE]} AND ${c[RED]}${m[4]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" &> "${f[null]}"

                [[ $(grep ^ "${f[srcs]}" "${f[srcs_list]}"/* | grep "${m[4]}") ]] \
                    && sudo add-apt-repository --remove -y ppa:atareao/telegram &> "${f[null]}"

                sudo rm --recursive --force "${f[vimrc]}"

                sudo sed -zi 's|video/x-matroska=vlc.desktop\nvideo/mp4=vlc.desktop||g' "${f[mimeapps]}"

                remove_useless

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n     I${c[WHITE]}NSTALLING ${c[GREEN]}${m[5]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" "1"

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}"

        [[ ! $(grep ^ "${f[srcs]}" "${f[srcs_list]}"/* | grep "${m[4]}") ]] \
            && sudo add-apt-repository -y ppa:atareao/telegram &> "${f[null]}"

        update && install_packages "${m[4]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    [[ ! $(grep --no-messages vlc "${f[mimeapps]}") ]] \
        && sudo tee --append "${f[mimeapps]}" > "${f[null]}" <<< 'video/x-matroska=vlc.desktop
video/mp4=vlc.desktop'

    [[ ! $(grep --no-messages "syntax" "${f[vimrc]}") ]] \
        && sudo tee "${f[vimrc]}" > "${f[null]}" <<< 'set encoding=UTF-8
syntax on
set autoread
set wildmenu
set number
set backspace=indent,eol,start  "Making sure backspace works
set noruler  "Setting up rulers & spacing, tabs
set confirm
set autoindent
set smartindent
set laststatus=2 "Setting the size for the command area, and airline status bar
set cmdheight=1
set background=dark'

    # Nomenclature icon arrangement
    [[ ! $(grep --no-messages telegram "${d[0]}"/*.json) ]] \
        && sudo sed -i 's|"google-chrome.desktop",|"google-chrome.desktop",\n\t\t\t"telegramdesktop.desktop",|g' "${d[0]}"/*.json

    unset d f m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
workspace_stuffs() {

    d=(
        /workspace  # 0
    )

    f+=(
        [bookmarks]=~/.config/gtk-3.0/bookmarks
    )

    l=(
        git@github.com:rafaelribeiroo/  # 0
    )

    m=(
        'workspace'  # 0
    )

    r=(
        scripts_py  # 0
        connecting_networks  # 1
        releasing_linux  # 2
        coffee_warm  # 3
        instrutions_sql  # 4
        alfred  # 5
    )

    if [[ -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) = ${USER} ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linec:${#m[0]}} [CREATED]\n" 1

        read -p $'\033[1;37mSIR, SHOULD I REMOVE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}R${c[WHITE]}EMOVING ${c[RED]}${d[0]^^}${c[WHITE]}!\n"

                sudo rm --force --recursive "${d[0]}"

                [[ $(grep --no-messages workspace "${f[bookmarks]}") ]] \
                    && sudo sed -i $'s|file:///workspace \360\237\221\211 Workspace||g' "${f[bookmarks]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        show "${c[GREEN]}\n\t  C${c[WHITE]}REATING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" "1"

        show "${c[GREEN]}C${c[WHITE]}REATING ${c[GREEN]}${m[0]^^}${c[WHITE]}!\n"

        sudo mkdir --parents "${d[0]}" > "${f[null]}"

        sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    # Lost your bookmarks? Run xdg-user-dirs-gtk-update
    [[ ! $(grep --no-messages workspace "${f[bookmarks]}") ]] \
        && sudo tee --append "${f[bookmarks]}" > "${f[null]}" <<< $'file:///workspace \360\237\221\211 Workspace'

    if [[ ! -d "${d[0]}"/"${r[0]}" \
        && ! -d "${d[0]}"/"${r[1]}" \
        && ! -d "${d[0]}"/"${r[2]}" \
        && ! -d "${d[0]}"/"${r[3]}" \
        && ! -d "${d[0]}"/"${r[4]}" ]]; then

        echo; read -p $'\033[1;37mSHOULD I DOWNLOAD SOME REPOSITORIES? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ ${option:0:1} = @(s|S|y|Y) ]] ; then

                ssh -o BatchMode=yes -T git@github.com &> "${f[ssh]}"

                [[ ! $(cat "${f[ssh]}" | grep successfully) ]] \
                    && show "\nFIRST THINGS FIRST. DO U PASS THROUGH GIT STUFFS?" \
                    && github_stuffs

                ssh -o BatchMode=yes -T git@github.com &> "${f[ssh]}"

                [[ $(cat "${f[ssh]}" | grep successfully) ]] \
                    && git clone --quiet "${l[0]}${r[0]}".git "${d[0]}"/"${r[0]}" \
                    && git clone --quiet "${l[0]}${r[1]}".git "${d[0]}"/"${r[1]}" \
                    && git clone --quiet "${l[0]}${r[2]}".git "${d[0]}"/"${r[2]}" \
                    && git clone --quiet "${l[0]}${r[3]}".git "${d[0]}"/"${r[3]}" \
                    && git clone --quiet "${l[0]}${r[4]}".git "${d[0]}"/"${r[4]}" \
                    && git clone --quiet "${l[0]}${r[5]}".git "${d[0]}"/"${r[5]}" \
                    && echo && break

            elif [[ ${option:0:1} = @(n|N) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I DOWNLOAD SOME REPOSITORIES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    unset d f l m r

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
invoca_funcoes() {

    case "${escolha}" in

        0|00) encerra_menu > "${f[null]}" ;;
        1|01) bash_stuffs && retorna_menu ;;
        2|02) deezloader_stuffs && retorna_menu ;;
        3|03) dualmonitor_stuffs && retorna_menu ;;
        4|04) github_stuffs && retorna_menu ;;
        5|05) chrome_stuffs && retorna_menu ;;
        6|06) flameshot_stuffs && retorna_menu ;;
        7|07) heroku_stuffs && retorna_menu ;;
        8|08) hide_devices && retorna_menu ;;
        9|09) minidlna_stuffs && retorna_menu ;;
        10) nvidia_stuffs && retorna_menu ;;
        11) postgres_stuffs && retorna_menu ;;
        12) py_libraries && retorna_menu ;;
        13) upgrade_py && retorna_menu ;;
        14) sublime_stuffs && retorna_menu ;;
        15) tmate_stuffs 1 && retorna_menu ;;
        16) usefull_pkgs 1 && retorna_menu ;;
        17) workspace_stuffs && retorna_menu ;;
        18) echo; show "KNOW YOUR LIMITS ${name[random]}...\n"

        d=(
            ~/.local/share/cinnamon/applets  # 0
            ~/.local/share/cinnamon/applets/betterlock  # 1
        )

        f+=(
            [automount]=/org/cinnamon/desktop/media-handling/automount
            [automount_open]=/org/cinnamon/desktop/media-handling/automount-open
            [autostart_blacklist]=/org/cinnamon/cinnamon-session/autostart-blacklist
            [capslock]=~/.local/share/cinnamon/applets/betterlock.zip
            [computer_icon]=/org/nemo/desktop/computer-icon-visible
            [default_sort_order]=/org/nemo/preferences/default-sort-order
            [default_sort_reverse]=/org/nemo/preferences/default-sort-in-reverse-order
            [enabled_applets]=/org/cinnamon/enabled-applets
            [grub]=/boot/grub/grub.cfg
            [home_icon]=/org/nemo/desktop/home-icon-visible
            [click_policy]=/org/nemo/preferences/click-policy
            [icon_theme]=/org/cinnamon/desktop/interface/icon-theme
            [looking_glass]=/org/cinnamon/desktop/keybindings/looking-glass-keybinding
            [numlock]=/etc/lightdm/slick-greeter.conf
            [paste]=/org/gnome/terminal/legacy/keybindings/paste
            [screensaver]=/org/cinnamon/desktop/keybindings/media-keys/screensaver
            [show_hidden]=/org/nemo/preferences/show-hidden-files
        )

        l=(
            'https://cinnamon-spices.linuxmint.com/files/applets/betterlock.zip'  # 0
        )

        m=(
            'dconf-editor'  # 0
            'numlockx'  # 1
        )

        install_packages "${m[0]}" "${m[1]}"

        # START APPLETS STUFFS
        if [[ ! -e "${f[capslock]}" ]]; then

            [[ ! -d "${d[0]}" || $(stat -c "%U" "${d[0]}" 2>&-) != "${USER}" ]] \
                && sudo mkdir --parents "${d[0]}" > "${f[null]}" \
                && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

            wget --quiet "${l[0]}" --output-document "${f[capslock]}"

        fi

        [[ ! -d "${d[1]}" ]] \
            && unzip "${d[0]}"/*.zip -d "${d[0]}" &> "${f[null]}" \
            && sudo rm --force "${f[capslock]}" # END APPLETS

        # START NUMLOCK ALWAYS ACTIVE AT STARTUP
        [[ ! -e "${f[numlock]}" ]] \
            && sudo tee "${f[numlock]}" > "${f[null]}" <<< '[Greeter]
activate-numlock=true'

        [[ $(grep --no-messages false "${f[numlock]}") ]] \
            && sudo sed -i 's|false|true|g' "${f[numlock]}"  # END NUMLOCK

        dconf write "${f[paste]}" "'<Ctrl>v'"

        dconf write "${f[computer_icon]}" false

        dconf write "${f[home_icon]}" false

        dconf write "${f[automount]}" true

        dconf write "${f[automount_open]}" true

        dconf write "${f[show_hidden]}" true

        dconf write "${f[click_policy]}" "'single'"

        dconf write "${f[looking_glass]}" "['<Ctrl><Alt>l']"

        dconf write "${f[screensaver]}" "['<Super>l', 'XF86ScreenSaver']"

        dconf write "${f[default_sort_order]}" "'name'"

        dconf write "${f[default_sort_reverse]}" false

        dconf write "${f[enabled_applets]}" "['panel1:left:0:menu@cinnamon.org:13', 'panel1:left:1:show-desktop@cinnamon.org:14', 'panel1:right:11:systray@cinnamon.org:16', 'panel1:right:12:notifications@cinnamon.org:18', 'panel1:right:13:printers@cinnamon.org:19', 'panel1:right:14:removable-drives@cinnamon.org:20', 'panel1:right:15:keyboard@cinnamon.org:21', 'panel1:right:16:network@cinnamon.org:22', 'panel1:right:17:sound@cinnamon.org:23', 'panel1:right:18:power@cinnamon.org:24', 'panel1:right:10:xapp-status@cinnamon.org:26', 'panel1:right:19:calendar@cinnamon.org:28', 'panel1:right:6:betterlock:31', 'panel1:left:2:grouped-window-list@cinnamon.org:35']"

        dconf write "${f[gtk_theme]}" "'Mint-Y-Dark-Red'"

        dconf write "${f[icon_theme]}" "'Mint-Y-Red'"

        dconf write "${f[autostart_blacklist]}" "['gnome-settings-daemon', 'org.gnome.SettingsDaemon', 'gnome-fallback-mount-helper', 'gnome-screensaver', 'mate-screensaver', 'mate-keyring-daemon', 'indicator-session', 'gnome-initial-setup-copy-worker', 'gnome-initial-setup-first-login', 'gnome-welcome-tour', 'xscreensaver-autostart', 'nautilus-autostart', 'caja', 'xfce4-power-manager', 'mintwelcome']"

        [[ $(grep --no-messages 'Boot Manager' "${f[grub]}") ]] \
            && sudo sed -i 's|Boot Manager|10|g' "${f[grub]}"

        unset d f l m

        bash_stuffs
        deezloader_stuffs
        dualmonitor_stuffs
        github_stuffs
        chrome_stuffs
        flameshot_stuffs
        heroku_stuffs
        hide_devices
        minidlna_stuffs
        nvidia_stuffs
        postgres_stuffs
        py_libraries
        sublime_stuffs
        upgrade
        tmate_stuffs
        usefull_pkgs
        workspace_stuffs

        echo; show "INITIALIZING CONFIGS..."; echo
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

        show "YOU SEE ONLY ONE END TO YOUR JOURNEY..."

        encerra_menu ;;

        *) echo -ne ${c[RED]}"\n   ${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}${c[WHITE]}\n\t\t  PLEASE, ONLY NUMBERS!\n"${c[END]}
        retorna_menu ;;
        # take_a_break &&

    esac
}
#======================#

#======================#
menu() {

	for (( ; ; )); do

        sleep 0.1s; show "${c[RED]}=======================================================" "1"

		for line in "${!logo[@]}"; do
            show "    ${c[RED]}${logo[${line}]}" "1"
            sleep 0.1s
        done

        sleep 0.1s; show "${c[RED]}=======================================================" "1"
        sleep 0.1s; show "${c[RED]}[ 00 ] ${c[WHITE]}EXIT ${e[0]}" "1"
        sleep 0.1s; show "${c[RED]}[ 01 ] ${c[WHITE]}BASH COLORFUL ${e[1]}" "1"
        sleep 0.1s; show "${c[RED]}[ 02 ] ${c[WHITE]}DEEZLOADER ${e[2]}" "1"
        sleep 0.1s; show "${c[RED]}[ 03 ] ${c[WHITE]}DUAL MONITOR SETUP ${e[3]}" "1"
        sleep 0.1s; show "${c[RED]}[ 04 ] ${c[WHITE]}GIT/GITHUB ${e[4]}" "1"
        sleep 0.1s; show "${c[RED]}[ 05 ] ${c[WHITE]}GOOGLE CHROME ${e[5]}" "1"
        sleep 0.1s; show "${c[RED]}[ 06 ] ${c[WHITE]}FLAMESHOT ${e[6]}" "1"
        sleep 0.1s; show "${c[RED]}[ 07 ] ${c[WHITE]}HEROKU ${e[7]}" "1"
        sleep 0.1s; show "${c[RED]}[ 08 ] ${c[WHITE]}HIDE WINDOWS DEVICES ${e[8]}" "1"
        sleep 0.1s; show "${c[RED]}[ 09 ] ${c[WHITE]}MINIDLNA ${e[9]}" "1"
        sleep 0.1s; show "${c[RED]}[ 10 ] ${c[WHITE]}NVIDIA DRIVER ${e[10]}" "1"
        sleep 0.1s; show "${c[RED]}[ 11 ] ${c[WHITE]}POSTGRES ${e[11]}" "1"
        sleep 0.1s; show "${c[RED]}[ 12 ] ${c[WHITE]}PY LIBRARIES ${e[12]}" "1"
        sleep 0.1s; show "${c[RED]}[ 13 ] ${c[WHITE]}PY UPGRADE ${e[12]}" "1"
        sleep 0.1s; show "${c[RED]}[ 14 ] ${c[WHITE]}SUBLIME TEXT ${e[13]}" "1"
        sleep 0.1s; show "${c[RED]}[ 15 ] ${c[WHITE]}TMATE ${e[14]}" "1"
        sleep 0.1s; show "${c[RED]}[ 16 ] ${c[WHITE]}USEFULL PROGRAMS ${e[15]}" "1"
        sleep 0.1s; show "${c[RED]}[ 17 ] ${c[WHITE]}WORKSPACE ${e[16]}" "1"
        sleep 0.1s; show "${c[RED]}[ 18 ] ${c[WHITE]}ALL ${e[17]}" "1"
        sleep 0.1s; show "${c[RED]}=======================================================" "1"

        read -n 2 -p $'\033[1;31m[    ]\033[m\033[4D' escolha

        # O read acima é inline, então passamos uma linha vazia para não afetar
        echo

		[[ "${escolha}" =~ ^[[:alpha:]]$ ]] \
			&& echo -ne ${c[RED]}"\n${e[18]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[18]}${c[WHITE]}\n\t\tPLEASE, ONLY NUMBERS!\n\n${c[WHITE]}WANT YOU RETURN SIR?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]} \
			&& read digitou_bobeira || invoca_funcoes "${escolha}"

			[[ "${digitou_bobeira:0:1}" == @(s|S|y|Y) ]] && retorna_menu \
            || encerra_menu && break

	done

}
#======================#

check_source
