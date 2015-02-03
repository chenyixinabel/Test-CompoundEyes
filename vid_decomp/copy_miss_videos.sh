#!/bin/bash

#Usage ./copy_miss_videos.sh <video_set> <all_video_set> <missing_video_folder>

mkdir $3
chmod 777 $3
cd $1
find . -type d -empty | awk -v msf=$3 -v all_vid=$2 -v wid='*' -F '/' '{system("cd "all_vid";cp "$2wid" "msf)}'

