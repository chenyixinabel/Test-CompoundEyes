#!/bin/bash

#Notice: all the folder parameters should end with "/"
#Usage ./run_classifiers_new.sh <program location> <dataset location> <set number>

#Run Hist_Nest
cd $1
./Hist_Nest_new $2"Test_v"$3"/"$3"_train/" $2"Test_v"$3"/groundtruth/GT_new_"$3"_train.txt" $2"Test_v"$3"/"$3"_test/" $2"Test_v"$3"/groundtruth/GT_new_"$3"_test.txt" >> results.txt

#Move results to the corresponding location
mkdir $2"Test_v"$3"/inter_save"
chmod -R 777 $2"Test_v"$3"/inter_save"
cd ..
cp -r ~/workspace/Hist_Nest_new/Label_files $1/results.txt $2"Test_v"$3"/inter_save"
rm -rf ~/workspace/Hist_Nest_new/Label_files $1/results.txt
rm -rf ~/workspace/Hist_Nest_new/src/Nest/nest_*.conf

#Remove the training and testing frame folders
cd $2"Test_v"$3
rm -rf $3"_test" $3"_train" "vid_"$3"_frames"
