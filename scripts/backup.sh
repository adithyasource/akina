#!/bin/sh

set -eu

. "/home/user/.restic.env"

BACKUP_PATHS="/home/user/data/vaultwarden /home/user/data/paperless"

docker exec paperless document_exporter /usr/src/paperless/export

if restic backup $BACKUP_PATHS &&
   restic forget --keep-last 10 --prune
then
    echo "$(date '+%F %T') | OK | $BACKUP_PATHS" >> /home/user/.logs/restic
else
    echo "$(date '+%F %T') | FAIL | $BACKUP_PATHS" >> /home/user/.logs/restic
    exit 1
fi
