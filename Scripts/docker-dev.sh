#!/bin/bash

uuid=c9a6b450-d5c0-4e7f-8b3c-83a05b678cf0

sudo fsck -a UUID="$uuid" && \
    sudo mount -m /dev/sdb3 /mnt/docker && \
    sudo systemctl start docker
