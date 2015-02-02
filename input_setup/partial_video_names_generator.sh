#!/bin/bash

# Usage ./video_names_generator.sh <video_folder> <video names folder> <video folder num>
mkdir $2
cd $1
ls -1d $3"_"* | sort -n -k 2 -t _ | awk -F '_' '{print $0}' > $2/VN$3.txt
