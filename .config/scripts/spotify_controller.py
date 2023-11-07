#!/usr/bin/env python

import os
import re
import dbus
import argparse

parser = argparse.ArgumentParser()

parser.add_argument("command",
                    choices=[
                        "PlayPause",
                        "Next",
                        "Previous",
                        "Artist",
                        "Title",
                        "Restart"])

args = parser.parse_args()

command = args.command

def get_metadata(spotify_bus):
    spotify_properties = dbus.Interface(
        spotify_bus,
        'org.freedesktop.DBus.Properties'
    )
    return spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'Metadata')

try:
    session_bus = dbus.SessionBus()
    try:
        spotify_bus = session_bus.get_object(
            'org.mpris.MediaPlayer2.spotify',
            '/org/mpris/MediaPlayer2'
        )
    except:
        spotify_bus = session_bus.get_object(
            'org.mpris.MediaPlayer2.spotifyd',
            '/org/mpris/MediaPlayer2'
        )
    player = dbus.Interface(
        spotify_bus,
        'org.mpris.MediaPlayer2.Player'
    )
    match command:
        case "PlayPause":
            player.PlayPause()
        case "Next":
            player.Next()
        case "Previous":
            player.Previous()
        case "Artist":
            metadata = get_metadata(spotify_bus)
            print(metadata["xesam:artist"][0])
        case "Title":
            metadata = get_metadata(spotify_bus)
            print(metadata["xesam:title"])
        case "Restart":
            os.system("/usr/bin/systemctl --user restart spotifyd.service")

except dbus.exceptions.DBusException as e:
    if "org.freedesktop.DBus.Error.NoReply" == e.get_dbus_name():
        os.system("/usr/bin/systemctl --user restart spotifyd.service")

except Exception as e:
    msg = e.__str__()
    metadata_error = re.match("^'xesam:", msg)
    if metadata_error:
        print(str())
    else:
        print(msg)
