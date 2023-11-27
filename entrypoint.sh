#!/bin/bash

set -e

USERNAME=${USERNAME:-admin}
PASSWORD=${PASSWORD:-test}
PORT=${PORT:-5000}

if [ ! -e "/app/.htpasswd" ]; then
    touch "/app/.htpasswd"
    htpasswd -B -b -c "/app/.htpasswd" $USERNAME $PASSWORD
    chown -R www-data:www-data /app/.htpasswd
fi

sed -i "s/80/$PORT/g" /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

mkdir -p /app/data

usermod --non-unique --uid 1000 www-data \
  && groupmod --non-unique --gid 1000 www-data \
  && chown -R www-data:www-data /app/data

apachectl -D FOREGROUND
