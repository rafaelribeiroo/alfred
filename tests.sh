#!/usr/bin/env bash

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

    # Se passar 1, não "dorme"
    [[ "${2}" -ne 1 ]] && take_a_break

}

take_a_break() {

    # O s é desnecessário, mas nas conferências eles solicitam
    sleep 3s

}

e=(
    $'\360\237\232\252'  #  0 (porta): exit
    $'\360\237\216\250'  #  1 (pintor): bash colorful
    $'\360\237\216\247'  #  2 (headphone): deezloader
    $'\360\237\214\211'  #  3 (paisagem): dualmonitor
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
    $'\360\237\231\212'  # 20 (macaco calado): password
    $'\360\237\246\207'  # 21 (morcego): why do we fall...
    $'\360\237\223\267'  # 22 (câmera): flameshot
)

logo=(
    " █████╗ ██╗     ███████╗██████╗ ███████╗██████╗"
    "██╔══██╗██║     ██╔════╝██╔══██╗██╔════╝██╔══██╗"
    "███████║██║     █████╗  ██████╔╝█████╗  ██║  ██║"
    "██╔══██║██║     ██╔══╝  ██╔══██╗██╔══╝  ██║  ██║"
    "██║  ██║███████╗██║     ██║  ██║███████╗██████╔╝"
    "╚═╝  ╚═╝╚══════╝╚═╝     ╚═╝  ╚═╝╚══════╝╚═════╝ "
)

# usefull files
declare -A u=(
    [askpass]=/lib/cryptsetup/askpass
    [bashrc]=~/.bashrc
    [gtk_theme]=/org/cinnamon/desktop/interface/gtk-theme
    [mimeapps]=~/.config/mimeapps.list
    [null]=/dev/null
    [public_ssh]=~/.ssh/id_rsa.pub
    [user_dirs]=~/.config/user-dirs.dirs
    [srcs]=/etc/apt/sources.list
    [srcs_list]=/etc/apt/sources.list.d
)

#sudo -u postgres psql --command "CREATE DATABASE teste"
#sudo -u postgres psql --command "CREATE USER gabriel"
sudo -u postgres psql -d curso_em_video --command "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO gabriel"
# sudo -u postgres psql -d curso_em_video --command "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO gabriel"
#sudo -u postgres psql --command "GRANT ALL PRIVILEGES ON DATABASE curso_em_video TO gabriel"

# show "${c[RED]}=======================================================" 1

# systemctl cat systemd-tmpfiles-clean.timer runs on shutdown
# tar zxvf ~/Downloads/PanGPLinux.tgz --directory /tmp/ &> /dev/null

# sudo rm --force --recursive ~/Downloads/PanGPLinux.tgz

# sudo dpkg -i /tmp/GlobalProtect_deb-* &> /dev/null

#GlobalProtect_deb-5.0.8.0-6.deb
#GlobalProtect_deb_arm-5.0.8.0-6.deb

: 'l=(
    http://servidor.utech.com.br/softphone/uTechSoftphone.bin
    https://fullerton-it-network-public.s3-us-west-2.amazonaws.com/PanGPLinux.tgz
)

declare -A f=(
    [bin]=~/Downloads/uTechSoftphone.bin
)

curl --silent --output "${f[bin]}" --create-dirs "${l[0]}"

sudo rm -rf ~/desktop/uTechSoftphone.desktop '


: ' ~/.config/uTechSoftphone/contacts.json
[
    {
        "avatar": "",
        "extension": "0800151551",
        "monitor": false,
        "name": "Telefonica"
    },
    {
        "avatar": "",
        "extension": "0800109036",
        "monitor": false,
        "name": "Pro-Atividade"
    },
    {
        "avatar": "",
        "extension": "0800112499",
        "monitor": false,
        "name": "Gi-Telefonica"
    },
    {
        "avatar": "",
        "extension": "08009400612",
        "monitor": false,
        "name": "Algar"
    },
    {
        "avatar": "",
        "extension": "08002821231",
        "monitor": false,
        "name": "Oi"
    },
    {
        "avatar": "",
        "extension": "08007211021",
        "monitor": false,
        "name": "Embratel"
    }
] '

: ' softphone.json
{
   "Softphone":            {
      "mailboxNumber":        "*97",
      "captureDevId":         "default",
      "playbackDevId":        "default",
      "ringDevId":            "default",
      "dtmfType":             0,
      "dtmfDuration":         160,
      "dtmfPayload":          101,
      "transportType":        0,
      "autoAnswer":           false,
      "dnd":                  false,
      "fwdImmediate":         false,
      "fwdImmediateUrl":      "",
      "fwdBusy":              false,
      "fwdBusyUrl":           "",
      "fwdNoAnswer":          false,
      "fwdNoAnswerUrl":       "",
      "answerTimeout":        30,
      "record":               false,
      "recordDirectory":      "\/home\/ribeiro\/.config\/uTechSoftphone\/gravacoes",
      "maxRecords":           0,
      "enableVideo":          false,
      "enableVideoPreview":   false,
      "videoResolution":      1,
      "videoFrameRate":       1,
      "rssEnabled":           true,
      "rssChannel":           "http:\/\/rss.utech.com.br\/rss",
      "rssMedia":             false,
      "accountStatus":        0,
      "enablePnP":            false,
      "pnpUrl":               "",
      "autoAnswerBeep":       false,
      "tapiEnabled":          false,
      "tapiPort":             8000,
      "tapiUsername":         "admin",
      "tapiPassword":         "admin"
   },
   "EpConfig":             {
      "UaConfig":             {
         "maxCalls":             2,
         "threadCnt":            1,
         "mainThreadOnly":       false,
         "nameserver":           [ ],
         "userAgent":            "uTech Tecnologia",
         "stunServer":           [ ],
         "stunIgnoreFailure":    true,
         "natTypeInSdp":         1,
         "mwiUnsolicitedEnabled": true
      },
      "LogConfig":            {
         "msgLogging":           0,
         "level":                0,
         "consoleLevel":         0,
         "decor":                25328,
         "filename":             "utech-softphone.log",
         "fileFlags":            0
      },
      "MediaConfig":          {
         "clockRate":            16000,
         "sndClockRate":         44100,
         "channelCount":         2,
         "audioFramePtime":      20,
         "maxMediaPorts":        254,
         "hasIoqueue":           true,
         "threadCnt":            1,
         "quality":              8,
         "ptime":                0,
         "noVad":                true,
         "ilbcMode":             30,
         "txDropPct":            0,
         "rxDropPct":            0,
         "ecOptions":            0,
         "ecTailLen":            0,
         "sndRecLatency":        100,
         "sndPlayLatency":       140,
         "jbInit":               -1,
         "jbMinPre":             -1,
         "jbMaxPre":             -1,
         "jbMax":                360,
         "sndAutoCloseTime":     1,
         "vidPreviewEnableNative": true
      }
   },
   "TransportConfig":      {
      "port":                 5060,
      "portRange":            0,
      "publicAddress":        "",
      "boundAddress":         "",
      "qosType":              0,
      "qosParams":            {
         "qos.flags":            0,
         "qos.dscp_val":         0,
         "qos.so_prio":          0,
         "qos.wmm_prio":         0
      },
      "TlsConfig":            {
         "CaListFile":           "",
         "certFile":             "",
         "privKeyFile":          "",
         "password":             "",
         "method":               0,
         "ciphers":              [ ],
         "verifyServer":         false,
         "verifyClient":         false,
         "requireClientCert":    false,
         "msecTimeout":          0,
         "qosType":              0,
         "qosParams":            {
            "qos.flags":            0,
            "qos.dscp_val":         0,
            "qos.so_prio":          0,
            "qos.wmm_prio":         0
         },
         "qosIgnoreError":       true
      }
   },
   "AccountConfig":        {
      "priority":             0,
      "idUri":                "\"Rafael Ribeiro\" <sip:551631119044@192.168.42.102>",
      "AccountRegConfig":     {
         "registrarUri":         "sip:192.168.42.102",
         "registerOnAdd":        true,
         "timeoutSec":           300,
         "retryIntervalSec":     300,
         "firstRetryIntervalSec": 0,
         "randomRetryIntervalSec": 10,
         "delayBeforeRefreshSec": 5,
         "dropCallsOnFail":      false,
         "unregWaitMsec":        4000,
         "proxyUse":             3,
         "headers":              [ ]
      },
      "AccountSipConfig":     {
         "proxies":              [ ],
         "contactForced":        "",
         "contactParams":        "",
         "contactUriParams":     "",
         "authInitialEmpty":     false,
         "authInitialAlgorithm": "",
         "transportId":          -1,
         "authCreds":            [
            {
               "scheme":               "digest",
               "realm":                "*",
               "username":             "",
               "dataType":             0,
               "data":                 "",
               "akaK":                 "",
               "akaOp":                "",
               "akaAmf":               ""
            }
         ]
      },
      "AccountCallConfig":    {
         "holdType":             0,
         "prackUse":             2,
         "timerUse":             0,
         "timerMinSESec":        90,
         "timerSessExpiresSec":  1800
      },
      "AccountPresConfig":    {
         "publishEnabled":       false,
         "publishQueue":         true,
         "publishShutdownWaitMsec": 2000,
         "pidfTupleId":          "",
         "headers":              [ ]
      },
      "AccountMwiConfig":     {
         "enabled":              false,
         "expirationSec":        3600
      },
      "AccountNatConfig":     {
         "sipStunUse":           0,
         "mediaStunUse":         0,
         "iceEnabled":           false,
         "iceMaxHostCands":      -1,
         "iceAggressiveNomination": true,
         "iceNominatedCheckDelayMsec": 400,
         "iceWaitNominationTimeoutMsec": 10000,
         "iceNoRtcp":            false,
         "iceAlwaysUpdate":      true,
         "turnEnabled":          false,
         "turnServer":           "",
         "turnConnType":         17,
         "turnUserName":         "",
         "turnPasswordType":     0,
         "turnPassword":         "",
         "contactRewriteUse":    1,
         "contactRewriteMethod": 6,
         "viaRewriteUse":        1,
         "sdpNatRewriteUse":     0,
         "sipOutboundUse":       1,
         "sipOutboundInstanceId": "",
         "sipOutboundRegId":     "",
         "udpKaIntervalSec":     15,
         "udpKaData":            "\r\n",
         "contactUseSrcPort":    1
      },
      "AccountMediaConfig":   {
         "lockCodecEnabled":     false,
         "streamKaEnabled":      false,
         "srtpUse":              0,
         "srtpSecureSignaling":  0,
         "ipv6Use":              0,
         "TransportConfig":      {
            "port":                 4000,
            "portRange":            128,
            "publicAddress":        "",
            "boundAddress":         "",
            "qosType":              0,
            "qosParams":            {
               "qos.flags":            0,
               "qos.dscp_val":         0,
               "qos.so_prio":          0,
               "qos.wmm_prio":         0
            },
            "TlsConfig":            {
               "CaListFile":           "",
               "certFile":             "",
               "privKeyFile":          "",
               "password":             "",
               "method":               0,
               "ciphers":              [ ],
               "verifyServer":         false,
               "verifyClient":         false,
               "requireClientCert":    false,
               "msecTimeout":          0,
               "qosType":              0,
               "qosParams":            {
                  "qos.flags":            0,
                  "qos.dscp_val":         0,
                  "qos.so_prio":          0,
                  "qos.wmm_prio":         0
               },
               "qosIgnoreError":       true
            }
         }
      },
      "AccountVideoConfig":   {
         "autoShowIncoming":     false,
         "autoTransmitOutgoing": false,
         "windowFlags":          0,
         "defaultCaptureDevice": 2,
         "defaultRenderDevice":  -2,
         "rateControlMethod":    0,
         "rateControlBandwidth": 0
      }
   },
   "CodecsConfig":         {
      "codecs":               [
         {
            "codecId":              "G722\/16000\/1",
            "priority":             8
         },
         {
            "codecId":              "speex\/16000\/1",
            "priority":             7
         },
         {
            "codecId":              "speex\/8000\/1",
            "priority":             6
         },
         {
            "codecId":              "speex\/32000\/1",
            "priority":             5
         },
         {
            "codecId":              "iLBC\/8000\/1",
            "priority":             4
         },
         {
            "codecId":              "GSM\/8000\/1",
            "priority":             3
         },
         {
            "codecId":              "PCMU\/8000\/1",
            "priority":             2
         },
         {
            "codecId":              "PCMA\/8000\/1",
            "priority":             1
         },
         {
            "codecId":              "L16\/44100\/1",
            "priority":             0
         },
         {
            "codecId":              "L16\/44100\/2",
            "priority":             0
         },
         {
            "codecId":              "L16\/8000\/1",
            "priority":             0
         },
         {
            "codecId":              "L16\/8000\/2",
            "priority":             0
         },
         {
            "codecId":              "L16\/16000\/1",
            "priority":             0
         },
         {
            "codecId":              "L16\/16000\/2",
            "priority":             0
         }
      ],
      "videoCodecs":          [ ]
   }
}
'


#sudo chmod +x
#0> /dev/null sudo bash -c ~/Downloads/uTechSoftphone.bin &> /dev/null

#http://servidor.utech.com.br/softphone/uTechSoftphone.bin

# psql postgres -tAc "SELECT 1 FROM pg_roles WHERE rolname='postgres'"

# systemctl list-unit-files --type service -all
