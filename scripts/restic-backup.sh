#!/bin/sh

set -eu

. "/home/akina/.config/restic/env"

BACKUP_PATHS="/home/akina/data/vaultwarden"

if restic backup "$BACKUP_PATHS" &&
   restic forget \
      --keep-daily 30 \
      --keep-weekly 12 \
      --keep-monthly 12 \
      --prune
then
    echo "$(date '+%F %T') | OK | $BACKUP_PATHS" >> /home/akina/.logs/restic
else
    echo "$(date '+%F %T') | FAIL | $BACKUP_PATHS" >> /home/akina/.logs/restic
    exit 1
fi
