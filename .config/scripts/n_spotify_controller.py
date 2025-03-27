#!/usr/bin/env python3

import psutil
import dbus
import requests
import argparse

# Default parameters
output = u'{play_pause} {artist}: {song}'
trunclen = 20
play_pause = u'󰐊,󰏤,󰝚,󰝚' # first character is play, second is paused first set is when listening on this machine and other set is while listening on remote

url = "http://localhost:36842"

def set_buffer(name, trunclen, prefix_size):
    buffer_size = trunclen - (len(name) - prefix_size)
    buffer = ' ' * buffer_size
    # Calculate the length of the buffer_string
    buffer_length = len(buffer)
    # Calculate the positions to split the buffer_string
    split_position = buffer_length // 2
    # Split the buffer_string into two halves
    first_half = buffer[:split_position]
    second_half = buffer[split_position:]
    # Combine the first half, the name, and the second half
    name = first_half + name + second_half
    return name
def truncate(name, trunclen, prefix_size):
    if (len(name) - prefix_size) > trunclen:
        name = name[:trunclen + prefix_size - 3]
        name += '...'
        if ('(' in name) and (')' not in name):
            name += ')'
    # else:
    #     name = set_buffer(name, trunclen, prefix_size)
    return name
def getpidof(name):
    for proc in psutil.process_iter(attrs=["pid", "name"]):
        if proc.info["name"] and name.lower() in proc.info["name"].lower():
            return proc.info["pid"]
    return None

parser = argparse.ArgumentParser()

parser.add_argument(
    '-t',
    '--trunclen',
    type=int,
    metavar='trunclen'
)
parser.add_argument(
    '-f',
    '--format',
    type=str,
    metavar='custom format',
    dest='custom_format'
)
parser.add_argument(
    '-p',
    '--playpause',
    type=str,
    metavar='play-pause indicator',
    dest='play_pause'
)

parser.add_argument("command",
                    choices=[
                        "PlayPause",
                        "Next",
                        "Previous",
                        "Artist",
                        "Title",
                        "Status"])

args = parser.parse_args()

# parameters can be overwritten by args
if args.trunclen is not None:
    trunclen = args.trunclen
if args.custom_format is not None:
    output = args.custom_format
if args.play_pause is not None:
    play_pause = args.play_pause

command = args.command

session_bus = dbus.SessionBus()
try:
    spotify_bus = session_bus.get_object(
        'org.mpris.MediaPlayer2.spotifyd.instance' + str(getpidof("spotifyd")),
        '/org/mpris/MediaPlayer2'
    )
    player = dbus.Interface(
        spotify_bus,
        'org.mpris.MediaPlayer2.Player'
    )
except:
    player = None

try:
    if command in ["PlayPause", "Next", "Previous"]:
        remote_player = requests.get(f"{url}/web-api/v1/me/player").json()
        match command:
            case "PlayPause":
                if player != None:
                    player.PlayPause()
                else:
                    if remote_player["is_playing"]:
                        requests.put(f"{url}/web-api/v1/me/player/pause")
                    else:
                        requests.put(f"{url}/web-api/v1/me/player/play")
            case "Next":
                if player != None:
                    player.Next()
                else:
                    requests.post(f"{url}/web-api/v1/me/player/next")
            case "Previous":
                if player != None:
                    player.Previous()
                else:
                    requests.post(f"{url}/web-api/v1/me/player/previous")
    elif command in ["Artist", "Title"]:
        player = requests.get(f"{url}/web-api/v1/me/player/currently-playing").json()
        match command:
            case "Artist":
                print(player["item"]["artists"][0]["name"])
            case "Title":
                print(player["item"]["name"])
    elif command in ["Status"]:
        player = requests.get(f"{url}/web-api/v1/me/player").json()
        artist = player["item"]["artists"][0]["name"]
        title = player["item"]["name"]
        play_pause = play_pause.split(",")
        if player["is_playing"]:
            play_pause = play_pause[0]
        else:
            play_pause = play_pause[1]

        print(truncate(output.format(artist=artist, song=title, play_pause=play_pause), trunclen + 4, len(play_pause)))
except:
    play_pause = play_pause.split(",")
    offline_prefix = f'%{{F#EC7875}}{play_pause[1]}%{{F-}}'
    offline = f'%{{u#EC7875}}{offline_prefix} Offline'
    print(offline)
