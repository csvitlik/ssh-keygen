#!/bin/bash

[ -n "$LIB_SSHD" ] && return || readonly LIB_SSHD=1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SSHD=/usr/sbin/sshd
SSHDPID="${DIR}/sshd.pid"
SSHDCONF="${DIR}/sshd_config"

start_sshd(){
    $SSHD -f "$SSHDCONF" -D -d > sshd.log 2>&1 &
}

stop_sshd(){
    if [ -e "$SSHDPID" ]
    then
        echo SSH PID: $(cat "$SSHDPID")
        kill -9 $(cat "$SSHDPID")
        rm -fv "$SSHDPID"
    fi
}
