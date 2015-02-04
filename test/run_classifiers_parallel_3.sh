#!/bin/bash

#Notice: all the folder parameters should end with "/"
#Usage ./run_classifiers_parallel.sh <program location> <dataset location> <set number>

#Run Hist_Nest
cd $1"/Debug"
./Hist_Nest_parallel_3 $2"Test_v"$3"/"$3"_train/" $2"Test_v"$3"/groundtruth/GT_new_"$3"_train.txt" $2"Test_v"$3"/"$3"_test/" $2"Test_v"$3"/groundtruth/GT_new_"$3"_test.txt" >> results.txt

#Move results to the corresponding location
mkdir $1"/Test/Test_v"$3
chmod -R 777 $1"/Test/Test_v"$3
mkdir $1"/Test/Test_v"$3"/inter_save"
chmod -R 777 $1"/Test/Test_v"$3"/inter_save"
cd ..
cp -r $1"/Label_files" $1"/Debug/results.txt" $1"/Test/Test_v"$3"/inter_save"
rm -rf $1"/Label_files" $1"/Debug/results.txt"
rm -rf $1"/src/Nest/nest_*.conf"
