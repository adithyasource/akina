#!/bin/sh

set -eu

smartctl -t long /dev/sda

echo "$(date '+%F %T') | OK | smart test initiated" >> /home/akina/.logs/smart
