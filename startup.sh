#!/bin/bash

function get_property {
    sed -n "s/^$2 *= *//p" "$1"
}

NAME=$(get_property ./server-settings.ini serverName)
PASSWORD=$(get_property ./server-settings.ini connectPassword)
IP=$(get_property ./server-settings.ini connectip)
PORT=$(get_property ./server-settings.ini connectPort)

if [ -z "$NAME" ] || [ -z "$PASSWORD" ] || [ -z "$IP" ] || [ -z "$PORT" ]; then
    echo "One or more properties not found in server-settings.ini"
    exit 1
fi

echo $NAME
echo $PASSWORD

# Assuming cloneheroserver is in your PATH, you can directly run it
cloneheroserver -n "PANGuitarHero" -d -ps password
