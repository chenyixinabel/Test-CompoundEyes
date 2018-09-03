#!/bin/bash

#Usage ./batch_classification_parallel.sh <program location> <dataset location>

for((i=1;i<=24;i++))
do
echo "Running the program on Group "$i":"
./run_classifiers_parallel.sh $1 $2 $i
done
