#!/bin/bash
# arg1: domain_name
# arg2: ddns_password

if [ "$#" -ne 2 ]; then
    echo "usage: $0 domain_name ddns_password"
    exit 1
fi

script_dir=$(dirname "$0")
cd $script_dir

ipv4=$(curl -s "http://ipv4.icanhazip.com")
echo "ipv4: ${ipv4}"

logfile=$"ipv4.log"

if [ ! -e "${logfile}" ]; then
    touch "${logfile}"
    echo "${logfile} created"
    echo "${ipv4}" > $logfile
else
    echo "$logfile found"
    read -r stored_ipv4 < $logfile
    echo "${stored_ipv4}"
fi

if [ "${ipv4}" != "${stored_ipv4}" ]; then
    echo "ipv4 address changed"
    echo "${ipv4}" > $logfile
    echo "new ipv4 address stored"
    host="@"
    domain_name="${1}"
    ddns_password="${2}"
    your_ip="${ipv4}"
    requesthttps=$"https://dynamicdns.park-your-domain.com/update?host=${host}&domain=${domain_name}&password=${ddns_password}&ip=${ipv4}"
    echo "${requesthttps}"
    resquestresult=$(curl "${requesthttps}")
    echo "${resquestresult}"
else
    echo "ipv4 address did not change"
fi