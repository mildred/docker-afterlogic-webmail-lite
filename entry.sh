#!/bin/bash

if [ -n "$MYSQL_PASSWORD" ]; then
  sed -i "s|<DBPassword.*>|<DBPassword>$MYSQL_PASSWORD</DBPassword>|" \
    /usr/share/afterlogic/data/settings/settings.xml
fi
. /etc/apache2/envvars
set -x
exec "$@"
