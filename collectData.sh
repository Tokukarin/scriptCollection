#!/bin/bash

#
# This script collects all data from my honeypots into one single json file, for further analysis and reporting of IPs.
# This file will be served over nginx to my grafana json api for graphical visualization of the data.
#

date=$(date '+%Y-%m-%d')
cat /var/log/honeypots/* >> /root/honeypotData/honeypotData_$date.json && rm /var/log/honeypots/*
