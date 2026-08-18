#!/bin/sh

DEVICE="/dev/sda"
OUT="/home/user/.logs/smart"

SMART="$(smartctl -a "$DEVICE")"

health=$(printf "%s\n" "$SMART" | awk -F': ' '/SMART overall-health self-assessment test result/ {print $2}')
temp=$(printf "%s\n" "$SMART" | awk '$2=="Temperature_Celsius"{print $10}')
hours=$(printf "%s\n" "$SMART" | awk '$2=="Power_On_Hours"{print $10}')
realloc=$(printf "%s\n" "$SMART" | awk '$2=="Reallocated_Sector_Ct"{print $10}')
uncorrect=$(printf "%s\n" "$SMART" | awk '$2=="Reported_Uncorrect"{print $10}')
crc=$(printf "%s\n" "$SMART" | awk '$2=="UDMA_CRC_Error_Count"{print $10}')
selftest=$(printf "%s\n" "$SMART" | awk '/^# 1/{print $3" "$4" "$5}')

printf "%s | %s | %d°C | %dh | Realloc:%s CRC:%s\n" \
    "$(date '+%Y-%m-%d %H:%M:%S')" \
    "$health" \
    "$temp" \
    "$hours" \
    "$realloc" \
    "$crc" \
    >> "$OUT"
