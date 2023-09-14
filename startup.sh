#!/bin/bash
function get_property
{
    sed "/^$2 *= */!d; s///" "$1"
}
NAME=`get_property ./server-settings.ini serverName`
PASSWORD=`get_property ./server-settings.ini connectPassword`
IP=`get_property ./server-settings.ini connectip`
PORT=`get_property ./server-settings.ini connectPort`

#printf "$NAME\n$PASSWORD\n$IP\n$PORT" | cloneheroserver

cloneheroserver -n "$NAME" -d -ps "$PASSWORD"