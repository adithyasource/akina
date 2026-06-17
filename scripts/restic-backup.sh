#!/bin/sh

set -eu

. "$HOME/.config/restic/env"

BACKUP_PATHS="/home/akina/data/vaultwarden"

restic backup $BACKUP_PATHS

restic forget \
    --keep-daily 30 \
    --keep-weekly 12 \
    --keep-monthly 12 \
    --prune

echo "$(date '+%F %T') | OK | $BACKUP_PATHS" > /home/akina/.cache/restic-logs
