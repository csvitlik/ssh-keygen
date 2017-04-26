#!/bin/bash

[ -n "$LIB_SSHD" ] && return || readonly LIB_SSHD=1

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

SSHD=/usr/sbin/sshd
SSHDPID="${DIR}/sshd.pid"
SSHDCONF="${DIR}/sshd_config"

start_sshd(){
    $SSHD -f "$SSHDCONF"
}

stop_sshd(){
    [[ -e "$SSHDPID" ]] && echo $(cat "$SSHDPID")
    rm -fv "$SSHDPID"
}
