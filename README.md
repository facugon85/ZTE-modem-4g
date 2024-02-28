# ZTE-modem-4g
Scipt simple que permite la comunicacion entre la pc y SMS a traves de un modem 4g 
./send_sms.sh +1234567890 "Hello world!"

Script para enviar mensajes SMS con módem USB
Este script en Bash está diseñado para enviar mensajes de texto (SMS) utilizando un módem USB. A continuación, se describen los detalles sobre su funcionamiento y cómo ejecutarlo:

Descripción
El script permite enviar mensajes SMS a través de un módem USB conectado a tu computadora. Puedes ingresar un número de teléfono y un mensaje, y el script se encargará de codificar y enviar el SMS.

Funcionamiento
Configuración inicial:
El script solicita al usuario ingresar un número de teléfono y un mensaje (limitado a 100 caracteres).
El mensaje se codifica en formato UTF-16BE para asegurar que los caracteres especiales se manejen correctamente.
Funciones del script:
_var_set: Verifica el tipo de módem y actualiza la dirección IP en consecuencia.
set_mode: Establece el modo del módem (GSM_AND_LTE o Only_LTE) mediante una solicitud HTTP POST.
animate_sending: Muestra una animación mientras se envía el mensaje.
_sms_send: Envía el mensaje codificado al número de teléfono especificado.
Registro de mensajes:
El archivo de registro “log.txt” guarda información sobre los mensajes enviados exitosamente.
Cada entrada incluye la fecha, hora y el número de teléfono al que se envió el mensaje.
Ejecución
Asegúrate de tener instalado Bash en tu sistema.
Ejecuta el script desde la línea de comandos: ./nombre_del_script.sh
Sigue las instrucciones para ingresar el número de teléfono y el mensaje.
Equipo y requisitos
El script se ejecuta en cualquier sistema operativo que admita Bash.
Requiere un módem USB compatible y configurado correctamente.
El archivo de registro “log.txt” se creará en el mismo directorio donde se encuentra el script.