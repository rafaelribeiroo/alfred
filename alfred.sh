#!/usr/bin/env bash

# /usr/bin/env no lugar de /bin/bash por causa da portabilidade, já que nem em
# todas as distros, ele estará em /bin/bash, faço isso pra alcançar mais users

#======================#
# ALFRED, programa de provisionamento de distro linux.
#======================#

#==========TRY=========#
# find . -type d -name '.git' | while read dir ; do sh -c "cd $dir/../ && echo -e \"\nGIT STATUS IN ${dir//\.git/}\" && git status -s" ; done
# Se não aparecer imagens nos arquivos de música
# rm -rf ~/.cache/thumbnails/fail*
# sudo apt install -y xplayer
#======================#

#======================#
# Autor: Rafael Ribeiro
# e-mail <pereiraribeirorafael@gmail.com>
# Versão: 3.7
#======================#

#======================#
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
    [WHITE]='\033[1;37m'  # 0
    [RED]='\033[31;1m'  # 1
    [GREEN]='\033[1;32m'  # 2
    [CYAN]='\033[1;36m'  # 3 CYAN
    [END]='\e[0m'  # 5 Sem mudança
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
    $'\360\237\214\211'  #  3 (paisagem): feh
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
    $'\360\237\231\212'  # 20 (macaco calado): senha
    $'\360\237\246\207'  # 21 (morcego): why do we fall...
    $'\360\237\223\267'  # 22 (câmera): flameshot
)

# usefull files
declare -A u=(
    # Only global items
    [askpass]=/lib/cryptsetup/askpass
    [bashrc]=~/.bashrc
    [mimeapps]=~/.config/mimeapps.list
    [null]=/dev/null
    [public_ssh]=~/.ssh/id_rsa.pub
    [user_dirs]=~/.config/user-dirs.dirs
)

# directories
d=()

# files
declare -A f=()

# links
l=()

# modules
m=()
#======================#

#======================#
check_distro() {

    f+=(
        [os_release]=/etc/os-release
    )

    check_os=$(cat "${f[os_release]}" | grep -w NAME | awk '{print $2}' | sed 's|"||')

    unset f

    if [[ "${check_os}" != 'Mint' ]]; then

        show "\n   ${e[21]} ${c[RED]}WHY WE FALL ${name[random]}? ${e[21]}\n${c[CYAN]}SO WE CAN LEARN TO PICK OURSELVES UP \n"

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

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t${c[WHITE]}     PLEASE, ONLY Y OR N!\n\nSR. DID U WANNA CONTINUE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

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

	# instalado
	if dpkg-query -s "${1}" > "${u[null]}" 2>&1; then

		return 0

	else

		# não instalado, porém disponível no registro de pacote
		if apt-cache show "${1}" > "${u[null]}" 2>&1; then

			return 1

		# não instalado/disponível
		else

			return 2

		fi

	fi

}
#======================#

#======================#
check_source() {

    [[ ${BASH_SOURCE[0]} -ef "${0}" ]] \
        && show "\n${c[RED-BLINK]}PLEASE, RUNS: source alfred.sh\n" 1 \
        && exit \
        || clear \
        && show "\n${c[RED]}===[${c[WHITE]} STARTING ${c[RED]}]===\n" \
        && clear; menu

}
#======================#

#======================#
check_ssh() {

    # Generate SSH keys silently. Ignore if exists
    [[ ! -e "${u[public_ssh]}" ]] && yes "" | ssh-keygen -N "" >&- 2>&-

}
#======================#

#======================#
encerra_menu() {

    show "\n${c[RED]}   FOR YOUR OWN SAKE,\n${c[CYAN]}THERE IS NO TURNING BACK...\n"

    [[ ${BASH_SOURCE[0]} -ef "${0}" ]] && exit || return 0

}
#======================#

#======================#
show() {

    echo -e ${c[WHITE]}"${1}"${c[END]}

    # Se passar 1, não "dorme"
    [[ "${2}" -eq 1 ]] || take_a_break

}
#======================#

#======================#
install_packages() {

    # $@: Truque para "desempacotar" todos os valores recebidos, tipo PY
    for package in "$@"; do

    	if check_pkg "${package}"; then

            # Por que não colocar as inúmeras validações se o pacote já existe
            # e se o usuário deseja desinstalar aqui pra economizar linha?
            # Porque se for várias dependências, ele vai perguntar uma a uma
            # ao invés de desinstalar o conjunto como um todo.
            [[ "${#}" -eq 1 ]] \
                && show "\n${c[GREEN]}${package^^} ${c[WHITE]}${linei:${#package}} [INSTALLED]\n" \
                || show "\n${c[GREEN]}${package^^} ${c[WHITE]}${linei:${#package}} [INSTALLED]"

        else

            if test "${?}" -eq 1; then

                [[ "${#}" -eq 1 ]] \
                    && show "\n${c[GREEN]}I${c[WHITE]}NSTALLING ${c[GREEN]}${package^^}${c[WHITE]}!\n" \
                    || show "\n${c[GREEN]}I${c[WHITE]}NSTALLING ${c[GREEN]}${package^^}${c[WHITE]}!"

                sudo apt install -y "${package}" > "${u[null]}" 2>&-

            fi

        fi

    done

}
#======================#

#======================#
remocao_inuteis() {

    sudo apt autoremove -y > "${u[null]}" 2>&-

    sudo apt autoclean > "${u[null]}"

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

#======================#
update() {

    # &> redirects stdout and stderr to file
    sudo apt update &> "${u[null]}"

}
#======================#

#======================#
bash_stuffs() {

    d+=(
        ~/.oh-my-bash  # 0
        ~/.fonts  # 1
        ~/.config/fontconfig/conf.d  # 2
    )

    f+=(
        [powerline_otf]=~/.fonts/PowerlineSymbols.otf
        [powerline_conf]=~/.config/fontconfig/conf.d/10-powerline-symbols.conf
        [config]=~/.oh-my-bash/oh-my-bash.sh
        [bkp]=~/.bashrc.pre-oh-my-bash
    )

    l+=(
        'https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh'  # 0
        'https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf'  # 1
        'https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf'  # 2
    )

    m+=(
        'oh-my-bash'  # 0
        'curl'  # 1
        'git'  # 2
    )

    if [[ -d "${d[0]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                # lost your .bashrc accidentally? Runs: cp /etc/skel/.bashrc ~/
                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                # --force: ignore nonexistent files, never prompt
                sudo rm --recursive --force "${d[0]}"

                sudo rm --force "${f[powerline_otf]}" "${f[powerline_conf]}"

                # Move bkp content to bashrc (oh-my-bash)
                [[ -e "${f[bkp]}" ]] && sudo mv "${f[bkp]}" "${u[bashrc]}"

                source "${u[bashrc]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_packages "${m[1]}" "${m[2]}"

        show "${c[GREEN]}\nI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]}!\n"

        # First /dev/null hide download progress, second hide thirty commands
        0> "${u[null]}" sh -c "$(curl --show-error --fail --silent --location ${l[0]})" &> "${u[null]}"

    fi

    show "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[powerline_otf]}" ]]; then

        # Hidden directories are owned by root, we must change owner to bash "read"
        # 2>&- prevent error message: "can't stat: no such file..."
        [[ ! -d "${d[1]}" || $(stat --format "%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[1]}" # Tranca saída de erro

        # --location follows to last URL (github provides a few redirects)
        # --output write content to file
        curl --location --silent --output "${f[powerline_otf]}" --create-dirs "${l[1]}"

        # Update font cache
        sudo fc-cache -vf "${d[1]}" > "${u[null]}"

    fi

    if [[ ! -e "${f[powerline_conf]}" ]]; then

        [[ ! -d "${d[2]}" || $(stat --format "%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[2]}"

        curl --location --silent --output "${f[powerline_conf]}" --create-dirs "${l[2]}"

    fi

    # If show error when open oh-my-base, run command below
    # [[ $(grep --files-with-matches "check_for_upgrade.sh" "${f[config]}") ]] \
    #     && sudo sed -zi 's|if \[ "$DISABLE_AUTO_UPDATE" != "true" \]; then\n  env OSH=$OSH DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT bash -f $OSH/tools/check_for_upgrade.sh\nfi||g' "${f[config]}"

    # Hide username from tty (hide #) and accepts pip freeze > requirements.txt
    [[ $(grep --files-without-match "DEFAULT_USER" "${u[bashrc]}") ]] \
        && sudo tee -a "${u[bashrc]}" > "${u[null]}" <<< "#DEFAULT_USER=${USER}
set +o noclobber" # tee is an "sudo echo" that works, -a to append (>>)

    # Install plugins
    [[ $(grep --files-without-match "agnoster" "${u[bashrc]}") && $(grep --files-without-match "plugins=(git" "${u[bashrc]}") ]] \
        && sudo sed -i 's|OSH_THEME="font"|OSH_THEME="agnoster"|g' "${u[bashrc]}" \
        && sudo sed -zi 's|plugins=(\n  git\n  bashmarks\n)|plugins=(git django python pyenv pip virtualenv)|g' "${u[bashrc]}"

    # Load changes
    source "${u[bashrc]}"

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
deezloader_stuffs() {

    d+=(
        ~/Deezloader\ Music  # 0
        ~/.config/Deezloader\ Remix  # 1
        ~/$(cat "${u[user_dirs]}" | grep MUSIC | awk --field-separator=/ '{print $2}' | sed 's|"||')/  # 2
    )

    l+=(
        'https://notabug.org/RemixDevs/DeezloaderRemix/wiki/Downloads'  # 0
        'https://notabug.org/RemixDevs/DeezloaderRemix'  # 1
    )

    f+=(
        [file]=~/$(cat "${u[user_dirs]}" | grep MUSIC | awk --field-separator=/ '{print $2}' | sed 's|"||')/$(curl --silent "${l[1]}" | grep --no-messages 64.AppImage | awk --field-separator='>' '{print $2}' | sed 's|</td||')
        [config]=~/.config/Deezloader\ Remix/config.json
    )

    m+=(
        'deezloader'  # 0
        'megatools'  # 1
    )

    link_latest=$(curl --location --silent "${l[0]}" | grep -6 "Linux x64" | tail -1 | awk --field-separator='"' '{print $2}' | sed 's|%..|!|g')

    if [[ -e "${f[file]}" || -d "${d[0]}" ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo rm --force "${f[file]}"

                sudo rm --recursive --force "${d[0]}" "${d[1]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_packages "${m[1]}"

        megadl --no-progress "${link_latest}" --path "${d[2]}"

    fi

    show "INITIALIZING CONFIGS..."

    # Checa permissão. Se não for executável, torna-o
    [[ $(stat --format "%a" "${f[file]}" 2>&-) -ne 755 ]] \
        && sudo chmod +x "${f[file]}"

    local_deezloader=$(stat --format "%n" "${d[2]}"Deez* | awk --field-separator=_ '{print $3}' | sed 's|-x86||')

    latest_deezloader=$(curl --silent "${l[0]}" | grep -1 "markdown" | tail -1 | awk '{print $3}' | sed 's|</h2>||')

    # Remove old deezloader and updates
    ( $(dpkg --compare-versions "${local_deezloader}" lt "${latest_deezloader}") ) \
        && sudo rm --force "${d[2]}"Deez* \
        && megadl --no-progress "${link_latest}" --path "${d[2]}"

    if [[ $(grep --files-without-match "${d[2]#~/}" "${f[config]}") ]]; then

        cd "${d[2]}" > "${u[null]}"

        # Run deezloader and free tty
        ( nohup ./"${f[file]#${d[2]}}" & ) > "${u[null]}" 2>&1

        read -p $'\033[1;37m\nHAVE YOU LOGON? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                if [[ ! -e "${f[config]}" ]]; then

                    echo -ne ${c[WHITE]}"\nNO, YOU DON'T\n[Y/N] R: "${c[END]}

                    read option

                else

                    kill -9 $(ps -aux | grep "/tmp/.mount_Deez" | grep "Sl" | head -1 | awk '{print $2}')

                    sudo sed -i "s|Deezloader Music/|${d[2]#~/}|g" "${f[config]}"

                    ( nohup ./"${f[file]#${d[2]}}" & ) > "${u[null]}" 2>&1

                    cd - > "${u[null]}"

                    break

                fi

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo -ne ${c[WHITE]}"\nTHEN DO IT! WAITING...\n[Y/N] R: "${c[END]}

                read option

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. DO U HAVE COMPLETE LOGIN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
feh_stuffs() {

    d+=(
        ~/.feh/  # 0
    )

    f+=(
        [dskt]=~/.config/autostart/FehBG.desktop
        [fehbg]=~/.fehbg
        [dft_bkg]=/usr/share/backgrounds/linuxmint/default_background.jpg
    )

    l+=(
        'https://images5.alphacoders.com/300/300707.jpg'  # 0
        'https://wallpapercave.com/wp/BXfl2ly.jpg'  # 1
    )

    m+=(
        'feh'  # 0
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                sudo rm --force "${f[dskt]}" "${f[fehbg]}"

                sudo rm --recursive --force "${d[0]}"

                [[ $(grep --files-without-match "default" "${f[start]}") ]] \
                    && sudo tee -a "${f[start]}" > "${u[null]}" <<< "background=${f[dft_bkg]}"

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    # --word-regexp don't match with disconnected
    if [[ $(xrandr --query | grep --word-regexp "connected" | wc -l) -eq 2 ]] ; then

        [[ ! -d "${d[0]}" || $(stat --format "%U" "${d[0]}" 2>&-) != ${USER} ]] \
            && mkdir --parents "${d[0]}" \
            && sudo chown --recursive "${USER}":"${USER}" "${d[0]}"

        curl --silent --output "${d[0]}l.jpg" --create-dirs "${l[0]}"

        curl --silent --output "${d[0]}r.jpg" --create-dirs "${l[1]}"

        feh --bg-scale "${d[0]}l.jpg" "${d[0]}r.jpg"

    fi

    [[ ! -e "${f[dskt]}" || $(grep --files-without-match "Feh" "${f[dskt]}") ]] \
        && sudo tee -a "${f[dskt]}" > "${u[null]}" <<< "[Desktop Entry]
Name=Feh
Type=Application
Exec=/home/${USER}/.fehbg
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
Name[pt_BR]=FehBG Wallpapers
Comment[pt_BR]=Wallpaper único para cada monitor
X-GNOME-Autostart-Delay=5" # here string: prevent unseless echo

    unset d f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
github_stuffs() {

    f+=(
        [config]=~/.gitconfig
        [ssh_config]=~/.ssh/config
        [check_successful]=/tmp/check_successful
    )

    l+=(
        'https://api.github.com/user/keys'  # 0
        'https://git-scm.com/'  # 1
    )

    m+=(
        'git'  # 0
        'vim'  # 1
        'git-cola'  # 2
        'jq'  # 3
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                sudo rm --force "${f[config]}"

                ( $(dpkg --compare-versions "${local_git}" eq "${latest_git}") ) \
                    && sudo add-apt-repository --remove -y ppa:git-core/ppa > /dev/null 2>&1

                sudo sed -zi 's|Host github.com\nHostname ssh.github.com\nPort 443||g' "${f[ssh_config]}"

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t    I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" && echo

    fi

    show "INITIALIZING CONFIGS..." 1

    # -l to check if file does not contain a string
    # Any changes pushed to GitHub, BitBucket, GitLab or another Git host
    # server in a later lesson will include this information.
    # from: https://swcarpentry.github.io/git-novice/02-setup/
    [[ ! -e "${f[config]}" || $(grep --files-without-match "@" "${f[config]}") ]] \
        && read -p $'\033[1;37m\nENTER YOUR EMAIL, '"${name[random]}"$': \033[m' email \
        && read -p $'\033[1;37mNAME '"${e[20]}"$': \033[m' nome \
        && git config --global user.email "${email}" \
        && git config --global user.name "${nome}" \
        && git config --global core.editor "vim" \
        && git config --global core.autocrlf input

    [[ $(dconf read /org/cinnamon/desktop/interface/gtk-theme) =~ .*Dark.* ]] \
        && git config --global cola.icontheme dark

    local_git=$(git --version | awk '{print $3}')

    latest_git=$(curl --silent "${l[1]}" | grep -1 '<span class="version">' | tail -1 | awk '{print $1}')

    ( $(dpkg --compare-versions "${local_git}" lt "${latest_git}") ) \
        && sudo add-apt-repository -y ppa:git-core/ppa > "${u[null]}" 2>&1 \
        && update \
        && sudo apt install -y "${m[0]}" > "${u[null]}" 2>&-

    check_ssh

    [[ ! -e "${f[ssh_config]}" || $(grep --files-without-match "github.com" "${f[ssh_config]}") ]] \
        && sudo tee -a "${f[ssh_config]}" > "${u[null]}" <<< 'Host github.com
    Hostname ssh.github.com
    Port 443'

    # GITHUB STUFF
    for (( ; ; )); do

        read -p $'\033[1;37m\nENTER YOUR USERNAME FROM GITHUB: \033[m' usuario

        senha=$("${u[askpass]}" $'\033[1;37mPASSWORD:\033[m')

        # Ver se dá pra fazer com awk '{print $2}'
        # Opções curl: s de silent, i de informações a mais, u de usuário
        check_integrity=$(curl --silent --include --user "${usuario}":"${senha}" "${l[0]}" | grep Status | awk '{print $2}')

        # Poupamos a condição abaixo, já que as mensagens de sucesso é 200 até 226
        # [[ "${check_integrity}" -eq 401 || "${check_integrity}" -eq 403 ]]
        [[ "${check_integrity}" -gt 400 ]] \
            && show "\n\t\t${c[WHITE]}TRY HARDER ${c[RED]}${name[random]}${c[WHITE]}!!!" 1 \
            || break

    done

    # Se não existir nenhuma chave no github
    if [[ -z $(curl --silent --user "${usuario}":"${senha}" "${l[0]}") ]]; then

        curl --silent --include --user "${usuario}":"${senha}" --data '{"title": "Enviado do meu iPhone","key": "'"$(cat "${u[public_ssh]}")"'"}' "${l[0]}" > "${u[null]}"

        echo

    else

        install_packages "${m[3]}"

        [[ \
            $(cat "${u[public_ssh]}" | awk '{print $2}') != \
            $(curl --silent --user "${usuario}":"${senha}" "${l[0]}" | jq ".[] | .key" | sed 's/.$//' | awk '{print $2}') \
        ]] \
            && show "THERE'S AN INCONSISTENCY IN YOUR LOCAL/REMOTE KEYS. FIXING!" \
            && curl --user "${usuario}":"${senha}" --request DELETE "${l[0]}"/"$(curl --silent --user ${usuario}:${senha} ${l[0]} | jq '.[] | .id')" \
            && curl --silent --include --user "${usuario}":"${senha}" --data '{"title": "Enviado do meu iPhone","key": "'"$(cat "${u[public_ssh]}")"'"}' "${l[0]}" > "${u[null]}" \
            && echo

    fi

    [[ ! -e "${f[check_successful]}" ]] \
        && ssh -T git@github.com 2> "${f[check_successful]}"

    [[ $(cat "${f[check_successful]}" | grep "successfully" | wc -l) -eq 0 ]] \
        && ssh -T -o StrictHostKeyChecking=no git@github.com > "${u[null]}" 2>&-

    unset f l m

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
chrome_stuffs() {

    f+=(
        [file]=~/$(cat "${u[user_dirs]}" | grep DOWNLOAD | awk --field-separator=/ '{print $2}' | sed 's|"||')/google-chrome-stable_current_amd64.deb
    )

    l+=(
        'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'  # 0
    )

    m+=(
        'google-chrome'  # 0
        'libappindicator1'  # 1
        'libindicator7'  # 2
        'libxss1'  # 3
    )

	if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" "${m[18]}" "${m[1]}" "${m[2]}" > "${u[null]}" 2>&-

                sudo sed -zi 's|text/html=google-chrome.desktop\nx-scheme-handler/http=google-chrome.desktop\nx-scheme-handler/https=google-chrome.desktop\nx-scheme-handler/about=google-chrome.desktop\nx-scheme-handler/unknown=google-chrome.desktop\nx-scheme-handler/mailto=google-chrome.desktop||g' "${u[mimeapps]}"

                sudo sed -i '\|"google-chrome.desktop",|d' "${d[13]}"/*.json

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # Dependências
        install_packages "${m[1]}" "${m[2]}" "${m[3]}"

        show "\n${c[GREEN]}I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]}!"

        [[ ! -e "${f[file]}" ]] \
            && curl --location --silent --output "${f[file]}" --create-dirs "${l[0]}"

        sudo dpkg -i "${f[file]}" &> "${u[null]}"

        sudo rm --force "${f[file]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    [[ ! -e "${u[mimeapps]}" || $(grep --files-without-match "google-chrome" "${u[mimeapps]}") ]] \
        && sudo tee "${u[mimeapps]}" > "${u[null]}" <<< '[Default Applications]
text/html=google-chrome.desktop
x-scheme-handler/http=google-chrome.desktop
x-scheme-handler/https=google-chrome.desktop
x-scheme-handler/about=google-chrome.desktop
x-scheme-handler/unknown=google-chrome.desktop
x-scheme-handler/mailto=google-chrome.desktop'

    [[ $(grep --files-without-match "google-chrome" "${d[13]}"/*.json) ]] \
        && sudo sed -i 's|"firefox.desktop",|"google-chrome.desktop",\n\t\t\t"firefox.desktop",|g' "${d[13]}"/*.json \
        && sudo sed -i 's|"org.gnome.Terminal.desktop",|"nemo.desktop",|g' "${d[13]}"/*.json \
        && sudo sed -zi 's|"nemo.desktop"|"org.gnome.Terminal.desktop"|4' "${d[13]}"/*.json

    unset f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
conky_stuffs() {

    f+=(
        [conkyrc]=~/.conkyrc
    )

    l+=(
        'https://gist.githubusercontent.com/rafaelribeiroo/81304bc07c7316ba841eacc90caf0564/raw/fa4ee571127b99d38fa93c9f7e0e4288edffd2b0/My%2520conkyrc%2520configs'  # 0
    )

    m+=(
        'conky'  # 0
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                sudo rm --force "${f[conkyrc]}"

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    [[ ! -e "${f[conkyrc]}" ]] \
        && curl --silent --output "${f[conkyrc]}" --create-dirs "${l[0]}"

    unset f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
flameshot_stuffs() {

    d+=(
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

    m+=(
        'flameshot'  # 0
        'dconf-editor'  # 1
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                sudo rm --force --recursive "${d[0]}"

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}" "${m[1]}" && echo

    fi

    show "INITIALIZING CONFIGS..."

    dconf write "${f[screenshot]}" "[]"

    dconf write "${f[cmd]}" "'flameshot gui --path /home/${USER}/$(cat "${u[user_dirs]}" | grep PICTURES | awk --field-separator=/ '{print $2}' | sed 's|"||')'"

    dconf write "${f[bdg]}" "['Print']"

    dconf write "${f[name]}" "'Flameshot'"

    dconf write "${f[custom]}" "['screenshot']"

    sudo sed -i 's|@Variant(\\0\\0\\0\\x7f\\0\\0\\0\\vQList<int>\\0\\0\\0\\0\\x13\\0\\0\\0\\0\\0\\0\\0\\x1\\0\\0\\0\\x2\\0\\0\\0\\x3\\0\\0\\0\\x4\\0\\0\\0\\x5\\0\\0\\0\\x6\\0\\0\\0\\x12\\0\\0\\0\\xf\\0\\0\\0\\a\\0\\0\\0\\b\\0\\0\\0\\t\\0\\0\\0\\x10\\0\\0\\0\\n\\0\\0\\0\\v\\0\\0\\0\\f\\0\\0\\0\\r\\0\\0\\0\\xe\\0\\0\\0\\x11)||g' "${f[config]}"

    [[ ! -e "${f[dskt]}" || $(grep --files-without-match "flameshot" "${f[dskt]}") ]] \
        && sudo tee "${f[dskt]}" > "${u[null]}" <<< '[Desktop Entry]
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

    l+=(
        'https://cli-assets.heroku.com/install-ubuntu.sh'  # 0
    )

    m+=(
        'heroku'  # 0
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        show "\n${c[GREEN]}I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]}!\n"

        bash -c "$(curl --silent ${l[0]})" &> "${u[null]}"

    fi

    show "INITIALIZING CONFIGS..." 1

	echo; read -p $'\033[1;37mWANT YOU AUTHENTICATE '"${name[random]}"$'? \n[Y/N] R: \033[m' option

	for (( ; ; )); do

		if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

    		echo && heroku login -i

            echo && break

		elif [[ "${option:0:1}" = @(n|N) ]] ; then

            echo && break

	    else

            echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. WANT YOU AUTHENTICATE?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

    	fi

    done

    unset l m

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
hide_devices() {  # Okzão

    d+=(
        /etc/udev/rules.d  # 0
    )

    f+=(
        [hide_rules]=/etc/udev/rules.d/99-hide-disks.rules
    )

    m+=(
        'devices'  # 0
    )

    check_devices=$(sudo fdisk --list | grep --extended-regexp "Microsoft dados básico|Microsoft basic data" | awk '{print $1}')

    if [[ -z "${check_devices}" ]]; then

        [[ "${1}" -eq 1 ]] \
            && show "\n  THERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!" \
            || show "\nTHERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!"

        retorna_menu

    else

        if [[ -e "${f[hide_rules]}" || $(grep --no-messages --files-with-matches "ID_FS_UUID" "${f[hide_rules]}") ]]; then

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${lineh:${#m[0]}} [HIDED]\n"

            read -p $'\033[1;37mSIR, SHOULD I SHOW THEM? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    show "\n${c[RED]}S${c[WHITE]}HOWING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                    sudo rm --force "${f[hide_rules]}"

                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    retorna_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    echo && break

                else

                    echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I SHOW THEM AGAIN?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            [[ "${1}" -eq 1 ]] \
                && show "${c[GREEN]}\n\t\t     H${c[WHITE]}IDING ${c[RED]}$((${#check_devices[@]} + 1))${c[WHITE]} ${c[GREEN]}${m[0]^^}${c[WHITE]}!" \
                || show "${c[GREEN]}\nH${c[WHITE]}IDING ${c[RED]}$((${#check_devices[@]} + 1))${c[WHITE]} ${c[GREEN]}${m[0]^^}${c[WHITE]}!"

            for device in "${check_devices}"; do

                devices+=(${device})

            done

            [[ ! -d "${d[0]}" || $(stat --format "%U" "${d[0]}" 2>&-) != ${USER} ]] \
                && mkdir --parents "${d[0]}" \
                && sudo chown --recursive ${USER}:${USER} "${d[0]}"

            # Na quantidade de itens em uma lista ele começa do 1
            for (( iterador=0; iterador<${#devices[@]}; iterador++ )); do

                tee -a "${f[hide_rules]}" > "${u[null]}" <<< 'ENV{ID_FS_UUID}=="'"$(blkid -s UUID -o value ${devices[${iterador}]})"'",ENV{UDISKS_IGNORE}="1"'

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

    d+=(
        ~/$(cat "${u[user_dirs]}" | grep VIDEO | awk --field-separator=/ '{print $2}' | sed 's|"||')/  # 0
    )

    f+=(
        [config]=/etc/minidlna.conf
        [dft]=/etc/default/minidlna
    )

    m+=(
        'minidlna'  # 0
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                sudo rm --force "${f[config]}"

                sudo rm --force "${f[default_minidlna]}"

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\tI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    if [[ $(grep --files-without-match "Mídias" "${f[config]}") ]]; then

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

    fi

	echo; read -p $'\033[1;37mSHOULD I RESTART THE SERVICE SIR? \n[Y/N] R: \033[m' option

	for (( ; ; )); do

		if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            [[ $(systemctl is-active "${m[0]}".service) = 'active' ]] \
                && sudo service minidlna restart \
                && sudo service minidlna force-reload \
                || sudo service minidlna start

            echo && break

		elif [[ "${option:0:1}" = @(n|N) ]] ; then

            echo && break

	    else

            echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read option

    	fi

    done

    unset d f m

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
nvidia_stuffs() {

    f+=(
        [nvidia_ppa]=/etc/apt/sources.list.d/graphics-drivers-ppa-bionic.list
        [hide_driver]=/etc/modprobe.d/blacklist-nouveau.conf
    )

    l+=(
        'https://www.nvidia.com/Download/driverResults.aspx/157462/en-us'  # 0
    )

    m+=(
        'nvidia-driver'  # 0
        'nouveau-driver'  # 1
    )

    latest_nvidia=$(curl --silent "${l[0]}" | grep -1 '"tdVersion"' | tail -1 | awk --field-separator=. '{print $1}' | sed 's| ||g')

    # https://4fasters.com.br/2018/04/26/benchmark-nvidia-driver-do-fabricante-vs-driver-open-source-no-linux/
    # -class: Exibe apenas informações do display
    check_nvidia_existence=$(sudo lshw -class display | grep --extended-regexp "fabricante|vendor" | awk '{print $2}')

    if [[ "${check_nvidia_existence}" != "NVIDIA" ]]; then

        [[ "${1}" -eq 1 ]] \
            && show "\n\tTHERE'S NO NVIDIA CARD IN YOUR MACHINE!" \
            || show "\nTHERE'S NO NVIDIA CARD IN YOUR MACHINE!"

        retorna_menu

    else

        # Identifica qual o driver está sendo utilizado no momento.
        # nouveau: o padrão/nvidia_drm: terceiros.
        check_driver=$(lsmod | grep drm_kms_helper | head -1 | awk '{print $4}')

        if [[ "${check_driver%%_drm}" = "nvidia" ]]; then

            show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

            read -p $'\033[1;37mSIR, SHOULD I RESTORE NOUVEAU DRIVER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    show "\n${c[RED]}R${c[WHITE]}ESTORING ${c[RED]}${m[1]^^}${c[WHITE]}!\n"



                    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    retorna_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    echo && break

                else

                    echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTORE DEFAULT DRIVER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                    read option

                fi

            done

        else

            [[ "${1}" -eq 1 ]] \
                && show "${c[GREEN]}\n      I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

            [[ ! $(apt search nvidia-driver-"${latest_nvidia}") ]] \
                && sudo add-apt-repository -y ppa:graphics-drivers/ppa > "${u[null]}" 2>&1 \
                && update

            install_packages "${m[0]}-${latest_nvidia}"

        fi

    fi

    show "INITIALIZING CONFIGS..."

    local_nvidia=$(apt version "${m[0]}-*")

    if ( $(dpkg --compare-versions "${local_nvidia}" lt "${latest_nvidia}") ); then

        [[ ! -e "${nvidia_ppa}" ]] \
            && sudo add-apt-repository -y ppa:graphics-drivers/ppa > "${u[null]}" 2>&1 \
            && update \
            && sudo apt install -y "${m[0]}" > "${u[null]}" 2>&-

    fi

    if [[ ! -e "${f[hide_driver]}" || $(grep --files-without-match "nouveau" "${f[hide_driver]}") ]]; then

        sudo tee "${f[hide_driver]}" > "${u[null]}" <<< 'blacklist nouveau
blacklist lbm-nouveau
alias nouveau off
alias lbm-nouveau off'

        sudo update-initramfs -u > "${u[null]}"

        read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

    	for (( ; ; )); do

    		if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                reboot

    		elif [[ "${option:0:1}" = @(n|N) ]] ; then

                break

    	    else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

        	fi

        done

    fi

    unset f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
postgres_stuffs() {

    f+=(
        [postgres_ppa]=/etc/apt/sources.list.d/pgdg.list
        [config]=/etc/postgresql/11/main/postgresql.conf
        [postgres_hba]=/etc/postgresql/11/main/pg_hba.conf
    )

    l+=(
        'https://www.postgresql.org/media/keys/ACCC4CF8.asc'  # 0
    )

    m+=(
        'postgresql-11'  # 0: Núcleo do servidor de banco de dados
        'postgresql-client-11'  # 1: Bibliotecas/binários client
        'postgresql-contrib-9.6'  # 2: Módulos adicionais
        'libpq-dev'  # 3: Bibliotecas e headers para compilar programas C
        'pgadmin4'  # 4: Utilitário gráfico administrativo
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "${c[RED]}\nU${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" > "${u[null]}" 2>&-



                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        [[ ! $(sudo apt-key list 2> "${u[null]}" | grep "PostgreSQL") ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | sudo apt-key add - > "${u[null]}"

        # Apontando o host do postgres no sources.list
    	[[ ! -e "${f[postgres_ppa]}" || $(grep --files-without-match "bionic-pgdg" "${f[postgres_ppa]}") ]] \
    		&& sudo tee "${f[postgres_ppa]}" > "${u[null]}" <<< 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' \
            && update

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}"

    fi

    show "INITIALIZING CONFIGS..."

    sudo sed -i "s|#listen_addresses|listen_addresses|g" "${f[config]}"

    if [[ $(grep --files-without-match "local   all             postgres                                md5" "${f[postgres_hba]}") ]]; then

        # Antes de alterar a criptografia do postgres, devemos criar uma senha
        senha=$("${u[askpass]}" $'\033[1;37mPASSWORD OF USER POSTGRES \033[31;1m(root)\033[1;37m:\033[m')

        sudo --username postgres psql --command "ALTER USER postgres WITH ENCRYPTED PASSWORD '${senha}'"

        sudo sed -i "s|local   all             postgres                                peer|local   all             postgres                                md5|g" "${f[postgres_hba]}"

    fi

    # Usuário: Acesso ao console
    read -p $'\033[1;37m\nDO U WANT A USER TO ACCESS THE CONSOLE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ ${option:0:1} = @(s|S|y|Y) ]] ; then

            read -p $'\033[1;37m\nENTER THE USER: \033[m' user

            [[ $(psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='${user}'") -eq 1 ]] \
                && show "USER ${c[RED]}${user^^}${c[WHITE]} ALREADY EXISTS. BREAKING." \
                && break

            senha=$("${u[askpass]}" $'\033[1;37m\nPASSWORD OF USER '"${user^^}"$':\033[m')

            sudo --username postgres psql --command "CREATE USER ${user} WITH ENCRYPTED PASSWORD '${senha}'"

            sudo --username postgres psql --command "ALTER ROLE ${user} SET client_encoding TO 'utf8'"

            sudo --username postgres psql --command "ALTER ROLE ${user} SET default_transaction_isolation TO 'read committed'"

            sudo --username postgres psql --command "ALTER ROLE ${user} SET timezone TO 'America/Sao_Paulo'"

            break

        elif [[ ${option:0:1} = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

            read resposta

        fi

    done

	# Verifica status do postgres
    [[ $(systemctl is-active postgresql.service) = 'active' ]] \
        && sudo service postgresql restart \
        || sudo service postgresql start

    unset f l m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
py_libraries() {

    l+=(
        'https://pypi.org/project/pip/'  # 0
    )

    m+=(
        'python-pip'  # 0
        'python-dev '  # 1
        'build-essential'  # 2
        'pip'  # 3
    )

	install_packages "${m[0]}" "${m[1]}" "${m[2]}"
	# python-pip: gerenciador de pacotes
	# build-essential: inclui make, automake, fakerrot etc
	# python-dev: bibliotecas de compilação (caso algum pacote precise).

    latest_pip=$(curl --silent "${l[0]}" | grep -1 '<h1 class="package-header__name">' | tail -1 | awk '{print $2}')
    "${m[3]}" install -U "${m[3]}"

    unset l m

}
#======================#

#======================#
upgrade_py() {  # OKzão

    l+=(
        'https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer'  # 0
        'https://www.python.org/doc/versions/'  # 1
    )

    d+=(
        ~/.pyenv  # 0
        ~/.pyenv/versions/$(curl --silent --show-error --fail "${l[1]}" | grep external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')/  # 1
    )

    m+=(
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
    )

    local_python=$(apt version "${m[1]}")

    latest_python=$(curl --silent "${l[1]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')

    if ( $(dpkg --compare-versions "${local_python}" eq "${latest_python}") ); then

        show "\n${c[GREEN]}${m[1]^^} ${c[WHITE]}${lineu:${#m[1]}} [UPGRADED]\n"

        read -p $'\033[1;37mSIR, SHOULD I DOWNGRADE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}R${c[WHITE]}ESETING ${c[RED]}${m[1]^^}${c[WHITE]}!\n"

                pyenv global system

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESET?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t   I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

        # Dependências
        install_packages "${m[1]}" "${m[2]}" "${m[3]}" "${m[4]}" "${m[5]}" "${m[6]}" "${m[7]}" "${m[8]}" "${m[9]}" "${m[10]}" "${m[11]}"

        [[ ! -d "${d[0]}" ]] \
            && show "${c[GREEN]}\nI${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]}!" \
            && bash -c "$(curl --location --silent ${l[0]})" &> "${u[null]}"

        echo

    fi

    show "INITIALIZING CONFIGS..."

    [[ $(grep --files-without-match "pyenv init" "${u[bashrc]}") ]] \
        && sudo tee -a "${u[bashrc]}" > "${u[null]}" <<< 'export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"' \
        && source "${u[bashrc]}"

    # pyenv versions
    # pyenv install --list
    [[ ! -d "${d[1]}" ]] && pyenv install "${latest_python}" &> "${u[null]}"

    pyenv global "${latest_python}"

    unset l d m

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
sublime_stuffs() {

    l+=(
        'https://download.sublimetext.com/sublimehq-pub.gpg'  # 0
        'https://download.sublimetext.com/ apt/stable/'  # 1
        'https://packagecontrol.io/Package%20Control.sublime-package'  # 2
    )

    d+=(
        ~/.config/sublime-text-3  # 0
        ~/.config/sublime-text-3/Installed\ Packages  # 1
    )

    f+=(
        [subl_ppa]=/etc/apt/sources.list.d/sublime-text.list
        [subl_exec]=/opt/sublime_text/sublime_text
        [subl_license]=~/.config/sublime-text-3/Local/License.sublime_license
        [subl_pkg_ctrl]=~/.config/sublime-text-3/Installed\ Packages/Package\ Control.sublime-package
        [subl_pkg]=~/.config/sublime-text-3/Packages/User/Package\ Control.sublime-settings
        [subl_anaconda]=~/.config/sublime-text-3/Packages/Anaconda/Anaconda.sublime-settings
        [subl_keymap]=~/.config/sublime-text-3/Packages/User/Default\ \(Linux\).sublime-keymap
        [subl_settings]=~/.config/sublime-text-3/Packages/User/Preferences.sublime-settings
        [subl_REPL]=~/.config/sublime-text-3/Packages/SublimeREPL/SublimeREPL.sublime-settings
        [subl_REPL_pyI]=~/.config/sublime-text-3/Packages/SublimeREPL/config/Python/Main.sublime-menu
        [subl_REPL_pyII]=~/.config/sublime-text-3/Packages/SublimeREPL/sublimerepl.py
        [recently_used]=~/.local/share/recently-used.xbel
    )

    m+=(
        'sublime-text'  # 0: Editor de texto
        'apt-transport-https'  # 1: Dependência
    )

	if [[ $(dpkg -l | awk "/${m[0]}/" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n       I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}DEPENDENCIES${c[WHITE]}!" 1

		# Verifica certificado de segurança (apt-key list)
		[[ ! $(sudo apt-key list 2> "${u[null]}" | grep "Sublime") ]] \
            && sudo wget --quiet --output-document - "${l[0]}" | sudo apt-key add - > "${u[null]}"

        # Dependências
        install_packages "${m[1]}"

        [[ ! -e "${f[subl_ppa]}" || $(grep --files-without-match "sublimetext" "${f[subl_ppa]}") ]] \
            && sudo tee "${f[subl_ppa]}" > "${u[null]}" <<< "deb ${l[1]}" \
            && update

        install_packages "${m[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    # Não sai do loop enquanto o sublime não cria os arquivos padrões
    for (( ; ; )); do

        if [[ -d "${d[0]}" ]]; then

            # hexed.it: get position and convert to decimal, put in seek
            # Altera sequência binária do executável
            [[ $(xxd -p -seek 158612 -l 3 "${f[subl_exec]}") =~ "97940d" ]] \
                && sudo pkill subl \
                && printf '\00\00\00' | dd of="${f[subl_exec]}" bs=1 seek=158612 count=3 conv=notrunc status=none

            # Inserindo a chave do produto
            [[ ! -e "${f[subl_license]}" || $(grep --files-without-match "Member" "${f[subl_license]}") ]] \
                && sudo tee "${f[subl_license]}" > "${u[null]}" <<< '----- BEGIN LICENSE -----
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

            # Remove histórico de modificações no arquivo
            # sudo rm --force "${f[recently_used]}"

            [[ ! -e "${f[subl_pkg_ctrl]}" ]] \
                && sudo mkdir --parents "${d[1]}" \
                && sudo chown --recursive ${USER}:${USER} "${d[1]}" \
                && curl --location --silent --output "${f[subl_pkg_ctrl]}" --create-dirs "${l[2]}"

            [[ ! -e "${f[subl_pkg]}" || $(grep --files-without-match "packages" "${f[subl_pkg]}") ]] \
                && sudo tee "${f[subl_pkg]}" > "${u[null]}" <<< '{
    "installed_packages": ["Anaconda", "Djaneiro", "Restart", "SublimeREPL"]
}'

    		for (( ; ; )); do

				# Se instalou um pacote, instalou o restante também, então...
	            if [[ -e "${f[subl_anaconda]}"  ]]; then

	                # Informando ao Anaconda para sublinhar aos códigos específicos do PY 3.6
	                sudo sed -i 's|"python"|"/usr/bin/python3.6"|g' "${f[subl_anaconda]}"

	                sudo sed -i 's|"swallow_startup_errors": false|"swallow_startup_errors": true|g' "${f[subl_anaconda]}"

                    sudo tee -a "${f[subl_keymap]}" > "${u[null]}" <<< '{
    "keys": ["ctrl+p"], "command": "run_existing_window_command", "args": {
        "id": "repl_python_run", "file": "config/Python/Main.sublime-menu"
    }
}'

                    sudo tee -a "${f[subl_settings]}" > "${u[null]}" <<< '{
    // default value is []
    "rulers": [80],

    "word_wrap": false,

    "wrap_width": 80,

    "tab_size": 4,
    "translate_tabs_to_spaces": true,
    "trim_trailing_white_space_on_save": true,
    "ensure_newline_at_eof_on_save": true,

    "font_size": 12,
}'

					# Remover o autocomplete no interpretador
					sudo sed -zi 's|true|false|7' "${f[subl_REPL]}"

	                # Reutilizar mesma tab para várias runtimes
                    # https://github.com/wuub/SublimeREPL/issues/481
                    sudo sed -zi 's|"R"|"r"|1' "${f[subl_REPL_pyI]}"

                    sudo sed -i 's|"R"|"d"|g' "${f[subl_REPL_pyI]}"

                    sudo sed -i 's|"P"|"p"|g' "${f[subl_REPL_pyI]}"

                    sudo sed -i 's|"I"|"p"|g' "${f[subl_REPL_pyI]}"

                    sudo sed -i 's|"D"|"d"|g' "${f[subl_REPL_pyI]}"

                    [[ $(grep --files-without-match '"view_id"' "${f[subl_REPL_pyI]}") ]] \
                        && sudo sed -i 's|tmLanguage",|tmLanguage",\n\t\t\t\t\t\t"view_id": "*REPL* [python]",|g' "${f[subl_REPL_pyI]}"

                    sudo sed -zi 's|view.id|view.name|1' "${f[subl_REPL_pyII]}"

                    [[ $(grep --files-without-match "focus_view(found)" "${f[subl_REPL_pyII]}") ]] \
                        && sudo sed -i "s|found = view|found = view\n\t\t\t\t\twindow.focus_view(found)|g" "${f[subl_REPL_pyII]}"

                    # Seta versão recente do PY para execuções de scripts
                    sudo sed -i 's|"python", |"python3", |g' "${f[subl_REPL_pyI]}"

                    sudo sed -zi 's|"python3", |"python", |4' "${f[subl_REPL_pyI]}"

                    sudo sed -zi 's|"python3", |"python", |6' "${f[subl_REPL_pyI]}"

            	else

                    ( nohup subl & ) > "${u[null]}" 2>&1

                    for contador in {1..10..1}; do

                        take_a_break

                    done

                    sudo pkill subl*

                fi

            done

        break

        else

            show "\nAcessaremos o sublime para ele criar o diretório padrão."

            # O sublime cria os diretórios padrão quando executado pela 1a vez
            ( nohup subl & ) > "${u[null]}" 2>&1

            take_a_break

            sudo pkill subl*

        fi

    done

}
#======================#

#======================#
upgrade() {

    f+=(
        [apt_history]=/var/log/apt/history.log
    )

    # Filtra a última data em que foram realizadas atualizações
    last=$(grep "Start-Date" "${f[apt_history]}" | tail -1 | awk '{print $2}')

    # Modifica o formato de data pro BR
    date=$(date -d "${last}" +"%d/%m/%Y")
    show "OH ${name[random]}, LAST TIME WE'VE SEEN YOU WAS IN\n\t\t${c[CYAN]}${date}\n\n${c[WHITE]}UPGRADING..."

    sudo apt update > "${u[null]}" 2>&-; sudo apt upgrade -y > "${u[null]}" 2>&-

}
#======================#

#======================#
tmate_stuffs() {  # Okzão

    m+=(
        'tmate'  # 0
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" > "${u[null]}" 2>&-

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t  I${c[WHITE]}NSTALLING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    check_ssh

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
usefull_pkgs() {

    f+=(
        [vimrc]=~/.vimrc
    )

    # Se seu vlc estiver em inglês, instale: "vlc-l10n" e remova ~/.config/vlc
    m+=(
        'tree'  # 0
        'vlc'  # 1
        'vim'  # 2
        'easytag'  # 3
        'usefull packages'  # 4
    )

    if [[ $(dpkg -l | awk "/${m[0]}/ {print }" | wc -l) -ge 1 \
        && $(dpkg -l | awk "/${m[1]}/ {print }" | wc -l) -ge 1 \
        && $(dpkg -l | awk "/${m[2]}/ {print }" | wc -l) -ge 1 \
        && $(dpkg -l | awk "/${m[3]}/ {print }" | wc -l) -ge 1 ]]; then

        for package in "${m[@]}"; do

            show "\n${c[GREEN]}${package^^} ${c[WHITE]}${linei:${#package}} [INSTALLED]"

        done

        read -p $'\033[1;37m\nSIR, SHOULD I UNINSTALL THEM? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}U${c[WHITE]}NINSTALLING ${c[RED]}${m[0]^^}${c[WHITE]}, ${c[RED]}${m[1]^^}${c[WHITE]}, ${c[RED]}${m[2]^^}${c[WHITE]} AND ${c[RED]}${m[3]^^}${c[WHITE]}!\n"

                sudo apt remove --purge -y "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}" > "${u[null]}" 2>&-

                sudo rm --recursive --force "${f[vimrc]}"

                sudo sed -zi 's|video/x-matroska=vlc.desktop\nvideo/mp4=vlc.desktop||g' "${u[mimeapps]}"

                remocao_inuteis

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n     I${c[WHITE]}NSTALLING ${c[GREEN]}${m[4]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!" 1

        install_packages "${m[0]}" "${m[1]}" "${m[2]}" "${m[3]}"; echo

    fi

    show "INITIALIZING CONFIGS..."

    [[ ! -e "${u[mimeapps]}" || $(grep --files-without-match "vlc" "${u[mimeapps]}") ]] \
        && sudo tee -a "${u[mimeapps]}" > "${u[null]}" <<< 'video/x-matroska=vlc.desktop
video/mp4=vlc.desktop'

    [[ ! -e "${f[vimrc]}" || $(grep --files-without-match "set number" "${u[mimeapps]}") ]] \
        && sudo tee "${f[vimrc]}" > "${u[null]}" <<< 'set encoding=UTF-8
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

    echo; show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
workspace_stuffs() {  # Okzão

    d+=(
        /workspace  # 0
    )

    f+=(
        [bookmarks]=~/.config/gtk-3.0/bookmarks
    )

    l+=(
        git@github.com:rafaelribeiroo/  # 0
    )

    m+=(
        'workspace'  # 0: String para satisfazer função: "workspace()"
    )

    r=(
        scripts_py  # 0
        connecting_networks  # 1
        releasing_linux  # 2
        coffee_warm  # 3
        instrutions_sql  # 4
    )

    if [[ -d "${d[0]}" || $(stat --format "%U" "${d[0]}" 2>&-) = ${USER} ]]; then

        show "\n${c[GREEN]}${m[0]^^} ${c[WHITE]}${linec:${#m[0]}} [CREATED]\n"

        read -p $'\033[1;37mSIR, SHOULD I REMOVE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                show "\n${c[RED]}R${c[WHITE]}EMOVING ${c[RED]}${d[0]^^}${c[WHITE]}!\n"

                sudo rm --recursive --force "${d[0]}"

                [[ $(grep --files-with-matches "workspace" "${f[bookmarks]}") ]] \
                    && sudo sed -i 's|file:///workspace workspace||g' "${f[bookmarks]}"

                show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && show "${c[GREEN]}\n\t  C${c[WHITE]}REATING ${c[GREEN]}${m[0]^^}${c[WHITE]} AND ${c[GREEN]}CONFIGURATING${c[WHITE]}!\n" 1 \
            || show "${c[GREEN]}\nC${c[WHITE]}REATING ${c[GREEN]}${m[0]^^}${c[WHITE]}!\n"

        sudo mkdir --parents "${d[0]}"

        sudo chown --recursive ${USER}:${USER} "${d[0]}"

    fi

    show "INITIALIZING CONFIGS..."

    [[ ! -e "${f[bookmarks]}" || $(grep --files-without-match "workspace" "${f[bookmarks]}") ]] \
        && sudo tee -a "${f[bookmarks]}" > "${u[null]}" <<< 'file:///workspace workspace'

    if [[ ! -d "${d[0]}"/"${r[0]}" \
        && ! -d "${d[0]}"/"${r[1]}" \
        && ! -d "${d[0]}"/"${r[2]}" \
        && ! -d "${d[0]}"/"${r[3]}" \
        && ! -d "${d[0]}"/"${r[4]}" ]]; then

        echo; read -p $'\033[1;37mSHOULD I DOWNLOAD SOME REPOSITORIES? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ ${option:0:1} = @(s|S|y|Y) ]] ; then

                echo; show "FIRST THINGS FIRST. DO U PASS THROUGH GIT STUFFS?" 1

                github_stuffs

                git clone -q "${l[0]}${r[0]}".git "${d[0]}"/"${r[0]}"

                git clone -q "${l[0]}${r[1]}".git "${d[0]}"/"${r[1]}"

                git clone -q "${l[0]}${r[2]}".git "${d[0]}"/"${r[2]}"

                git clone -q "${l[0]}${r[3]}".git "${d[0]}"/"${r[3]}"

                git clone -q "${l[0]}${r[4]}".git "${d[0]}"/"${r[4]}"

                echo && break

            elif [[ ${option:0:1} = @(n|N) ]] ; then

                echo && break

            else

                echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[WHITE]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I DOWNLOAD SOME REPOSITORIES?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]}

                read option

            fi

        done

    fi

    show "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
invoca_funcoes() {

    case "${escolha}" in

        0|00) encerra_menu > "${u[null]}" ;;
        1|01) bash_stuffs 1 && retorna_menu ;;
        2|02) deezloader_stuffs 1 && retorna_menu ;;
        3|03) feh_stuffs 1 && retorna_menu ;;
        4|04) github_stuffs 1 && retorna_menu ;;
        5|05) chrome_stuffs 1 && retorna_menu ;;
        6|06) conky_stuffs && retorna_menu ;;
        7|07) flameshot_stuffs && retorna_menu ;;
        8|08) heroku_stuffs 1 && retorna_menu ;;
        9|09) hide_devices 1 && retorna_menu ;;
        10) minidlna_stuffs 1 && retorna_menu ;;
        11) nvidia_stuffs 1 && retorna_menu ;;
        12) postgres_stuffs 1 && retorna_menu ;;
        13) py_libraries && retorna_menu ;;
        14) upgrade_py 1 && retorna_menu ;;
        15) sublime_stuffs && retorna_menu ;;
        16) upgrade && retorna_menu ;;
        17) tmate_stuffs 1 && retorna_menu ;;
        18) usefull_pkgs 1 && retorna_menu ;;
        19) workspace_stuffs 1 && retorna_menu ;;
        20) echo; show "KNOW YOUR LIMITS ${name[random]}..."

        d+=(
            ~/.local/share/cinnamon/applets/pomodoro@gregfreeman.org  # 15
            ~/.local/share/cinnamon/applets/betterlock  # 16
            ~/.local/share/cinnamon/applets/  # 14
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
            [gtk_theme]=/org/cinnamon/desktop/interface/gtk-theme
            [home_icon]=/org/nemo/desktop/home-icon-visible
            [icon_theme]=/org/cinnamon/desktop/interface/icon-theme
            [looking_glass]=/org/cinnamon/desktop/keybindings/looking-glass-keybinding
            [numlock]=/etc/lightdm/slick-greeter.conf
            [paste]=/org/gnome/terminal/legacy/keybindings/paste
            [pomodoro]=~/.local/share/cinnamon/applets/pomodoro@gregfreeman.org.zip
            [screensaver]=/org/cinnamon/desktop/keybindings/media-keys/screensaver
            [show-hidden]=/org/nemo/preferences/show-hidden-files
            [thumbnail_limit]=/org/nemo/preferences/thumbnail-limit
        )

        m+=(
            'dconf-editor'  # 0
            'numlockx'  # 1
        )

        install_packages "${m[0]}" "${m[1]}"

        # START APPLETS STUFFS
        if [[ ! -e "${f[capslock]}" && ! -e "${f[pomodoro]}" ]]; then

            [[ ! -d "${d[13]}" || $(stat --format "%U" "${d[13]}" 2>&-) != ${USER} ]] \
                && sudo mkdir --parents "${d[13]}" \
                && sudo chown --recursive ${USER}:${USER} "${d[13]}"

            wget --quiet "${l[22]}" --output-document "${f[capslock]}"

            wget --quiet "${l[23]}" --output-document "${f[pomodoro]}"

        fi

        [[ ! -d "${d[0]}" && ! -d "${d[1]}" ]] \
            && unzip "${d[2]}"'/*.zip' -d "${d[2]}" > "${u[null]}" 2>&- \
            && sudo rm --force "${f[capslock]}" "${f[pomodoro]}" # END APPLETS

        # START NUMLOCK ALWAYS ACTIVE AT STARTUP
        [[ $(grep --files-with-matches "false" "${f[numlock]}") ]] \
            && sudo sed -i 's|false|true|g' "${f[numlock]}"  # END NUMLOCK

        [[ $(dconf read "${f[paste]}") =~ '<Ctrl><Shift>v' ]] \
            && dconf write "${f[paste]}" "'<Ctrl>v'" \
            && dconf write "${f[computer_icon]}" false \
            && dconf write "${f[home_icon]}" false \
            && dconf write "${f[automount]}" true \
            && dconf write "${f[automount_open]}" true \
            && dconf write "${f[show-hidden]}" true \
            && dconf write "${f[looking_glass]}" "['<Ctrl><Alt>l']" \
            && dconf write "${f[screensaver]}" "['<Super>l', 'XF86ScreenSaver']" \
            && dconf write "${f[default_sort_order]}" "'name'" \
            && dconf write "${f[default_sort_reverse]}" false \
            && dconf write "${f[thumbnail_limit]}" "34359738368" \
            && dconf write "${f[enabled_applets]}" "['panel1:left:0:menu@cinnamon.org:13', 'panel1:left:1:show-desktop@cinnamon.org:14', 'panel1:right:11:systray@cinnamon.org:16', 'panel1:right:12:notifications@cinnamon.org:18', 'panel1:right:13:printers@cinnamon.org:19', 'panel1:right:14:removable-drives@cinnamon.org:20', 'panel1:right:15:keyboard@cinnamon.org:21', 'panel1:right:16:network@cinnamon.org:22', 'panel1:right:17:sound@cinnamon.org:23', 'panel1:right:18:power@cinnamon.org:24', 'panel1:right:10:xapp-status@cinnamon.org:26', 'panel1:right:19:calendar@cinnamon.org:28', 'panel1:right:6:betterlock:31', 'panel1:left:2:grouped-window-list@cinnamon.org:35', 'panel1:right:1:pomodoro@gregfreeman.org:36']" \
            && dconf write "${f[gtk_theme]}" "'Mint-Y-Dark-Red'" \
            && dconf write "${f[icon_theme]}" "'Mint-Y-Red'" \
            && dconf write "${f[autostart_blacklist]}" "['gnome-settings-daemon', 'org.gnome.SettingsDaemon', 'gnome-fallback-mount-helper', 'gnome-screensaver', 'mate-screensaver', 'mate-keyring-daemon', 'indicator-session', 'gnome-initial-setup-copy-worker', 'gnome-initial-setup-first-login', 'gnome-welcome-tour', 'xscreensaver-autostart', 'nautilus-autostart', 'caja', 'xfce4-power-manager', 'mintwelcome']"

        [[ $(grep --files-with-matches "Boot Manager" "${f[grub]}") ]] \
            && sudo sed -i 's|Boot Manager|10|g' "${f[grub]}"

        echo; show "\n\t  ${c[CYAN]}WE'RE GOING TO BASH COLORFULL"

        bash_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO DEEZLOADER"
        deezloader_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO FEH"
        feh_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO GITHUB"
        github_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO CHROME"
        chrome_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO CONKY"
        conky_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO FLAMESHOT"
        flameshot_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO HEROKU"
        heroku_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO HIDE SOME DEVICES"
        hide_devices; show "\n\t  ${c[CYAN]}WE'RE GOING TO MINIDLNA"
        minidlna_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO NVIDIA"
        nvidia_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO POSTGRES"
        postgres_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO PYTHON LIBRARIES"
        py_libraries; show "\n\t  ${c[CYAN]}WE'RE GOING TO PYTHON UPGRADE"
        upgrade_py; show "\n\t  ${c[CYAN]}WE'RE GOING TO SUBLIME"
        sublime_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO UPGRADE THE SYSTEM"
        upgrade; show "\n\t  ${c[CYAN]}WE'RE GOING TO TMATE"
        tmate_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO USEFULL PACKAGES"
        usefull_pkgs; show "\n\t  ${c[CYAN]}WE'RE GOING TO WORKSPACE"
        workspace_stuffs; show "\n\t  ${c[CYAN]}WE'RE GOING TO FINISH THIS SHIT"

        echo; show "INITIALIZING CONFIGS..."; echo
        sudo tee "${u[mimeapps]}" > "${u[null]}" <<< '[Default Applications]
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

        *) echo -ne ${c[RED]}"\n   ${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}${c[WHITE]}\n\t\t  PLEASE, ONLY NUMBERS!\n"${c[END]}
        retorna_menu ;;
        # take_a_break &&

    esac
}
#======================#

#======================#
menu() {

	for (( ; ; )); do

        sleep 0.1s; show "${c[RED]}=======================================================" 1

		for linha in "${!logo[@]}"; do
            show "    ${c[RED]}${logo[${linha}]}" 1
            sleep 0.1s
        done

        sleep 0.1s; show "${c[RED]}=======================================================" 1
        sleep 0.1s; show "${c[RED]}[ 00 ] ${c[WHITE]}EXIT ${e[0]}" 1
        sleep 0.1s; show "${c[RED]}[ 01 ] ${c[WHITE]}BASH COLORFUL ${e[1]}" 1
        sleep 0.1s; show "${c[RED]}[ 02 ] ${c[WHITE]}DEEZLOADER ${e[2]}" 1
        sleep 0.1s; show "${c[RED]}[ 03 ] ${c[WHITE]}FEH ${e[3]}" 1
        sleep 0.1s; show "${c[RED]}[ 04 ] ${c[WHITE]}GIT/GITHUB ${e[4]}" 1
        sleep 0.1s; show "${c[RED]}[ 05 ] ${c[WHITE]}GOOGLE CHROME ${e[5]}" 1
        sleep 0.1s; show "${c[RED]}[ 06 ] ${c[WHITE]}CONKY ${e[6]}" 1
        sleep 0.1s; show "${c[RED]}[ 07 ] ${c[WHITE]}FLAMESHOT ${e[22]}" 1
        sleep 0.1s; show "${c[RED]}[ 08 ] ${c[WHITE]}HEROKU ${e[7]}" 1
        sleep 0.1s; show "${c[RED]}[ 09 ] ${c[WHITE]}HIDE WINDOWS DEVICES ${e[8]}" 1
        sleep 0.1s; show "${c[RED]}[ 10 ] ${c[WHITE]}MINIDLNA ${e[9]}" 1
        sleep 0.1s; show "${c[RED]}[ 11 ] ${c[WHITE]}NVIDIA DRIVER ${e[10]}" 1
        sleep 0.1s; show "${c[RED]}[ 12 ] ${c[WHITE]}POSTGRES ${e[11]}" 1
        sleep 0.1s; show "${c[RED]}[ 13 ] ${c[WHITE]}PY LIBRARIES ${e[12]}" 1
        sleep 0.1s; show "${c[RED]}[ 14 ] ${c[WHITE]}PY UPGRADE ${e[12]}" 1
        sleep 0.1s; show "${c[RED]}[ 15 ] ${c[WHITE]}SUBLIME TEXT ${e[13]}" 1
        sleep 0.1s; show "${c[RED]}[ 16 ] ${c[WHITE]}SYSTEM UPGRADE ${e[14]}" 1
        sleep 0.1s; show "${c[RED]}[ 17 ] ${c[WHITE]}TMATE ${e[15]}" 1
        sleep 0.1s; show "${c[RED]}[ 18 ] ${c[WHITE]}USEFULL PROGRAMS ${e[16]}" 1
        sleep 0.1s; show "${c[RED]}[ 19 ] ${c[WHITE]}WORKSPACE ${e[17]}" 1
        sleep 0.1s; show "${c[RED]}[ 20 ] ${c[WHITE]}ALL ${e[18]}" 1
        sleep 0.1s; show "${c[RED]}=======================================================" 1

        read -n 2 -p $'\033[1;31m[    ]\033[m\033[4D' escolha

        # O read acima é inline, então passamos uma linha vazia para não afetar
        echo

		[[ "${escolha}" =~ ^[[:alpha:]]$ ]] \
			&& echo -ne ${c[RED]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}${c[WHITE]}\n\t\tPLEASE, ONLY NUMBERS!\n\n${c[WHITE]}WANT YOU RETURN SIR?${c[END]}\n${c[WHITE]}[Y/N] R: "${c[END]} \
			&& read digitou_bobeira || invoca_funcoes "${escolha}"

			[[ "${digitou_bobeira:0:1}" == @(s|S|y|Y) ]] && retorna_menu \
            || encerra_menu && break

	done

}
#======================#

menu
