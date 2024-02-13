#!/bin/bash
cd $(dirname "$0")

datafile="data.txt"

first_line=$(head -n 1 "$datafile")
echo "First line: $first_line"

second_line=$(head -n 2 "$datafile" | tail -n 1)
echo "Second line: $second_line"

bash namecheap-dyndns.sh $first_line $second_line