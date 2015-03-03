#!/bin/bash

sedargs=()

if [[ -n "$MYSQL_PASSWORD" ]]; then
    sedargs+=(-e "s|<DBPassword.*>|<DBPassword>$MYSQL_PASSWORD</DBPassword>|")
fi

if [[ -n "$MYSQL_USER" ]]; then
    sedargs+=(-e "s|<DBLogin.*>|<DBLogin>$MYSQL_USER</DBLogin>|")
fi

if [[ -n "$IMAP_PORT" ]]; then
    sedargs+=(-e "s|<IncomingMailPort.*>|<IncomingMailPort>$IMAP_PORT</IncomingMailPort>|")
fi

if [[ "$IMAP_SSL" = true ]]; then
    sedargs+=(-e "s|<IncomingMailUseSSL.*>|<IncomingMailUseSSL>On</IncomingMailUseSSL>|")
elif [[ "$IMAP_SSL" = false ]]; then
    sedargs+=(-e "s|<IncomingMailUseSSL.*>|<IncomingMailUseSSL>Off</IncomingMailUseSSL>|")
fi

if [[ -n "$SMTP_PORT" ]]; then
    sedargs+=(-e "s|<OutgoingMailPort.*>|<OutgoingMailPort>$SMTP_PORT</OutgoingMailPort>|")
fi

if [[ "$SMTP_SSL" = true ]]; then
    sedargs+=(-e "s|<OutgoingMailUseSSL.*>|<OutgoingMailUseSSL>On</OutgoingMailUseSSL>|")
elif [[ "$SMTP_SSL" = false ]]; then
    sedargs+=(-e "s|<OutgoingMailUseSSL.*>|<OutgoingMailUseSSL>Off</OutgoingMailUseSSL>|")
fi

if [[ ${#sedargs} -gt 0 ]]; then
    sed -i "${sedargs[@]}" /usr/share/afterlogic/data/settings/settings.xml
fi

. /etc/apache2/envvars
set -x
exec "$@"
