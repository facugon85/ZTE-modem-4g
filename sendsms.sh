#!/bin/bash

MODEM="MF833v"
MODEM_IP="192.168.8.1"

read -p "Ingrese el número de teléfono ej (11XXXXXXXX): " PHONE_NUMBER

read -p "Ingrese el mensaje (máximo 100 caracteres): " TECHNICIAN_MESSAGE
TECHNICIAN_MESSAGE=${TECHNICIAN_MESSAGE:0:100}  # Limitar el mensaje a 100 caracteres

MESSAGE_ENCODED=$(echo -n "$TECHNICIAN_MESSAGE" | iconv -t utf16be | xxd -p)

_var_set () {
    [ $MODEM == MF833v ] && MODEM_IP='192.168.8.1'
}

set_mode () {
    MODEM_MODE=$1
    [ $MODEM_MODE == LOW  ] && [ $MODEM == MF833v ] && MODEM_MODE='GSM_AND_LTE'
    [ $MODEM_MODE == HIGH ] && [ $MODEM == MF833v ] && MODEM_MODE='Only_LTE'

    wget -O - --header "Referer: http://$MODEM_IP/index.html" --post-data "isTest=false&goformId=SET_BEARER_PREFERENCE&BearerPreference=$MODEM_MODE" http://$MODEM_IP/goform/goform_set_cmd_process 2>/dev/null
}

animate_sending () {
    local frames=("⣷" "⣯" "⣟" "⡿" "⢿" "⣻" "⣽" "⣾")
    local delay=0.1

    for frame in "${frames[@]}"; do
        echo -ne "\rEnviando mensaje... $frame"
        sleep "$delay"
    done
}

_sms_send () {
    SMS_NUMBER=$1
    SMS_MESSAGE=$2

    animate_sending

    response=$(wget -O - --header "Referer: http://$MODEM_IP/index.html" --post-data "isTest=false&goformId=SEND_SMS&notCallback=true&Number=$SMS_NUMBER&sms_time=`date +%y%%3B%m%%3B%d%%3B%H%%3B%M%%3B%S%%3B%%2B6`&MessageBody=$SMS_MESSAGE&ID=-1&encode_type=UNICODE" http://$MODEM_IP/goform/goform_set_cmd_process 2>/dev/null)

    if [[ "$response" == *"result\":\"success"* ]]; then
        echo -e "\rEnviando mensaje... ¡Mensaje enviado exitosamente!   "
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Mensaje enviado exitosamente al número: $SMS_NUMBER." >> log.txt
    fi
}

_var_set
set_mode LOW
_sms_send "$PHONE_NUMBER" "$MESSAGE_ENCODED"
set_mode HIGH

exit 0
