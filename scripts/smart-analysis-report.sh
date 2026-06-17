#!/bin/sh

{
    echo "$(date '+%F %T')"

    smartctl -a /dev/sda | awk '
    /SMART overall-health self-assessment test result:/ { health=$NF }
    /Power_On_Hours/ { hours=$10 }
    /Temperature_Celsius/ { temp=$10 }
    /SSD_Life_Left/ { life=$10 }
    /Reported_Uncorrect/ { unc=$10 }
    /SATA_CRC_Error_Count/ { crc=$10 }
    END {
        printf "SSD: %s | Life: %s%% | Temp: %s°C | Power-On: %sh | Uncorrectable: %s | CRC Errors: %s\n",
               health, life, temp, hours, unc, crc
    }'

    smartctl -l selftest /dev/sda | awk '
    /Short offline/ && /Completed without error/ && !short {
        print "Last Short Test: PASS"
        short=1
    }
    /Extended offline/ && /Completed without error/ && !long {
        print "Last Long Test: PASS"
        long=1
    }'

    echo
} >> /home/akina/.logs/smart
