#!/bin/bash
set -e

# Helper to read values from the legacy ini file if present
get_property() {
    sed -n "s/^$2 *= *//p" "$1" 2>/dev/null
}

# Allow configuration via environment variables with optional fallbacks to
# `server-settings.ini` for backwards compatibility.
NAME=${SERVER_NAME:-$(get_property ./server-settings.ini serverName)}
PASSWORD=${SERVER_PASSWORD:-$(get_property ./server-settings.ini connectPassword)}
IP=${CONNECT_IP:-$(get_property ./server-settings.ini connectip)}
PORT=${CONNECT_PORT:-$(get_property ./server-settings.ini connectPort)}

# Validate required values
: "${NAME:?SERVER_NAME not set and serverName missing in server-settings.ini}" \
  "${PASSWORD:?SERVER_PASSWORD not set and connectPassword missing in server-settings.ini}" \
  "${IP:?CONNECT_IP not set and connectip missing in server-settings.ini}" \
  "${PORT:?CONNECT_PORT not set and connectPort missing in server-settings.ini}"

echo "Starting Clone Hero server with:"
echo "  Name: $NAME"
echo "  IP:   $IP"
echo "  Port: $PORT"

# Run the dedicated server
exec cloneheroserver -n "$NAME" -ip "$IP" -p "$PORT" -ps "$PASSWORD" -d
