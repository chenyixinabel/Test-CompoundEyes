#!/bin/bash

#Usage ./size_percentage.sh <vid_setup program location> <all data location> <size> <percentage> <bash script location> <Hist_Nest program location>

#all data location should not end with "/"

# Generate dataset
cd $1
python Input_Setup.py $2 $2"/vid_frames_all" $3 $4

# Perform Experiment
cd $5
./batch_classification_parallel.sh $6"/" $2"/Test_s_"$3"_p_"$4"/"



