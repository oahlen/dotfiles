#!/usr/bin/env bash

RESULT=$(printf "Poweroff\nSuspend\nReboot" | fuzzel -d)

if [ -n "$RESULT" ]
then
    systemctl "${RESULT,,}"
fi
