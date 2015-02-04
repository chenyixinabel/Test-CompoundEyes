#!/bin/bash

#Usage ./batch_classification_parallel.sh <classifiers location> <dataset location>

for((i=1;i<=24;i++))
do
./run_classifiers_parallel.sh $1 $2 $i
done
