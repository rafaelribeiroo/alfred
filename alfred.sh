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
: 'colocar o background em /usr/share/backgrounds/
alterar /usr/share/gnome-background-properties/ubuntu-wallpapers.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
   <wallpaper>
    <name>Custom_Back1</name>
    <filename>/usr/share/backgrounds/WALLPAPER.jpg</filename>
    <options>zoom</options>
    <pcolor>#000000</pcolor>
    <scolor>#000000</scolor>
    <shade_type>solid</shade_type>
   </wallpaper>
</wallpapers>'
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
    [BRANCO]='\033[1;37m'  # 0 Branco
    [VERMELHO]='\033[31;1m'  # 1 Vermelho
    [VERDE]='\033[1;32m'  # 2 Verde
    [CIANO]='\033[1;36m'  # 3 Ciano
    [CINZA]='\033[1;30m'  # 4 Cinza
    [FIM]='\e[0m'  # 5 Sem mudança
    [VERMELHO-BLINK]='\033[31;1;5m'  # 6 Vermelho pisca
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

l=(
    'https://raw.github.com/ohmybash/oh-my-bash/master/tools/install.sh'  # 0
    'https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf'  # 1
    'https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf'  # 2
    'https://docs.google.com/uc?export=download&id=1tCuZpuacO8RsppBbKBMaYttmnXDArpD3'  # 3
    'https://wallpaperaccess.com/download/4k-mountain-38598'  # 4
    'https://images5.alphacoders.com/300/300707.jpg'  # 5
    'https://wallpapercave.com/wp/BXfl2ly.jpg'  # 6
    'https://api.github.com/user/keys'  # 7
    'https://cli-assets.heroku.com/install-ubuntu.sh'  # 8
    'https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer'  # 9
    'https://download.sublimetext.com/sublimehq-pub.gpg'  # 10
    'https://download.sublimetext.com/ apt/stable/'  # 11
    'https://packagecontrol.io/Package%20Control.sublime-package'  # 12
    'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'  # 13
    'https://www.postgresql.org/media/keys/ACCC4CF8.asc'  # 14
    'https://git-scm.com/'  # 15
    'https://www.python.org/doc/versions/'  # 16
    'https://pypi.org/project/pip/'  # 17
    'https://notabug.org/RemixDevs/DeezloaderRemix/wiki/Downloads'  # 18
    'https://notabug.org/RemixDevs/DeezloaderRemix'  # 19
    'https://www.nvidia.com/Download/driverResults.aspx/157462/en-us'  # 20
    'https://gist.githubusercontent.com/rafaelribeiroo/81304bc07c7316ba841eacc90caf0564/raw/fa4ee571127b99d38fa93c9f7e0e4288edffd2b0/My%2520conkyrc%2520configs'  # 21
)

declare -A f=(
    [os_release]=/etc/os-release
    [powerline_otf]=~/.fonts/PowerlineSymbols.otf
    [powerline_conf]=~/.config/fontconfig/conf.d/10-powerline-symbols.conf
    [bashrc]=~/.bashrc
    [vimrc]=~/.vimrc
    [oh_my_bash]=~/.oh-my-bash/oh-my-bash.sh
    [old_bashrc]=~/.bashrc.pre-oh-my-bash
    [user_dirs]=~/.config/user-dirs.dirs
    # https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body
    [path_deezloader]=~/$(cat "${f[user_dirs]}" | grep MUSIC | awk --field-separator=/ '{print $2}' | sed 's|"||')/$(curl --silent "${l[19]}" | grep --no-messages 64.AppImage | awk --field-separator='>' '{print $2}' | sed 's|</td||')
    [deezloader_conf]=~/.config/Deezloader\ Remix/config.json
    [jpg]=~/.config/autostart/FehBG.desktop
    [start]=/etc/lightdm/slick-greeter.conf
	[fehbg]=~/.fehbg
    [dft_bkg]=/usr/share/backgrounds/linuxmint/default_background.jpg
    [prtscr]=~/.config/autostart/Flameshot.desktop
    [gitconfig]=~/.gitconfig
    [ssh_config]=~/.ssh/config
    [public_ssh]=~/.ssh/id_rsa.pub
    [checar_sucesso]=/tmp/checar_autenticacao
    [minidlna_conf]=/etc/minidlna.conf
    [default_minidlna]=/etc/default/minidlna
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
    [chrome]=~/Downloads/google-chrome-stable_current_amd64.deb
    [capslock]=~/.local/share/cinnamon/applets/betterlock.zip
    [pomodoro]=~/.local/share/cinnamon/applets/pomodoro@gregfreeman.org.zip
    [postgres_ppa]=/etc/apt/sources.list.d/pgdg.list
    [postgres_conf]=/etc/postgresql/11/main/postgresql.conf
    [postgres_hba]=/etc/postgresql/11/main/pg_hba.conf
    [bookmarks]=~/.config/gtk-3.0/bookmarks
    [mimeapps]=~/.config/mimeapps.list
    [conkyrc]=~/.conkyrc
    [hide_rules]=/etc/udev/rules.d/99-hide-disks.rules
    [nvidia_ppa]=/etc/apt/sources.list.d/graphics-drivers-ppa-bionic.list
    [hide_driver]=/etc/modprobe.d/blacklist-nouveau.conf
    [null]=/dev/null
	[askpass]=/lib/cryptsetup/askpass
    [flameshot_config]=~/.config/Dharkael/flameshot.ini
    [grub]=/boot/grub/grub.cfg
    [apt_history]=/var/log/apt/history.log
    [paste]=/org/gnome/terminal/legacy/keybindings/paste
    [computer_icon]=/org/nemo/desktop/computer-icon-visible
    [home_icon]=/org/nemo/desktop/home-icon-visible
    [automount]=/org/cinnamon/desktop/media-handling/automount
    [automount_open]=/org/cinnamon/desktop/media-handling/automount-open
    [show-hidden]=/org/nemo/preferences/show-hidden-files
    [looking_glass]=/org/cinnamon/desktop/keybindings/looking-glass-keybinding
    [screensaver]=/org/cinnamon/desktop/keybindings/media-keys/screensaver
    [default_sort_order]=/org/nemo/preferences/default-sort-order
    [default_sort_reverse]=/org/nemo/preferences/default-sort-in-reverse-order
    [thumbnail_limit]=/org/nemo/preferences/thumbnail-limit
    [enabled_applets]=/org/cinnamon/enabled-applets
    [gtk_theme]=/org/cinnamon/desktop/interface/gtk-theme
    [icon_theme]=/org/cinnamon/desktop/interface/icon-theme
    [autostart_blacklist]=/org/cinnamon/cinnamon-session/autostart-blacklist
    [numlock]=/etc/lightdm/slick-greeter.conf
    [screenshot]=/org/cinnamon/desktop/keybindings/media-keys/screenshot
    [cmd]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/command
    [bdg]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/binding
    [name]=/org/cinnamon/desktop/keybindings/custom-keybindings/screenshot/name
    [custom]=/org/cinnamon/desktop/keybindings/custom-list
    # [blacklist]=/etc/modprobe.d/blacklist-nouveau.conf
)

d=(
    ~/.oh-my-bash  # 0
    ~/.fonts  # 1
    ~/.config/fontconfig/conf.d  # 2
    ~/.feh/ # 3
    ~/.pyenv  # 4
    ~/.pyenv/versions/$(curl -s "${l[16]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')/  # 5
    ~/.config/sublime-text-3  # 6
    /workspace  # 7
    /etc/udev/rules.d  # 8
    ~/Deezloader\ Music  # 9
    ~/.config/Deezloader\ Remix  # 10
    ~/$(cat "${f[user_dirs]}" | grep MUSIC | awk --field-separator=/ '{print $2}' | sed 's|"||')/  # 11
    ~/.config/sublime-text-3/Installed\ Packages  # 12
    ~/.cinnamon/configs/grouped-window-list@cinnamon.org  # 13
    ~/.local/share/cinnamon/applets/  # 14
    ~/.local/share/cinnamon/applets/pomodoro@gregfreeman.org  # 15
    ~/.local/share/cinnamon/applets/betterlock  # 16
    ~/$(cat "${f[user_dirs]}" | grep VIDEO | awk --field-separator=/ '{print $2}' | sed 's|"||')/  # 17
    ~/.config/Dharkael  # 18
)

m=(
    'oh-my-bash'  # 0
    'deezloader'  # 1
    'feh'  # 2
    'git'  # 3
    'heroku'  # 4
    'sublime-text'  # 5: Editor de texto
    'google-chrome'  # 6: Navegador/browser
    'conky'  # 7
    'libreoffice*'  # 8
    'workspace'  # 9: String para satisfazer função: "workspace()"
    'tmate'  # 10
    'apt-transport-https'  # 11
    'curl'  # 12: Semelhante ao WGET, porém enquanto o wget é uma ferramenta que efetua download dos arquivos de servidores, o curl deixa você trocar requisições/respostas com servidores;
    'pyenv'  # 13: Programa que permite a mudança de versão global do py
    'devices'  # 14: String para satisfazer função: "hide_devices()"
    'vim'  # 15: Editor de texto
    'jq'  # 16: Provê mais funcionalidades para tratar .json
    'git-cola'  # 17: Utilitário gráfico
    'libxss1'  # 18
    'libappindicator1'  # 19
    'libindicator7'  # 20
    'heroku-toolbelt'  # 21
	'python'  # 22
    'wget'  # 23: Utilitário indicado por prosseguir download mesmo com conexão instável ou lenta, basicamente baixa arquivos da WWW usando protocolos de HTTP/HTTPS/FTP;
    'zlib1g-dev'  # 24: Implementa o método de compressão deflate encontrado no gzip;
    'libreadline-dev'  # 25: Biblioteca de readline – provê funcionalidades extras na edição de linha de comando;
    'libsqlite3-dev'  # 26: Implementa o mecanismo de banco de dados SQL, que permite acesso ao BD sem necessidade de um processo separado de RDBMS;
    'llvm'  # 27: Otimiza tempos de compilação;
    'libncurses5-dev'  # 28: Provê uma API para o desenvolvimento de interfaces em modo texto;
    'libbz2-dev'  # 29: Descompressão de arquivos zipados com extensão bzip2;
    'libssl-dev'  # 30: Implementação do OpenSSL (lida com as comunicações SSL e TLS);
    'libffi-dev'  # 31: Contém as ferramentas necessárias para criar programas libffi;
    'dconf-editor'  # 32:
    'postgresql-11'  # 33: Núcleo do servidor de banco de dados
    'postgresql-client-11'  # 34: Bibliotecas/binários client
    'postgresql-contrib-9.6'  # 35: Módulos adicionais
    'libpq-dev'  # 36: Bibliotecas e headers para compilar programas C
    'pgadmin4'  # 37: Utilitário gráfico administrativo
    'minidlna'  # 38
    'megatools'  # 39: Utilitário para baixar arquivos do mega pelo terminal
    'usefull packages'  # 40
    'numlockx'  # 41
    'nvidia-driver'  # 42
    'nouveau-driver'  # 43
    'conky'  # 44
    'flameshot'  # 45
)

r=(
    scripts_py  # 0
    connecting_networks  # 1
    releasing_linux  # 2
    coffee_warm  # 3
    instrutions_sql  # 4
)
#======================#

#======================#
checar_distro() {

    checar_os=$(cat "${f[os_release]}" | grep "ID=" | head -1 | cut -c4-)

    if [[ "${checar_os}" != 'linuxmint' ]]; then

        escreva "\n   ${e[21]} ${c[VERMELHO]}WHY WE FALL ${name[random]}? ${e[21]}\n${c[CIANO]}SO WE CAN LEARN TO PICK OURSELVES UP \n"

        escreva "${c[VERMELHO]}YOU MUST RUN AT GOTHAM FOR A BETTER EXPERIENCE ${c[VERDE]}\n\t\t(MINT)\n"

        read -p $'\033[1;37mDID U WANNA CONTINUE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                checar_source

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                # Após a invocação de outro chamado, ele não sai completamente
                # do loop, sendo necessário a invocação e a interrupção do msm
                encerra_menu && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t${c[BRANCO]}     PLEASE, ONLY Y OR N!\n\nSR. DID U WANNA CONTINUE?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        checar_source

    fi
}
#======================#

#======================#
checar_pacote() {

	# instalado
	if dpkg-query -s "${1}" > "${f[null]}" 2>&1; then

		return 0

	else

		# não instalado, porém disponível no registro de pacote
		if apt-cache show "${1}" > "${f[null]}" 2>&1; then

			return 1

		# não instalado/disponível
		else

			return 2

		fi

	fi

}
#======================#

#======================#
checar_source() {

    [[ ${BASH_SOURCE[0]} -ef "${0}" ]] \
        && escreva "\n${c[VERMELHO-BLINK]}PLEASE, RUNS: source alfred.sh\n" 1 \
        && exit \
        || clear \
        && escreva "\n${c[VERMELHO]}===[${c[BRANCO]} STARTING ${c[VERMELHO]}]===\n" \
        && clear; menu

}
#======================#

#======================#
checar_ssh() {

    # Gera chaves pública totalmente silenciosas. Se já existir, ignora
    [[ ! -e "${f[public_ssh]}" ]] && yes "" | ssh-keygen -N "" >&- 2>&-

}
#======================#

#======================#
encerra_menu() {

    escreva "\n${c[VERMELHO]}   FOR YOUR OWN SAKE,\n${c[CIANO]}THERE IS NO TURNING BACK...\n"

    [[ ${BASH_SOURCE[0]} -ef "${0}" ]] && exit || return 0

}
#======================#

#======================#
escreva() {

    echo -e ${c[BRANCO]}"${1}"${c[FIM]}

    # Se passar 1, não "dorme"
    [[ "${2}" -eq 1 ]] || take_a_break

}
#======================#

#======================#
install_packages() {

    # $@: Truque para "desempacotar" todos os valores recebidos, tipo PY
    for package in "$@"; do

    	if checar_pacote "${package}"; then

            # Por que não colocar as inúmeras validações se o pacote já existe
            # e se o usuário deseja desinstalar aqui pra economizar linha?
            # Porque se for várias dependências, ele vai perguntar uma a uma
            # ao invés de desinstalar o conjunto como um todo.
            [[ "${#}" -eq 1 ]] \
                && escreva "\n${c[VERDE]}${package^^} ${c[BRANCO]}${linei:${#package}} [INSTALLED]\n" \
                || escreva "\n${c[VERDE]}${package^^} ${c[BRANCO]}${linei:${#package}} [INSTALLED]"

        else

            if test "${?}" -eq 1; then

                [[ "${#}" -eq 1 ]] \
                    && escreva "\n${c[VERDE]}I${c[BRANCO]}NSTALLING ${c[VERDE]}${package^^}${c[BRANCO]}!\n" \
                    || escreva "\n${c[VERDE]}I${c[BRANCO]}NSTALLING ${c[VERDE]}${package^^}${c[BRANCO]}!"

                sudo apt install -y "${package}" > "${f[null]}" 2>&-

            fi

        fi

    done

}
#======================#

#======================#
remocao_inuteis() {

    sudo apt autoremove -y > "${f[null]}" 2>&-

    sudo apt autoclean > "${f[null]}"

}
#======================#

#======================#
retorna_menu() {

    escreva "${c[VERMELHO]}\n\tWHAT IS THE POINT OF ALL THOSE PUSHUPS?\n ${c[CIANO]}\t  IF YOU CAN'T EVEN LIFT A BLOODY LOG"

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

    # > Redireciona para lugar nenhum e o 2>&- tranca a saída de erro (stdout)
    sudo apt update > "${f[null]}" 2>&-

}
#======================#

#======================#
bash_stuffs() {  # Okzão

    if [[ -d "${d[0]}" ]]; then

        escreva "\n${c[VERDE]}${m[0]^^} ${c[BRANCO]}${linei:${#m[0]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[0]^^}${c[BRANCO]}!\n"

                # --force: ignore nonexistent files, never prompt
                sudo rm --recursive --force "${d[0]}"

                sudo rm --force "${f[bashrc]}"

                [[ -e "${f[old_bashrc]}" ]] && sudo mv "${f[old_bashrc]}" "${f[bashrc]}"

                sudo rm --force "${f[powerline_otf]}"

                sudo rm --force "${f[powerline_conf]}"

                source "${f[bashrc]}"

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\tI${c[BRANCO]}NSTALLING ${c[VERDE]}${m[0]^^}${c[BRANCO]} AND ${c[VERDE]}DEPENDENCIES${c[BRANCO]}!" 1

        install_packages "${m[3]}" "${m[12]}"

        escreva "${c[VERDE]}\nI${c[BRANCO]}NSTALLING ${c[VERDE]}${m[0]^^}${c[BRANCO]}!\n"

        # 174: Primeira ocorrência do /dev/null vai ocultar o progresso de download do script, a segunda oculta os "echos" do script
        0> "${f[null]}" bash -c "$(curl --fail --silent --location ${l[0]})" &> "${f[null]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    if [[ ! -e "${f[powerline_otf]}" ]]; then

        # Os diretórios ocultos são pertencentes ao root, se manter esse proprietário, o bash não "consegue" ler os arquivos
        # https://www.gnu.org/software/coreutils/manual/html_node/stat-invocation.html
        # 2>&- para ocultar msg de erro: "nao foi possivel obter estado de ..."
        [[ ! -d "${d[1]}" || $(stat --format "%U" "${d[1]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[1]}" \
            && sudo chown --recursive ${USER}:${USER} "${d[1]}" # Tranca saída de erro

        # Opções CURL: L segue até o link final (github redireciona); s de silêncio
        # o de output, para escrever o retorno no arquivo.
        # > Redireciona a saída padrão para um "nullable"
        curl --location --silent --output "${f[powerline_otf]}" --create-dirs "${l[1]}"

        # Atualiza cache de fontes
        sudo fc-cache -vf "${d[1]}" > "${f[null]}"

    fi

    if [[ ! -e "${f[powerline_conf]}" ]]; then

        [[ ! -d "${d[2]}" || $(stat --format "%U" "${d[2]}" 2>&-) != ${USER} ]] \
            && sudo mkdir --parents "${d[2]}" \
            && sudo chown --recursive ${USER}:${USER} "${d[2]}"

        curl --location --silent --output "${f[powerline_conf]}" --create-dirs "${l[2]}"

    fi

    # Se der algum erro de incompatibilidade depois da instalação, executar:
    # [[ $(grep --files-with-matches "check_for_upgrade.sh" "${f[oh_my_bash]}") ]] \
    #     && sudo sed -zi 's|if \[ "$DISABLE_AUTO_UPDATE" != "true" \]; then\n  env OSH=$OSH DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT bash -f $OSH/tools/check_for_upgrade.sh\nfi||g' "${f[oh_my_bash]}"

    # Oculta nome de usuário e permite sobreescrita de quaisquer arquivos
    [[ $(grep --files-without-match "DEFAULT_USER" "${f[bashrc]}") ]] \
        && sudo tee -a "${f[bashrc]}" > "${f[null]}" <<< "DEFAULT_USER=${USER}
set +o noclobber" # tee is an "sudo echo" that works, -a to append (>>)

    # Instala plugins
    [[ $(grep --files-without-match "agnoster" "${f[bashrc]}") && $(grep --files-without-match "plugins=(git" "${f[bashrc]}") ]] \
        && sudo sed -i 's|OSH_THEME="font"|OSH_THEME="agnoster"|g' "${f[bashrc]}" \
        && sudo sed -zi 's|plugins=(\n  git\n  bashmarks\n)|plugins=(git django python pyenv pip virtualenv)|g' "${f[bashrc]}"

    source "${f[bashrc]}"

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
deezloader_stuffs() {  # Okzão

    link_latest=$(curl --location --silent "${l[18]}" | grep -6 "Linux x64" | tail -1 | awk --field-separator='"' '{print $2}' | sed 's|%..|!|g')

    if [[ -e "${f[path_deezloader]}" || -d "${d[10]}" ]]; then

        escreva "\n${c[VERDE]}${m[1]^^} ${c[BRANCO]}${linei:${#m[1]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "${c[VERMELHO]}\nU${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[1]^^}${c[BRANCO]}!\n"

                sudo rm --force "${f[path_deezloader]}"

                sudo rm --recursive --force "${d[9]}"

                sudo rm --recursive --force "${d[10]}"

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\tI${c[BRANCO]}NSTALLING ${c[VERDE]}${m[1]^^}${c[BRANCO]} AND ${c[VERDE]}DEPENDENCIES${c[BRANCO]}!" 1

        install_packages "${m[39]}"

        megadl --no-progress "${link_latest}" --path "${d[11]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    # Checa permissão. Se não for executável, torna-o
    [[ $(stat --format "%a" "${f[path_deezloader]}" 2>&-) -ne 755 ]] \
        && sudo chmod +x "${f[path_deezloader]}"

    local_deezloader=$(stat --format "%n" "${d[11]}"Deez* | awk --field-separator=_ '{print $3}' | sed 's|-x86||' 2>&-)

    latest_deezloader=$(curl --silent "${l[18]}" | grep -1 "markdown" | tail -1 | awk '{print $3}' | sed 's|</h2>||')

    ( $(dpkg --compare-versions "${local_deezloader}" lt "${latest_deezloader}") ) \
        && sudo rm --force "${f[path_deezloader]}" \
        && megadl --no-progress "${link_latest}" --path "${d[11]}"

    if [[ $(grep --files-without-match "${d[11]#~/}" "${f[deezloader_conf]}") ]]; then

        cd "${d[11]}" > "${f[null]}"

        ( nohup ./"${f[path_deezloader]#${d[11]}}" & ) > "${f[null]}" 2>&1

        read -p $'\033[1;37m\nHAVE YOU LOGON? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                if [[ ! -e "${f[deezloader_conf]}" ]]; then

                    echo -ne ${c[BRANCO]}"\nNO, YOU DON'T\n[Y/N] R: "${c[FIM]}

                    read option

                else

                    kill -9 $(ps -aux | grep "/tmp/.mount_Deez" | grep "Sl" | head -1 | awk '{print $2}')

                    sudo sed -i "s|Deezloader Music/|${d[11]#~/}|g" "${f[deezloader_conf]}"

                    ( nohup ./"${f[path_deezloader]#${d[11]}}" & ) > "${f[null]}" 2>&1

                    cd - > "${f[null]}"

                    break

                fi

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo -ne ${c[BRANCO]}"\nTHEN DO IT! I'LL WAIT...\n[Y/N] R: "${c[FIM]}

                read option

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. DO U HAVE COMPLETE LOGIN?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    fi

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
feh_stuffs() {  # Okzão

    if [[ $(dpkg -l | awk "/${m[2]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[2]^^} ${c[BRANCO]}${linei:${#m[2]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[2]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[2]}" > "${f[null]}" 2>&-

                sudo rm --force "${f[jpg]}" "${f[fehbg]}"

                sudo rm --recursive --force "${d[3]}"

                [[ $(grep --files-without-match "default" "${f[start]}") ]] \
                    && sudo tee -a "${f[start]}" > "${f[null]}" <<< "background=${f[dft_bkg]}"

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\t   I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[2]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

        install_packages "${m[2]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    [[ ! -d "${d[3]}" || $(stat --format "%U" "${d[3]}" 2>&-) != ${USER} ]] \
        && mkdir --parents "${d[3]}" \
        && sudo chown --recursive ${USER}:${USER} "${d[3]}"

    # Usamos o --word-regexp para não casar até com disconnected
    if [[ $(xrandr --query | grep --word-regexp "connected" | wc -l) -eq 1 ]]; then

        curl --silent --output "${d[3]}c.jpg" --create-dirs "${l[4]}"

        feh --bg-scale "${d[3]}c.jpg"

    elif [[ $(xrandr --query | grep --word-regexp "connected" | wc -l) -eq 2 ]] ; then

        curl --silent --output "${d[3]}l.jpg" --create-dirs "${l[5]}"

        curl --silent --output "${d[3]}r.jpg" --create-dirs "${l[6]}"

        feh --bg-scale "${d[3]}l.jpg" "${d[3]}r.jpg"

    fi

    [[ ! -e "${f[jpg]}" || $(grep --files-without-match "Feh" "${f[jpg]}") ]] \
        && sudo tee -a "${f[jpg]}" > "${f[null]}" <<< "[Desktop Entry]
Name=Feh
Type=Application
Exec=/home/${USER}/.fehbg
X-GNOME-Autostart-enabled=true
NoDisplay=false
Hidden=false
Name[pt_BR]=FehBG Wallpapers
Comment[pt_BR]=Wallpaper único para cada monitor
X-GNOME-Autostart-Delay=5" # here string: evitando o uso desnecessario de echo

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
github_stuffs() {  # Okzão

    if [[ $(dpkg -l | awk "/${m[3]}/ {print }" | wc -l) -ge 1 && $(dpkg -l | awk "/${m[17]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[3]^^} ${c[BRANCO]}${linei:${#m[3]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[3]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[3]}" > "${f[null]}" 2>&-

                sudo rm --force "${f[gitconfig]}"

                ( $(dpkg --compare-versions "${local_git}" eq "${latest_git}") ) \
                    && sudo add-apt-repository --remove -y ppa:git-core/ppa > /dev/null 2>&1

                sudo sed -zi 's|Host github.com\nHostname ssh.github.com\nPort 443||g' "${f[ssh_config]}"  # TESTAR

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\t    I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[3]^^}${c[BRANCO]} AND ${c[VERDE]}DEPENDENCIES${c[BRANCO]}!" 1

        install_packages "${m[3]}" "${m[15]}" "${m[17]}"; echo

    fi

    escreva "INITIALIZING CONFIGS..." 1

    # -l to check if file does not contain a string
    # Any changes pushed to GitHub, BitBucket, GitLab or another Git host
    # server in a later lesson will include this information.
    # from: https://swcarpentry.github.io/git-novice/02-setup/
    [[ ! -e "${f[gitconfig]}" || $(grep --files-without-match "@" "${f[gitconfig]}") ]] \
        && read -p $'\033[1;37m\nENTER YOUR EMAIL, '"${name[random]}"$': \033[m' email \
        && read -p $'\033[1;37mNAME '"${e[20]}"$': \033[m' nome \
        && git config --global user.email "${email}" \
        && git config --global user.name "${nome}" \
        && git config --global core.editor "vim" \
        && git config --global core.autocrlf input

    [[ $(dconf read /org/cinnamon/desktop/interface/gtk-theme) =~ .*Dark.* ]] \
        && git config --global cola.icontheme dark

    local_git=$(git --version | awk '{print $3}')

    latest_git=$(curl --silent "${l[15]}" | grep -1 '<span class="version">' | tail -1 | awk '{print $1}')

    ( $(dpkg --compare-versions "${local_git}" lt "${latest_git}") ) \
        && sudo add-apt-repository -y ppa:git-core/ppa > "${f[null]}" 2>&1 \
        && update \
        && sudo apt install -y "${m[3]}" > "${f[null]}" 2>&-

    # Criação/ignora chave pública
    checar_ssh

    [[ ! -e "${f[ssh_config]}" || $(grep --files-without-match "github.com" "${f[ssh_config]}") ]] \
        && sudo tee -a "${f[ssh_config]}" > "${f[null]}" <<< 'Host github.com
    Hostname ssh.github.com
    Port 443'

    # GITHUB STUFF
    for (( ; ; )); do

        read -p $'\033[1;37m\nENTER YOUR USERNAME FROM GITHUB: \033[m' usuario

        senha=$("${f[askpass]}" $'\033[1;37mPASSWORD:\033[m')

        # Ver se dá pra fazer com awk '{print $2}'
        # Opções curl: s de silent, i de informações a mais, u de usuário
        checar_integridade=$(curl --silent --include --user "${usuario}":"${senha}" "${l[7]}" | grep "Status" | awk '{print $2}')

        # Poupamos a condição abaixo, já que as mensagens de sucesso é 200 até 226
        # [[ "${checar_integridade}" -eq 401 || "${checar_integridade}" -eq 403 ]]
        [[ "${checar_integridade}" -gt 400 ]] \
            && escreva "\n\t\t${c[BRANCO]}TRY HARDER ${c[VERMELHO]}${name[random]}${c[BRANCO]}!!!" 1 \
            || break

    done

    # Se não existir nenhuma chave no github
    if [[ -z $(curl --silent --user "${usuario}":"${senha}" "${l[7]}") ]]; then

        curl --silent --include --user "${usuario}":"${senha}" --data '{"title": "Enviado do meu iPhone","key": "'"$(cat "${f[public_ssh]}")"'"}' "${l[7]}" > "${f[null]}"

        echo

    else

        install_packages "${m[16]}"

        [[ \
            $(cat "${f[public_ssh]}" | awk '{print $2}') != \
            $(curl --silent --user "${usuario}":"${senha}" "${l[7]}" | jq ".[] | .key" | sed 's/.$//' | awk '{print $2}') \
        ]] \
            && escreva "THERE'S AN INCONSISTENCY IN YOUR LOCAL/REMOTE KEYS. FIXING!" \
            && curl --user "${usuario}":"${senha}" --request DELETE "${l[7]}"/"$(curl --silent --user ${usuario}:${senha} ${l[7]} | jq '.[] | .id')" \
            && curl --silent --include --user "${usuario}":"${senha}" --data '{"title": "Enviado do meu iPhone","key": "'"$(cat "${f[public_ssh]}")"'"}' "${l[7]}" > "${f[null]}" \
            && echo

    fi

    [[ ! -e "${f[checar_sucesso]}" ]] \
        && ssh -T git@github.com 2> "${f[checar_sucesso]}"

    [[ $(cat "${f[checar_sucesso]}" | grep "successfully" | wc -l) -eq 0 ]] \
        && ssh -T -o StrictHostKeyChecking=no git@github.com > "${f[null]}" 2>&-

    escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
chrome_stuffs() {  # Okzão

	if [[ $(dpkg -l | awk "/${m[6]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[6]^^} ${c[BRANCO]}${linei:${#m[6]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[6]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[6]}" "${m[18]}" "${m[19]}" "${m[20]}" > "${f[null]}" 2>&-

                sudo sed -zi 's|text/html=google-chrome.desktop\nx-scheme-handler/http=google-chrome.desktop\nx-scheme-handler/https=google-chrome.desktop\nx-scheme-handler/about=google-chrome.desktop\nx-scheme-handler/unknown=google-chrome.desktop\nx-scheme-handler/mailto=google-chrome.desktop||g' "${f[mimeapps]}"

                sudo sed -i '\|"google-chrome.desktop",|d' "${d[13]}"/*.json

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n      I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[6]^^}${c[BRANCO]} AND ${c[VERDE]}DEPENDENCIES${c[BRANCO]}!" 1

        # Dependências
        install_packages "${m[18]}" "${m[19]}" "${m[20]}"

        escreva "\n${c[VERDE]}I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[6]^^}${c[BRANCO]}!"

        [[ ! -e "${f[chrome]}" ]] \
            && curl --location --silent --output "${f[chrome]}" --create-dirs "${l[13]}"

        sudo dpkg -i "${f[chrome]}" &> "${f[null]}"

        sudo rm --force "${f[chrome]}" && echo

    fi

    escreva "INITIALIZING CONFIGS..."

    [[ ! -e "${f[mimeapps]}" || $(grep --files-without-match "google-chrome" "${f[mimeapps]}") ]] \
        && sudo tee "${f[mimeapps]}" > "${f[null]}" <<< '[Default Applications]
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

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
conky_stuffs() {

    if [[ $(dpkg -l | awk "/${m[44]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[44]^^} ${c[BRANCO]}${linei:${#m[44]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[44]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[44]}" > "${f[null]}" 2>&-

                sudo rm --force "${f[conkyrc]}"

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\t  I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[44]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

        install_packages "${m[44]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    [[ ! -e "${f[conkyrc]}" ]] \
        && curl --silent --output "${f[conkyrc]}" --create-dirs "${l[21]}"

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
flameshot_stuffs() {

    if [[ $(dpkg -l | awk "/${m[45]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[45]^^} ${c[BRANCO]}${linei:${#m[45]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[45]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[45]}" > "${f[null]}" 2>&-

                sudo rm --force --recursive "${d[18]}"

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\tI${c[BRANCO]}NSTALLING ${c[VERDE]}${m[45]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

        install_packages "${m[45]}" "${m[32]}" && echo

    fi

    escreva "INITIALIZING CONFIGS..."

    dconf write "${f[screenshot]}" "[]"

    dconf write "${f[cmd]}" "'flameshot gui --path /home/${USER}/$(cat "${f[user_dirs]}" | grep PICTURES | awk --field-separator=/ '{print $2}' | sed 's|"||')'"

    dconf write "${f[bdg]}" "['Print']"

    dconf write "${f[name]}" "'Flameshot'"

    dconf write "${f[custom]}" "['screenshot']"

    sudo sed -i 's|@Variant(\\0\\0\\0\\x7f\\0\\0\\0\\vQList<int>\\0\\0\\0\\0\\x13\\0\\0\\0\\0\\0\\0\\0\\x1\\0\\0\\0\\x2\\0\\0\\0\\x3\\0\\0\\0\\x4\\0\\0\\0\\x5\\0\\0\\0\\x6\\0\\0\\0\\x12\\0\\0\\0\\xf\\0\\0\\0\\a\\0\\0\\0\\b\\0\\0\\0\\t\\0\\0\\0\\x10\\0\\0\\0\\n\\0\\0\\0\\v\\0\\0\\0\\f\\0\\0\\0\\r\\0\\0\\0\\xe\\0\\0\\0\\x11)||g' "${f[flameshot_config]}"

    [[ ! -e "${f[prtscr]}" || $(grep --files-without-match "flameshot" "${f[prtscr]}") ]] \
        && sudo tee "${f[prtscr]}" > "${f[null]}" <<< '[Desktop Entry]
Name=flameshot
Icon=flameshot
Exec=flameshot
Terminal=false
Type=Application
X-GNOME-Autostart-enabled=true'

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
heroku_stuffs() {

    if [[ $(dpkg -l | awk "/${m[4]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[4]^^} ${c[BRANCO]}${linei:${#m[4]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "${c[VERMELHO]}\nU${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[4]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[4]}" > "${f[null]}" 2>&-

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\t  I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[4]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

        escreva "\n${c[VERDE]}I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[4]^^}${c[BRANCO]}!\n"

        bash -c "$(curl --silent ${l[8]})" &> "${f[null]}"

    fi

    escreva "INITIALIZING CONFIGS..." 1

	echo; read -p $'\033[1;37mWANT YOU AUTHENTICATE '"${name[random]}"$'? \n[Y/N] R: \033[m' option

	for (( ; ; )); do

		if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

    		echo && heroku login -i

            echo && break

		elif [[ "${option:0:1}" = @(n|N) ]] ; then

            echo && break

	    else

            echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. WANT YOU AUTHENTICATE?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

            read option

    	fi

    done

    escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
hide_devices() {  # Okzão

    checar_dispositivos=$(sudo fdisk --list | grep --extended-regexp "Microsoft dados básico|Microsoft basic data" | awk '{print $1}')

    if [[ -z "${checar_dispositivos}" ]]; then

        [[ "${1}" -eq 1 ]] \
            && escreva "\n  THERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!" \
            || escreva "\nTHERE'S NO WINDOWS DEVICES FOR YOUR GREATHER GOOD!"

        retorna_menu

    else

        if [[ -e "${f[hide_rules]}" || $(grep --no-messages --files-with-matches "ID_FS_UUID" "${f[hide_rules]}") ]]; then

            escreva "\n${c[VERDE]}${m[14]^^} ${c[BRANCO]}${lineh:${#m[14]}} [HIDED]\n"

            read -p $'\033[1;37mSIR, SHOULD I SHOW THEM? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    escreva "\n${c[VERMELHO]}S${c[BRANCO]}HOWING ${c[VERMELHO]}${m[14]^^}${c[BRANCO]}!\n"

                    sudo rm --force "${f[hide_rules]}"

                    escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    retorna_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    echo && break

                else

                    echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I SHOW THEM AGAIN?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                    read option

                fi

            done

        else

            [[ "${1}" -eq 1 ]] \
                && escreva "${c[VERDE]}\n\t\t     H${c[BRANCO]}IDING ${c[VERMELHO]}$((${#checar_dispositivos[@]} + 1))${c[BRANCO]} ${c[VERDE]}${m[14]^^}${c[BRANCO]}!" \
                || escreva "${c[VERDE]}\nH${c[BRANCO]}IDING ${c[VERMELHO]}$((${#checar_dispositivos[@]} + 1))${c[BRANCO]} ${c[VERDE]}${m[14]^^}${c[BRANCO]}!"

            for device in "${checar_dispositivos}"; do

                devices+=(${device})

            done

            [[ ! -d "${d[8]}" || $(stat --format "%U" "${d[8]}" 2>&-) != ${USER} ]] \
                && mkdir --parents "${d[8]}" \
                && sudo chown --recursive ${USER}:${USER} "${d[8]}"

            # Na quantidade de itens em uma lista ele começa do 1
            for (( iterador=0; iterador<${#devices[@]}; iterador++ )); do

                tee -a "${f[hide_rules]}" > "${f[null]}" <<< 'ENV{ID_FS_UUID}=="'"$(blkid -s UUID -o value ${devices[${iterador}]})"'",ENV{UDISKS_IGNORE}="1"'

            done

            echo

        fi

    fi

    escreva "INITIALIZING CONFIGS..."

    sudo udevadm control --reload-rules && sudo udevadm trigger

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
minidlna_stuffs() {

    if [[ $(dpkg -l | awk "/${m[38]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[38]^^} ${c[BRANCO]}${linei:${#m[38]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "${c[VERMELHO]}\nU${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[38]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[38]}" > "${f[null]}" 2>&-

                sudo rm --force "${f[minidlna_conf]}"

                sudo rm --force "${f[default_minidlna]}"

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\tI${c[BRANCO]}NSTALLING ${c[VERDE]}${m[38]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

        install_packages "${m[38]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    if [[ $(grep --files-without-match "Mídias" "${f[minidlna_conf]}") ]]; then

        # automatic discover new files
        sudo sed -i "s|#inotify=yes|inotify=yes|g" "${f[minidlna_conf]}"

        # server_name
        sudo sed -i "s|#friendly_name=|friendly_name=Mídias|g" "${f[minidlna_conf]}"

        # location database
        sudo sed -i "s|#db_dir=/var/cache/minidlna|db_dir=...|g" "${f[minidlna_conf]}"

        # location logs
        sudo sed -i "s|#log_dir=/var/log|log_dir=...|g" "${f[minidlna_conf]}"

        # user to access this database
        sudo sed -i "s|#user=minidlna|user=root|g" "${f[minidlna_conf]}"

        sudo sed -zi "s|/var/lib/minidlna|V,${d[17]}|5" "${f[minidlna_conf]}"

        sudo sed -i 's|#USER="minidlna"|USER="root"|g' "${f[default_minidlna]}"

    fi

	echo; read -p $'\033[1;37mSHOULD I RESTART THE SERVICE SIR? \n[Y/N] R: \033[m' option

	for (( ; ; )); do

		if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

            [[ $(systemctl is-active "${m[38]}".service) = 'active' ]] \
                && sudo service minidlna restart \
                && sudo service minidlna force-reload \
                || sudo service minidlna start

            echo && break

		elif [[ "${option:0:1}" = @(n|N) ]] ; then

            echo && break

	    else

            echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

            read option

    	fi

    done

    escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
nvidia_stuffs() {

    # https://4fasters.com.br/2018/04/26/benchmark-nvidia-driver-do-fabricante-vs-driver-open-source-no-linux/
    # -class: Exibe apenas informações do display
    checar_existencia_nvidia=$(sudo lshw -class display | grep --extended-regexp "fabricante|vendor" | awk '{print $2}')

    if [[ "${checar_existencia_nvidia}" != "NVIDIA" ]]; then

        [[ "${1}" -eq 1 ]] \
            && escreva "\n\tTHERE'S NO NVIDIA CARD IN YOUR MACHINE!" \
            || escreva "\nTHERE'S NO NVIDIA CARD IN YOUR MACHINE!"

        retorna_menu

    else

        # Identifica qual o driver está sendo utilizado no momento.
        # nouveau: o padrão/nvidia_drm: terceiros.
        checar_driver=$(lsmod | grep drm_kms_helper | head -1 | awk '{print $4}')

        if [[ "${checar_driver%%_drm}" = "nvidia" ]]; then

            escreva "\n${c[VERDE]}${m[42]^^} ${c[BRANCO]}${linei:${#m[42]}} [INSTALLED]\n"

            read -p $'\033[1;37mSIR, SHOULD I RESTORE NOUVEAU DRIVER? \n[Y/N] R: \033[m' option

            for (( ; ; )); do

                if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                    escreva "\n${c[VERMELHO]}R${c[BRANCO]}ESTORING ${c[VERMELHO]}${m[43]^^}${c[BRANCO]}!\n"



                    escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                    retorna_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    echo && break

                else

                    echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTORE DEFAULT DRIVER?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                    read option

                fi

            done

        else

            [[ "${1}" -eq 1 ]] \
                && escreva "${c[VERDE]}\n      I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[42]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

            latest_nvidia=$(curl --silent "${l[20]}" | grep -1 '"tdVersion"' | tail -1 | awk --field-separator=. '{print $1}' | awk '{$1=$1};1')

            [[ ! $(apt search nvidia-driver-"${latest_nvidia}") ]] \
                && sudo add-apt-repository -y ppa:graphics-drivers/ppa > "${f[null]}" 2>&1 \
                && update

            install_packages "${m[42]}-${latest_nvidia}"

        fi

    fi

    escreva "INITIALIZING CONFIGS..."

    local_nvidia=$(apt version "${m[42]}-*")

    latest_nvidia=$(curl --silent "${l[20]}" | grep -1 '"tdVersion"' | tail -1 | awk --field-separator=. '{print $1}' | awk '{$1=$1};1')

    if ( $(dpkg --compare-versions "${local_nvidia}" lt "${latest_nvidia}") ); then

        [[ ! -e "${nvidia_ppa}" ]] \
            && sudo add-apt-repository -y ppa:graphics-drivers/ppa > "${f[null]}" 2>&1 \
            && update \
            && sudo apt install -y "${m[42]}" > "${f[null]}" 2>&-

    fi

    if [[ ! -e "${f[hide_driver]}" || $(grep --files-without-match "nouveau" "${f[hide_driver]}") ]]; then

        sudo tee "${f[hide_driver]}" > "${f[null]}" <<< 'blacklist nouveau
blacklist lbm-nouveau
alias nouveau off
alias lbm-nouveau off'

        echo; sudo update-initramfs -u; echo

        read -p $'\033[1;37mREBOOT IS REQUIRED. SHOULD I REBOOT NOW SIR? \n[Y/N] R: \033[m' option

    	for (( ; ; )); do

    		if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                reboot

    		elif [[ "${option:0:1}" = @(n|N) ]] ; then

                break

    	    else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESTART?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

        	fi

        done

    fi

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
postgres_stuffs() {

    if [[ $(dpkg -l | awk "/${m[33]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[33]^^} ${c[BRANCO]}${linei:${#m[33]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "${c[VERMELHO]}\nU${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[33]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[33]}" "${m[34]}" "${m[35]}" "${m[36]}" "${m[37]}" > "${f[null]}" 2>&-



                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n       I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[33]^^}${c[BRANCO]} AND ${c[VERDE]}DEPENDENCIES${c[BRANCO]}!" 1

        [[ ! $(sudo apt-key list 2> "${f[null]}" | grep "PostgreSQL") ]] \
            && sudo wget --quiet --output-document - "${l[14]}" | sudo apt-key add - > "${f[null]}"

        # Apontando o host do postgres no sources.list
    	[[ ! -e "${f[postgres_ppa]}" || $(grep --files-without-match "bionic-pgdg" "${f[postgres_ppa]}") ]] \
    		&& sudo tee "${f[postgres_ppa]}" > "${f[null]}" <<< 'deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main' \
            && update

        install_packages "${m[33]}" "${m[34]}" "${m[35]}" "${m[36]}" "${m[37]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    sudo sed -i "s|#listen_addresses|listen_addresses|g" "${f[postgres_conf]}"

    if [[ $(grep --files-without-match "local   all             postgres                                md5" "${f[postgres_hba]}") ]]; then

        # Antes de alterar a criptografia do postgres, devemos criar uma senha
        senha=$("${f[askpass]}" $'\033[1;37mPASSWORD OF USER POSTGRES \033[31;1m(root)\033[1;37m:\033[m')

        sudo --username postgres psql --command "ALTER USER postgres WITH ENCRYPTED PASSWORD '${senha}'"

        sudo sed -i "s|local   all             postgres                                peer|local   all             postgres                                md5|g" "${f[postgres_hba]}"

    fi

    # Usuário: Acesso ao console
    read -p $'\033[1;37m\nDO U WANT A USER TO ACCESS THE CONSOLE, '"${name[random]}"$'?\n[Y/N] R: \033[m' option

    for (( ; ; )); do

        if [[ ${option:0:1} = @(s|S|y|Y) ]] ; then

            read -p $'\033[1;37m\nENTER THE USER: \033[m' user

            [[ $(psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='${user}'") -eq 1 ]] \
                && escreva "USER ${c[VERMELHO]}${user^^}${c[BRANCO]} ALREADY EXISTS. BREAKING." \
                && break

            senha=$("${f[askpass]}" $'\033[1;37m\nPASSWORD OF USER '"${user^^}"$':\033[m')

            sudo --username postgres psql --command "CREATE USER ${user} WITH ENCRYPTED PASSWORD '${senha}'"

            sudo --username postgres psql --command "ALTER ROLE ${user} SET client_encoding TO 'utf8'"

            sudo --username postgres psql --command "ALTER ROLE ${user} SET default_transaction_isolation TO 'read committed'"

            sudo --username postgres psql --command "ALTER ROLE ${user} SET timezone TO 'America/Sao_Paulo'"

            break

        elif [[ ${option:0:1} = @(N|n) ]] ; then

            break

        else

            echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I CREATE A USER?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

            read resposta

        fi

    done

	# Verifica status do postgres
    [[ $(systemctl is-active postgresql.service) = 'active' ]] \
        && sudo service postgresql restart \
        || sudo service postgresql start

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
py_libraries() {

	install_packages python-pip python-dev build-essential
	# python-pip: gerenciador de pacotes
	# build-essential: inclui make, automake, fakerrot etc
	# python-dev: bibliotecas de compilação (caso algum pacote precise).

    latest_pip=$(curl --silent "${l[17]}" | grep -1 '<h1 class="package-header__name">' | tail -1 | awk '{print $2}')
    pip install -U pip

}
#======================#

#======================#
upgrade_py() {  # OKzão

    local_python=$(apt version "${m[22]}")

    latest_python=$(curl --silent "${l[16]}" | grep --no-messages external | head -2 | tail -1 | awk --field-separator=/ '{print $5}')

    if ( $(dpkg --compare-versions "${local_python}" eq "${latest_python}") ); then

        escreva "\n${c[VERDE]}${m[22]^^} ${c[BRANCO]}${lineu:${#m[22]}} [UPGRADED]\n"

        read -p $'\033[1;37mSIR, SHOULD I DOWNGRADE VERSION? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}R${c[BRANCO]}ESETING ${c[VERMELHO]}${m[22]^^}${c[BRANCO]}!\n"

                pyenv global system

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

                elif [[ "${option:0:1}" = @(N|n) ]] ; then

                    echo && break

                else

                    echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I RESET?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                    read option

                fi

            done

        else

            [[ "${1}" -eq 1 ]] \
                && escreva "${c[VERDE]}\n\t   I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[13]^^}${c[BRANCO]} AND ${c[VERDE]}DEPENDENCIES${c[BRANCO]}!" 1

            # Dependências
            install_packages "${m[12]}" "${m[22]}" "${m[23]}" "${m[24]}" "${m[25]}" "${m[26]}" "${m[27]}" "${m[28]}" "${m[29]}" "${m[30]}" "${m[31]}"

            [[ ! -d "${d[4]}" ]] \
                && escreva "${c[VERDE]}\nI${c[BRANCO]}NSTALLING ${c[VERDE]}${m[13]^^}${c[BRANCO]}!" \
                && bash -c "$(curl --location --silent ${l[9]})" &> "${f[null]}"

            echo

        fi

        escreva "INITIALIZING CONFIGS..."

        [[ $(grep --files-without-match "pyenv init" "${f[bashrc]}") ]] \
            && sudo tee -a "${f[bashrc]}" > "${f[null]}" <<< 'export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init -)"' \
            && source "${f[bashrc]}"

        # pyenv versions
        # pyenv install --list
        [[ ! -d "${d[5]}" ]] && pyenv install "${latest_python}" &> "${f[null]}"

        pyenv global "${latest_python}"

        echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
sublime_stuffs() {

	if [[ $(dpkg -l | awk "/${m[5]}/" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[5]^^} ${c[BRANCO]}${linei:${#m[5]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[5]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[5]}" > "${f[null]}" 2>&-

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n       I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[5]^^}${c[BRANCO]} AND ${c[VERDE]}DEPENDENCIES${c[BRANCO]}!" 1

		# Verifica certificado de segurança (apt-key list)
		[[ ! $(sudo apt-key list 2> "${f[null]}" | grep "Sublime") ]] \
            && sudo wget --quiet --output-document - "${l[10]}" | sudo apt-key add - > "${f[null]}"

        # Dependências
        install_packages "${m[11]}"

        [[ ! -e "${f[subl_ppa]}" || $(grep --files-without-match "sublimetext" "${f[subl_ppa]}") ]] \
            && sudo tee "${f[subl_ppa]}" > "${f[null]}" <<< "deb ${l[11]}" \
            && update

        install_packages "${m[5]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    # Não sai do loop enquanto o sublime não cria os arquivos padrões
    for (( ; ; )); do

        if [[ -d "${d[6]}" ]]; then

            # hexed.it: get position and convert to decimal, put in seek
            # Altera sequência binária do executável
            [[ $(xxd -p -seek 158612 -l 3 "${f[subl_exec]}") =~ "97940d" ]] \
                && sudo pkill subl \
                && printf '\00\00\00' | dd of="${f[subl_exec]}" bs=1 seek=158612 count=3 conv=notrunc status=none

            # Inserindo a chave do produto
            [[ ! -e "${f[subl_license]}" || $(grep --files-without-match "Member" "${f[subl_license]}") ]] \
                && sudo tee "${f[subl_license]}" > "${f[null]}" <<< '----- BEGIN LICENSE -----
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
                && sudo mkdir --parents "${d[12]}" \
                && sudo chown --recursive ${USER}:${USER} "${d[12]}" \
                && curl --location --silent --output "${f[subl_pkg_ctrl]}" --create-dirs "${l[12]}"

            [[ ! -e "${f[subl_pkg]}" || $(grep --files-without-match "packages" "${f[subl_pkg]}") ]] \
                && sudo tee "${f[subl_pkg]}" > "${f[null]}" <<< '{
    "installed_packages": ["Anaconda", "Djaneiro", "Restart", "SublimeREPL"]
}'

    		for (( ; ; )); do

				# Se instalou um pacote, instalou o restante também, então...
	            if [[ -e "${f[subl_anaconda]}"  ]]; then

	                # Informando ao Anaconda para sublinhar aos códigos específicos do PY 3.6
	                sudo sed -i 's|"python"|"/usr/bin/python3.6"|g' "${f[subl_anaconda]}"

	                sudo sed -i 's|"swallow_startup_errors": false|"swallow_startup_errors": true|g' "${f[subl_anaconda]}"

                    sudo tee -a "${f[subl_keymap]}" > "${f[null]}" <<< '{
    "keys": ["ctrl+p"], "command": "run_existing_window_command", "args": {
        "id": "repl_python_run", "file": "config/Python/Main.sublime-menu"
    }
}'

                    sudo tee -a "${f[subl_settings]}" > "${f[null]}" <<< '{
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

                    ( nohup subl & ) > "${f[null]}" 2>&1

                    for contador in {1..10..1}; do

                        take_a_break

                    done

                    sudo pkill subl*

                fi

            done

        break

        else

            escreva "\nAcessaremos o sublime para ele criar o diretório padrão."

            # O sublime cria os diretórios padrão quando executado pela 1a vez
            ( nohup subl & ) > "${f[null]}" 2>&1

            take_a_break

            sudo pkill subl*

        fi

    done

}
#======================#

#======================#
upgrade() {

    # Filtra a última data em que foram realizadas atualizações
    last=$(grep "Start-Date" "${f[apt_history]}" | tail -1 | awk '{print $2}')

    # Modifica o formato de data pro BR
    date=$(date -d "${last}" +"%d/%m/%Y")
    escreva "OH ${name[random]}, LAST TIME WE'VE SEEN YOU WAS IN\n\t\t${c[CIANO]}${date}\n\n${c[BRANCO]}UPGRADING..."

    sudo apt update > "${f[null]}" 2>&-; sudo apt upgrade -y > "${f[null]}" 2>&-

}
#======================#

#======================#
tmate_stuffs() {  # Okzão

    if [[ $(dpkg -l | awk "/${m[10]}/ {print }" | wc -l) -ge 1 ]]; then

        escreva "\n${c[VERDE]}${m[10]^^} ${c[BRANCO]}${linei:${#m[10]}} [INSTALLED]\n"

        read -p $'\033[1;37mSIR, SHOULD I UNINSTALL? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${m[10]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${m[10]}" > "${f[null]}" 2>&-

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\t  I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[10]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

        install_packages "${m[10]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    checar_ssh

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
usefull_pkgs() {

    # Se seu vlc estiver em inglês, instale: "vlc-l10n" e remova ~/.config/vlc
    p=(
        'tree'
        'vlc'
        'vim'
        'easytag'
    )

    if [[ $(dpkg -l | awk "/${p[0]}/ {print }" | wc -l) -ge 1 && $(dpkg -l | awk "/${p[1]}/ {print }" | wc -l) -ge 1 && $(dpkg -l | awk "/${p[2]}/ {print }" | wc -l) -ge 1 && $(dpkg -l | awk "/${p[3]}/ {print }" | wc -l) -ge 1 ]]; then

        for package in ${p[@]}; do

            escreva "\n${c[VERDE]}${package^^} ${c[BRANCO]}${linei:${#package}} [INSTALLED]"

        done

        read -p $'\033[1;37m\nSIR, SHOULD I UNINSTALL THEM? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}U${c[BRANCO]}NINSTALLING ${c[VERMELHO]}${p[0]^^}${c[BRANCO]}, ${c[VERMELHO]}${p[1]^^}${c[BRANCO]}, ${c[VERMELHO]}${p[2]^^}${c[BRANCO]} AND ${c[VERMELHO]}${p[3]^^}${c[BRANCO]}!\n"

                sudo apt remove --purge -y "${p[0]}" "${p[1]}" "${p[2]}" "${p[3]}" > "${f[null]}" 2>&-

                sudo rm --recursive --force "${f[vimrc]}"

                sudo sed -zi 's|video/x-matroska=vlc.desktop\nvideo/mp4=vlc.desktop||g' "${f[mimeapps]}"

                remocao_inuteis

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n     I${c[BRANCO]}NSTALLING ${c[VERDE]}${m[40]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!" 1

        install_packages "${p[0]}" "${p[1]}" "${p[2]}" "${p[3]}"; echo

    fi

    escreva "INITIALIZING CONFIGS..."

    [[ ! -e "${f[mimeapps]}" || $(grep --files-without-match "vlc" "${f[mimeapps]}") ]] \
        && sudo tee -a "${f[mimeapps]}" > "${f[null]}" <<< 'video/x-matroska=vlc.desktop
video/mp4=vlc.desktop'

    [[ ! -e "${f[vimrc]}" || $(grep --files-without-match "set number" "${f[mimeapps]}") ]] \
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

    echo; escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
workspace_stuffs() {  # Okzão

    if [[ -d "${d[7]}" || $(stat --format "%U" "${d[7]}" 2>&-) = ${USER} ]]; then

        escreva "\n${c[VERDE]}${m[9]^^} ${c[BRANCO]}${linec:${#m[9]}} [CREATED]\n"

        read -p $'\033[1;37mSIR, SHOULD I REMOVE? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ "${option:0:1}" = @(s|S|y|Y) ]] ; then

                escreva "\n${c[VERMELHO]}R${c[BRANCO]}EMOVING ${c[VERMELHO]}${d[7]^^}${c[BRANCO]}!\n"

                sudo rm --recursive --force "${d[7]}"

                [[ $(grep --files-with-matches "workspace" "${f[bookmarks]}") ]] \
                    && sudo sed -i 's|file:///workspace workspace||g' "${f[bookmarks]}"

                escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

                retorna_menu && break

            elif [[ "${option:0:1}" = @(N|n) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I UNINSTALL?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    else

        [[ "${1}" -eq 1 ]] \
            && escreva "${c[VERDE]}\n\t  C${c[BRANCO]}REATING ${c[VERDE]}${m[9]^^}${c[BRANCO]} AND ${c[VERDE]}CONFIGURATING${c[BRANCO]}!\n" 1 \
            || escreva "${c[VERDE]}\nC${c[BRANCO]}REATING ${c[VERDE]}${m[9]^^}${c[BRANCO]}!\n"

        sudo mkdir --parents "${d[7]}"

        sudo chown --recursive ${USER}:${USER} "${d[7]}"

    fi

    escreva "INITIALIZING CONFIGS..."

    [[ ! -e "${f[bookmarks]}" || $(grep --files-without-match "workspace" "${f[bookmarks]}") ]] \
        && sudo tee -a "${f[bookmarks]}" > "${f[null]}" <<< 'file:///workspace workspace'

    if [[ ! -d "${d[7]}"/"${r[0]}" && ! -d "${d[7]}"/"${r[1]}" && ! -d "${d[7]}"/"${r[2]}" && ! -d "${d[7]}"/"${r[3]}" && ! -d "${d[7]}"/"${r[4]}" ]]; then

        echo; read -p $'\033[1;37mSHOULD I DOWNLOAD SOME REPOSITORIES? \n[Y/N] R: \033[m' option

        for (( ; ; )); do

            if [[ ${option:0:1} = @(s|S|y|Y) ]] ; then

                echo; escreva "FIRST THINGS FIRST. DO U PASS THROUGH GIT STUFFS?" 1

                github_stuffs

                git clone -q git@github.com:rafaelribeiroo/"${r[0]}".git "${d[7]}"/"${r[0]}"

                git clone -q git@github.com:rafaelribeiroo/"${r[1]}".git "${d[7]}"/"${r[1]}"

                git clone -q git@github.com:rafaelribeiroo/"${r[2]}".git "${d[7]}"/"${r[2]}"

                git clone -q git@github.com:rafaelribeiroo/"${r[3]}".git "${d[7]}"/"${r[3]}"

                git clone -q git@github.com:rafaelribeiroo/"${r[4]}".git "${d[7]}"/"${r[4]}"

                echo && break

            elif [[ ${option:0:1} = @(n|N) ]] ; then

                echo && break

            else

                echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}\n\t\t${c[BRANCO]}PLEASE, ONLY Y OR N!\n\nSR. SHOULD I DOWNLOAD SOME REPOSITORIES?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]}

                read option

            fi

        done

    fi

    escreva "OPERATION COMPLETED SUCCESSFULLY, ${name[random]}!"

}
#======================#

#======================#
invoca_funcoes() {

    case "${escolha}" in

        0|00) encerra_menu > "${f[null]}" ;;
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
        20) echo; escreva "KNOW YOUR LIMITS ${name[random]}..."

        install_packages "${m[32]}" "${m[41]}"

        # START APPLETS STUFFS
        if [[ ! -e "${f[capslock]}" && ! -e "${f[pomodoro]}" ]]; then

            [[ ! -d "${d[13]}" || $(stat --format "%U" "${d[13]}" 2>&-) != ${USER} ]] \
                && sudo mkdir --parents "${d[13]}" \
                && sudo chown --recursive ${USER}:${USER} "${d[13]}"

            wget --quiet "${l[22]}" --output-document "${f[capslock]}"

            wget --quiet "${l[23]}" --output-document "${f[pomodoro]}"

        fi

        [[ ! -d "${d[15]}" && ! -d "${d[16]}" ]] \
            && unzip "${d[14]}"'/*.zip' -d "${d[14]}" > "${f[null]}" 2>&- \
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

        echo; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO BASH COLORFULL"

        bash_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO DEEZLOADER"
        deezloader_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO FEH"
        feh_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO GITHUB"
        github_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO CHROME"
        chrome_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO CONKY"
        conky_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO FLAMESHOT"
        flameshot_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO HEROKU"
        heroku_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO HIDE SOME DEVICES"
        hide_devices; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO MINIDLNA"
        minidlna_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO NVIDIA"
        nvidia_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO POSTGRES"
        postgres_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO PYTHON LIBRARIES"
        py_libraries; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO PYTHON UPGRADE"
        upgrade_py; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO SUBLIME"
        sublime_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO UPGRADE THE SYSTEM"
        upgrade; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO TMATE"
        tmate_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO USEFULL PACKAGES"
        usefull_pkgs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO WORKSPACE"
        workspace_stuffs; escreva "\n\t  ${c[CIANO]}WE'RE GOING TO FINISH THIS SHIT"

        echo; escreva "INITIALIZING CONFIGS..."; echo
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

        escreva "YOU SEE ONLY ONE END TO YOUR JOURNEY..."

        encerra_menu ;;

        *) echo -ne ${c[VERMELHO]}"\n   ${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}${c[BRANCO]}\n\t\t  PLEASE, ONLY NUMBERS!\n"${c[FIM]}
        retorna_menu ;;
        # take_a_break &&

    esac
}
#======================#

#======================#
menu() {

	for (( ; ; )); do

        sleep 0.1s; escreva "${c[VERMELHO]}=======================================================" 1

		for linha in "${!logo[@]}"; do
            escreva "    ${c[VERMELHO]}${logo[${linha}]}" 1
            sleep 0.1s
        done

        sleep 0.1s; escreva "${c[VERMELHO]}=======================================================" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 00 ] ${c[BRANCO]}EXIT ${e[0]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 01 ] ${c[BRANCO]}BASH COLORFUL ${e[1]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 02 ] ${c[BRANCO]}DEEZLOADER ${e[2]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 03 ] ${c[BRANCO]}FEH ${e[3]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 04 ] ${c[BRANCO]}GIT/GITHUB ${e[4]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 05 ] ${c[BRANCO]}GOOGLE CHROME ${e[5]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 06 ] ${c[BRANCO]}CONKY ${e[6]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 07 ] ${c[BRANCO]}FLAMESHOT ${e[22]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 08 ] ${c[BRANCO]}HEROKU ${e[7]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 09 ] ${c[BRANCO]}HIDE WINDOWS DEVICES ${e[8]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 10 ] ${c[BRANCO]}MINIDLNA ${e[9]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 11 ] ${c[BRANCO]}NVIDIA DRIVER ${e[10]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 12 ] ${c[BRANCO]}POSTGRES ${e[11]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 13 ] ${c[BRANCO]}PY LIBRARIES ${e[12]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 14 ] ${c[BRANCO]}PY UPGRADE ${e[12]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 15 ] ${c[BRANCO]}SUBLIME TEXT ${e[13]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 16 ] ${c[BRANCO]}SYSTEM UPGRADE ${e[14]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 17 ] ${c[BRANCO]}TMATE ${e[15]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 18 ] ${c[BRANCO]}USEFULL PROGRAMS ${e[16]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 19 ] ${c[BRANCO]}WORKSPACE ${e[17]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}[ 20 ] ${c[BRANCO]}ALL ${e[18]}" 1
        sleep 0.1s; escreva "${c[VERMELHO]}=======================================================" 1

        read -n 2 -p $'\033[1;31m[    ]\033[m\033[4D' escolha

        # O read acima é inline, então passamos uma linha vazia para não afetar
        echo

		[[ "${escolha}" =~ ^[[:alpha:]]$ ]] \
			&& echo -ne ${c[VERMELHO]}"\n${e[19]} SOME MEN JUST WANT TO WATCH THE WORLD BURN ${e[19]}${c[BRANCO]}\n\t\tPLEASE, ONLY NUMBERS!\n\n${c[BRANCO]}WANT YOU RETURN SIR?${c[FIM]}\n${c[BRANCO]}[Y/N] R: "${c[FIM]} \
			&& read digitou_bobeira || invoca_funcoes "${escolha}"

			[[ "${digitou_bobeira:0:1}" == @(s|S|y|Y) ]] && retorna_menu \
            || encerra_menu && break

	done

}
#======================#

menu
