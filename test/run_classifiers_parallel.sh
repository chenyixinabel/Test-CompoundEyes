#!/bin/bash

#Notice: all the folder parameters should end with "/"
#Usage ./run_classifiers_parallel.sh <program location> <dataset location> <set number>

#Run CompoundEyes
cd $1
./CompoundEyes $2"Test_v"$3"/"$3"_train/" $2"Test_v"$3"/groundtruth/GT_new_"$3"_train.txt" $2"Test_v"$3"/"$3"_test/" $2"Test_v"$3"/groundtruth/GT_new_"$3"_test.txt" >> results.txt

#Move results to the corresponding location
mkdir $2"Test_v"$3"/inter_save"
chmod -R 777 $2"Test_v"$3"/inter_save"
cd ..
cp -r ~/workspace/CompoundEyes/Label_files $1/results.txt $2"Test_v"$3"/inter_save"
rm -rf ~/workspace/CompoundEyes/Label_files $1/results.txt
rm -rf ~/workspace/CompoundEyes/src/Nest/nest_*.conf
