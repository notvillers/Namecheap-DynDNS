#!/bin/bash
cd $(dirname "$0")

datafile="data.txt"
domain_name=$(head -n 1 "$datafile")
ddns_password=$(head -n 2 "$datafile" | tail -n 1)

bash namecheap-dyndns.sh $domain_name $ddns_password