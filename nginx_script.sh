#!/bin/bash

# Diretório de logs
LOG_DIR=/nginx2/Atividade-Linux-Nginx

# Data e hora atuais
DATA_HORA=$(date '+%Y-%m-%d %H:%M:%S')

# Verificando status do Nginx
if systemctl is-active --quiet nginx; then
    STATUS="ONLINE"
    MENSAGEM="O serviço Nginx está funcionando normalmente."
    echo "$DATA_HORA - Nginx - Status: $STATUS - $MENSAGEM" >> "$LOG_DIR/online.log"
else
    STATUS="OFFLINE"
    MENSAGEM="O serviço Nginx está fora do ar."
    echo "$DATA_HORA - Nginx - Status: $STATUS - $MENSAGEM" >> "$LOG_DIR/offline.log"
fi
