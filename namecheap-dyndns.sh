#!/bin/bash

log_message() {
    log_file="log.txt"
    current_datetime=$(date +"%Y-%m-%d %H:%M:%S")
    echo "[$current_datetime] $1"
    echo "[$current_datetime] $1" >> "$log_file"
}

if [ "$#" -ne 2 ]; then
    echo "usage: $0 arg1 arg2"
    exit 1
fi

script_dir=$(dirname "$0")
cd $script_dir
log_message "moved to ${script_dir}"

ipv4=$(curl -s "http://ipv4.icanhazip.com")
log_message "ipv4: ${ipv4}"

ipv4_log="ipv4.log"

if [ ! -e "${ipv4_log}" ]; then
    touch "${ipv4_log}"
    log_message "${ipv4_log} created"
    echo "${ipv4}" > $ipv4_log
    log_message "${ipv4} stored to ${ipv4_log}"
else
    log_message "$ipv4_log found"
    read -r stored_ipv4 < $ipv4_log
    log_message "stored: ${stored_ipv4}"
fi

if [ "${ipv4}" != "${stored_ipv4}" ]; then
    log_message "ipv4 address changed"
    echo "${ipv4}" > $ipv4_log
    log_message "new ipv4 address stored"
    host="@"
    domain_name="${1}"
    ddns_password="${2}"
    your_ip="${ipv4}"
    requesthttps=$"https://dynamicdns.park-your-domain.com/update?host=${host}&domain=${domain_name}&password=${ddns_password}&ip=${ipv4}"
    resquestresult=$(curl "${requesthttps}")
else
    log_message "ipv4 address did not change"
fi