#!/bin/bash

#Usage ./expe_size.sh <vid_setup program location> <all data location> <bash script location> <Hist_Nest program location>

./size_percentage.sh $1 $2 1.0 0.9 $3 $4
echo "1/17"
./size_percentage.sh $1 $2 1.0 0.8 $3 $4
echo "2/17"
./size_percentage.sh $1 $2 1.0 0.7 $3 $4
echo "3/17"
./size_percentage.sh $1 $2 1.0 0.6 $3 $4
echo "4/17"
./size_percentage.sh $1 $2 1.0 0.4 $3 $4
echo "5/17"
./size_percentage.sh $1 $2 1.0 0.3 $3 $4
echo "6/17"
./size_percentage.sh $1 $2 1.0 0.2 $3 $4
echo "7/17"
./size_percentage.sh $1 $2 1.0 0.1 $3 $4
echo "8/17"

./size_percentage.sh $1 $2 0.9 0.5 $3 $4
echo "9/17"
./size_percentage.sh $1 $2 0.8 0.5 $3 $4
echo "10/17"
./size_percentage.sh $1 $2 0.7 0.5 $3 $4
echo "11/17"
./size_percentage.sh $1 $2 0.6 0.5 $3 $4
echo "12/17"
./size_percentage.sh $1 $2 0.5 0.5 $3 $4
echo "13/17"
./size_percentage.sh $1 $2 0.4 0.5 $3 $4
echo "14/17"
./size_percentage.sh $1 $2 0.3 0.5 $3 $4
echo "15/17"
./size_percentage.sh $1 $2 0.2 0.5 $3 $4
echo "16/17"
./size_percentage.sh $1 $2 0.1 0.5 $3 $4
echo "17/17"
