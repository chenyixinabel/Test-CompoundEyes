#!/bin/bash

#Usage ./decomp <videos_folder> <frames_folder> <format of frames>

mkdir $2
ls -1 $1 | awk -v ffrm=$2 -v wild='*' -F '.' '{system("mkdir "ffrm$1"; cd "ffrm$1"; rm -rf "wild)}'
chmod -R 777 $2
ls -1 $1 | awk -v fvid=$1 -v ffrm=$2 -v fmf=$3 -F '.' '{system("ffmpeg -i "fvid$1"."$2" -r "rate" "ffrm$1"/I-Frames%d."fmf)}'
ls -1 $1 | awk -v fvid=$1 -v ffrm=$2 -v fmf=$3 -F '.' '{
	cmd = "ffmpeg -i "fvid$1"."$2" 2>&1 | sed -n \"s/.*, \\(.*\\) tbr.*/\\1/p\""
	while(cmd | getline fps > 0){
		rate = fps / 15
		system("ffmpeg -i "fvid$1"."$2" -r "rate" "ffrm$1"/I-Frames%d."fmf"&")
		}
		close(cmd);
	}'



