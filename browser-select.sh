#!/bin/sh
get_base_domain() {
    echo "$1" | awk -F/ '{print $3}'
}

open_in_spotify() {
    dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.OpenUri string:"$1"
}

url="$1"
base_domain=$(get_base_domain "$url")

if echo "$base_domain" | grep -q "gitlab";
then
    vivaldi-snapshot "$url"
elif [ "$base_domain" = "open.spotify.com" ]
then
    open_in_spotify "$url"
else
    vivaldi "$url"
fi
