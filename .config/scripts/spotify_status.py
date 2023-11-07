#!/usr/bin/env python

import os
import dbus
import argparse

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
parser.add_argument(
    '--font',
    type=str,
    metavar='the index of the font to use for the main label',
    dest='font'
)
parser.add_argument(
    '--playpause-font',
    type=str,
    metavar='the index of the font to use to display the playpause indicator',
    dest='play_pause_font'
)
parser.add_argument(
    '-q',
    '--quiet',
    action='store_true',
    help="if set, don't show any output when the current song is paused",
    dest='quiet',
)

args = parser.parse_args()


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

def print_offline(trunclen):
    offline_prefix = '%{F#EC7875}%{F-}'
    offline = '%{u#EC7875}' + set_buffer(f'{offline_prefix} Offline', trunclen + 4, len(offline_prefix))
    print(offline)

def fix_string(string):
    # corrects encoding for the python version used
    # if sys.version_info.major == 3:
    return string
    # else:
    #     return string.encode('utf-8')

def truncate(name, trunclen, prefix_size):
    if (len(name) - prefix_size) > trunclen:
        name = name[:trunclen + prefix_size - 3]
        name += '...'
        if ('(' in name) and (')' not in name):
            name += ')'
    else:
        name = set_buffer(name, trunclen, prefix_size)
    return name


# Default parameters
output = fix_string(u'{play_pause} {artist}: {song}')
trunclen = 20
play_pause = fix_string(u'\u25B6,\u23F8') # first character is play, second is paused

label_with_font = '%{{T{font}}}{label}%{{T-}}'
font = args.font
play_pause_font = args.play_pause_font

quiet = args.quiet

# parameters can be overwritten by args
if args.trunclen is not None:
    trunclen = args.trunclen
if args.custom_format is not None:
    output = args.custom_format
if args.play_pause is not None:
    play_pause = args.play_pause

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

    spotify_properties = dbus.Interface(
        spotify_bus,
        'org.freedesktop.DBus.Properties'
    )

    metadata = spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'Metadata')
    status = spotify_properties.Get('org.mpris.MediaPlayer2.Player', 'PlaybackStatus')

    # Handle play/pause label

    play_pause = play_pause.split(',')

    if status == 'Playing':
        play_pause = play_pause[0]
    elif status == 'Paused':
        play_pause = play_pause[1]
    else:
        play_pause = str() if len(play_pause) == 2 else play_pause[2]
        # play_pause = str()

    if play_pause_font:
        play_pause = label_with_font.format(font=play_pause_font, label=play_pause)

    # Handle main label

    artist = fix_string(metadata['xesam:artist'][0]) if metadata['xesam:artist'] else ''
    song = fix_string(metadata['xesam:title']) if metadata['xesam:title'] else ''
    album = fix_string(metadata['xesam:album']) if metadata['xesam:album'] else ''

    if (quiet and status == 'Paused') or (not artist and not song and not album):
        print_offline(trunclen)
    else:
        if font:
            artist = label_with_font.format(font=font, label=artist)
            song = label_with_font.format(font=font, label=song)
            album = label_with_font.format(font=font, label=album)
        
        # Add 4 to trunclen to account for status symbol, spaces, and other padding characters
        print(truncate(output.format(artist=artist, 
                                     song=song, 
                                     play_pause=play_pause, 
                                     album=album), trunclen + 4, len(play_pause)))

except dbus.exceptions.DBusException as e:
    if "org.freedesktop.DBus.Error.NoReply" == e.get_dbus_name():
        os.system("/usr/bin/systemctl --user restart spotifyd.service")
    print_offline(trunclen)


except Exception as e:
    print_offline(trunclen)

