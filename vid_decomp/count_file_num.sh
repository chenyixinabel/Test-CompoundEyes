#!/bin/bash

#Usage ./count_file_num.sh <video_frames_folder> <count_num> <re_decomp_folder> <all_video_folder>

mkdir $3
chmod 777 $3
ls -1 $1 | awk -v vff=$1 -v num=$2 -v dest=$3 -v all_vid=$4 -v wild='*' '{
	cmd = "ls -1 "vff$1" | wc -l";
	while((cmd | getline count) > 0){
		if(count == num){
			system("cd "all_vid"; cp "$1wild" "dest);
		}
	}
	close(cmd);
}'
