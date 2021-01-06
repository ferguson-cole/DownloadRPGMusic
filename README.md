# DownloadRPGMusic
A Ruby Script that utilizes both youtube-dl and ffmpeg to download specific portions of longer videos. Many of the videos that I find for ambience tracks for TTRPGs are 8-10 hours long, and trimming them down takes multiple commands (with my standard youtube-dl to ffmpeg method). This became pretty tedious when downloading multiple videos, so this script allows me to download and trim videos to my specifications with a simpler and quicker syntax. This script is very lightweight and could host many more QOL improvements, but it accomplishes what I set out to do. 

# Syntax:
download_rpg_music.rb [URL] [(optional) duration - quantity] [(optional) duration - unit of time]
Acceptable units of time are:
- h, hour, hours
- m, min, minute, minutes
- s, sec, second, seconds

# Example Usage:

To download one minute of linked video:
$ ruby download_rpg_music.rb https://youtu.be/1ZMd1AT3iAE 1 min

To download 30 seconds of linked video:
$ ruby download_rpg_music.rb https://youtu.be/1ZMd1AT3iAE 30 s

Without the script, you would have to run:
$ youtube-dl https://youtu.be/1ZMd1AT3iAE
$ ffmpeg -i [youtube-dl resultant filepath] -t [HH:MM:SS] [desired output filepath]
