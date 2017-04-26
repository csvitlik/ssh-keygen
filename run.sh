#!/bin/bash

set -e errexit
set -o nounset

source ssh-keygen.sh
source sshd.sh

HOSTKEY=ssh_host_ed25519_key
SSHD=/usr/sbin/sshd
RANDOM_STRING=`random_string 20`

_make_host_key(){
    filename="$1"
    ssh_keygen 0 ed25519 "$filename" ""
}

_make_client_key(){
    filename="$1"
    ssh_keygen 0 ed25519 "$filename" "$filename"
}

_test_client_key(){
    filename="$1"
    echo "$filename" | ssh localhost -i "$filename" -p56666
}

_start_sshd(){
    $SSHD -f sshd_config
}

_stop_sshd(){
    kill `cat sshd.pid`
    rm -fv sshd.pid
}

_cleanup(){
    rm -fv $HOSTKEY{,.pub}
    rm -fv $RANDOM_STRING{,.pub}
}

_main(){
    _stop_sshd
    _cleanup

    _make_host_key $HOSTKEY
    _make_client_key "$RANDOM_STRING" "$RANDOM_STRING"
    _start_sshd
    _test_client_key "$RANDOM_STRING"

    _stop_sshd
    _cleanup
    return 0
}

_main
