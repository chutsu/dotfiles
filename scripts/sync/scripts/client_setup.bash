#!/bin/bash
set -e  # exit on first error
RSYNC_CMD='rsync -auvzr --delete'
CRONTAB_TIMING="* * * * *"


setup_rsync_crontab() {
    echo -n 'enter path to sync with server: '
    read SOURCE

    echo -n 'enter username and server to server (e.g. root@192.168.0.1): '
    read SERVER

    echo "sync path: $SOURCE"
    echo "sync server: $SERVER"

    read -r -p "continue? (y/n): " choice
    case "$choice" in
        n|N) ;;
        y|Y)
            CRONTAB_CMD="${CRONTAB_TIMING} ${RSYNC_CMD} ${SOURCE} ${SERVER}:"
            crontab -l | {
                cat; echo "$CRONTAB_CMD";
            } | crontab -
            ;;
        *) echo 'invalid input! exiting...';;
    esac
}

setup_rsync_crontab
