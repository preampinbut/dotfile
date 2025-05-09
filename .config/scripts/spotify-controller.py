#!/usr/bin/env python3

import psutil
import dbus
import requests
import argparse

# Default parameters
output = u"{artist}: {song}"
timeout = 3

url = "http://localhost:36842"

def getpidof(name):
    for proc in psutil.process_iter(attrs=["pid", "name"]):
        if proc.info["name"] and name.lower() in proc.info["name"].lower():
            return proc.info["pid"]
    return None

parser = argparse.ArgumentParser()

parser.add_argument(
    "-f",
    "--format",
    type=str,
    metavar="custom format",
    dest="custom_format"
)
parser.add_argument(
    "--timeout",
    type=int,
    metavar="request timeout",
    dest="timeout"
)
parser.add_argument(
    "-u",
    "--url",
    type=str,
    metavar="go-librespot server url",
    dest="url"
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
if args.custom_format is not None:
    output = args.custom_format
if args.timeout is not None:
    timeout = args.timeout
if args.url is not None:
    url = args.url

command = args.command

# looking for spotifyd player
try:
    session_bus = dbus.SessionBus()
    spotify_bus = session_bus.get_object(
        "org.mpris.MediaPlayer2.spotifyd.instance" + str(getpidof("spotifyd")),
        "/org/mpris/MediaPlayer2"
    )
    player = dbus.Interface(
        spotify_bus,
        "org.mpris.MediaPlayer2.Player"
    )
# if not found means it either offline or listening on other device
except:
    player = None

try:
    if command in ["PlayPause", "Next", "Previous"]:
        remote_player = requests.get(f"{url}/web-api/v1/me/player", timeout=timeout).json()
        match command:
            case "PlayPause":
                if player != None:
                    player.PlayPause()
                else:
                    if remote_player["is_playing"]:
                        requests.put(f"{url}/web-api/v1/me/player/pause", timeout=timeout)
                    else:
                        requests.put(f"{url}/web-api/v1/me/player/play", timeout=timeout)
            case "Next":
                if player != None:
                    player.Next()
                else:
                    requests.post(f"{url}/web-api/v1/me/player/next", timeout=timeout)
            case "Previous":
                if player != None:
                    player.Previous()
                else:
                    requests.post(f"{url}/web-api/v1/me/player/previous", timeout=timeout)
    elif command in ["Artist", "Title"]:
        player = requests.get(f"{url}/web-api/v1/me/player/currently-playing", timeout=timeout).json()
        match command:
            case "Artist":
                print(player["item"]["artists"][0]["name"])
            case "Title":
                print(player["item"]["name"])
    elif command in ["Status"]:
        player = requests.get(f"{url}/web-api/v1/me/player", timeout=timeout).json()
        artist = player["item"]["artists"][0]["name"]
        title = player["item"]["name"]
        if player["is_playing"]:
            status = "playing"
        else:
            status = "paused"
        print(f"{{ \"text\": \"{output.format(artist=artist, song=title)}\", \"class\": \"{status}\", \"alt\": \"{status}\" }}")
except:
    print(f"{{ \"text\": \"Offline\", \"class\": \"offline\", \"alt\": \"offline\" }}\n")
