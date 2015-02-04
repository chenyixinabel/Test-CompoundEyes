#!/bin/bash

#Usage ./batch_classification_parallel.sh <classifiers location> <dataset location> <result folder location>

mkdir $1"Hist_Nest_parallel_1/Test"
chmod -R 777 $1"Hist_Nest_parallel_1/Test"
for((i=1;i<=24;i++))
do
./run_classifiers_parallel_1.sh $1"Hist_Nest_parallel_1" $2 $i
done
echo 1/7

mkdir $1"Hist_Nest_parallel_2/Test"
chmod -R 777 $1"Hist_Nest_parallel_2/Test"
for((i=1;i<=24;i++))
do
./run_classifiers_parallel_2.sh $1"Hist_Nest_parallel_2" $2 $i
done
echo 2/7

mkdir $1"Hist_Nest_parallel_3/Test"
chmod -R 777 $1"Hist_Nest_parallel_3/Test"
for((i=1;i<=24;i++))
do
./run_classifiers_parallel_3.sh $1"Hist_Nest_parallel_3" $2 $i
done
echo 3/7

mkdir $1"Hist_Nest_parallel_4/Test"
chmod -R 777 $1"Hist_Nest_parallel_4/Test"
for((i=1;i<=24;i++))
do
./run_classifiers_parallel_4.sh $1"Hist_Nest_parallel_4" $2 $i
done
echo 4/7

mkdir $1"Hist_Nest_parallel_5/Test"
chmod -R 777 $1"Hist_Nest_parallel_5/Test"
for((i=1;i<=24;i++))
do
./run_classifiers_parallel_5.sh $1"Hist_Nest_parallel_5" $2 $i
done
echo 5/7

mkdir $1"Hist_Nest_parallel_6/Test"
chmod -R 777 $1"Hist_Nest_parallel_6/Test"
for((i=1;i<=24;i++))
do
./run_classifiers_parallel_6.sh $1"Hist_Nest_parallel_6" $2 $i
done
echo 6/7

mkdir $1"Hist_Nest_parallel_2_1/Test"
chmod -R 777 $1"Hist_Nest_parallel_2_1/Test"
for((i=1;i<=24;i++))
do
./run_classifiers_parallel_2_1.sh $1"Hist_Nest_parallel_2_1" $2 $i
done
echo 7/7

mkdir $3"/best_comb_test"
chmod -R 777 $3"/best_comb_test"
mv $1"Hist_Nest_parallel_1/Test" $3"/best_comb_test/1_Test"
mv $1"Hist_Nest_parallel_2/Test" $3"/best_comb_test/2_Test"
mv $1"Hist_Nest_parallel_3/Test" $3"/best_comb_test/3_Test"
mv $1"Hist_Nest_parallel_4/Test" $3"/best_comb_test/4_Test"
mv $1"Hist_Nest_parallel_5/Test" $3"/best_comb_test/5_Test"
mv $1"Hist_Nest_parallel_6/Test" $3"/best_comb_test/6_Test"
mv $1"Hist_Nest_parallel_2_1/Test" $3"/best_comb_test/2_1_Test"
