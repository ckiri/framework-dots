#!/bin/sh
#
# Backup data to nas

sudo rsync \
    --verbose \
    --update \
    --recursive \
    --partial \
    --exclude='.rsync.log' \
    --exclude='nas' \
    --exclude='dl' \
    --exclude='templates' \
    --exclude='vm' \
    --exclude='pics' \
    --exclude='vids' \
    --exclude='proj' \
    --log-file=$HOME/.rsync.log \
    $HOME/* $HOME/nas/chris/framework-backup
