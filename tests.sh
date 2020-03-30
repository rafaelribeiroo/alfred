#!/usr/bin/env bash

: 'fdisk -l  # Cheque qual o disco primário (primeiro)

# dd: alocar uma parte do seu disco gravando-o em um arquivo.
# if: vou extrair um espaço em disco de...
# of: colocar ele...
# bs: tamanho dele
# count: vou pegar apenas uma vez o espaço informado no bs
dd if=/dev/sda of=/swapfile bs=2G count=1  # Conceder swap
mkswap /swapfile  # formatar
swapon /swapfile  # ativar

Ao reiniciar, o swapfile vai ser perdido, a não ser que:

/etc/fstab
/swapfile swap swap defaults 0 0'

linei='------------------------------------------'

declare -A c=(
    [BRANCO]='\033[1;37m'  # 0 Branco
    [VERMELHO]='\033[31;1m'  # 1 Vermelho
    [VERDE]='\033[1;32m'  # 2 Verde
    [CIANO]='\033[1;36m'  # 3 Ciano
    [CINZA]='\033[1;30m'  # 4 Cinza
    [FIM]='\e[0m'  # 5 Sem mudança
    [VERMELHO-BLINK]='\033[31;1;5m'  # 6 Vermelho pisca
)

escreva() {

    echo -e ${c[BRANCO]}"${1}"${c[FIM]}

    # Se passar 1, não "dorme"
    [[ "${2}" -eq 1 ]] || take_a_break

}

take_a_break() {

    # O s é desnecessário, mas nas conferências eles solicitam
    sleep 3s

}

# https://stackoverflow.com/questions/16703647/why-does-curl-return-error-23-failed-writing-body

# systemctl list-unit-files --type service -all
# escreva "${c[VERMELHO]}=======================================================" 1

sudo apt update &> /dev/null

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

# ( nohup firefox & ) > "${f[35]}" 2>&1

#Quando instalamos o linux, o driver nouveau vem instalado por default, open-source, eles nao conseguem extrair o maximo do hardware
#ngm conhece melhor que nvidia que é quem faz o hardware

#entao precisamos colocar o nouveau na blacklist
