#!/bin/bash

#Usage ./decomp <videos_folder> <frames_folder> <format of frames>
#Folders should end with "/"

mkdir $2
ls -1 $1 | awk -v ffrm=$2 -F '.' '{system("mkdir "ffrm$1)}'
chmod -R 777 $2
ls -1 $1 | awk -v fvid=$1 -v ffrm=$2 -v fmf=$3 -v bs="\\"  -F "." '{system("ffmpeg -i "fvid$1"."$2" -vf select='''\''''eq(pict_type"bs",PICT_TYPE_I)'''\'''' -vsync 0 "ffrm$1"/I-Frames%d."fmf)}'



