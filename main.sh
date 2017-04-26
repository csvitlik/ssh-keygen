#!/bin/bash

# https://coderwall.com/p/it3b-q/bash-include-guard
[ -n "$LIB_MAIN" ] && return || readonly LIB_MAIN=1

# https://stackoverflow.com/a/246128
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "${DIR}/sshd.sh"
source "${DIR}/ssh-keygen.sh"
source "${DIR}/util.sh"

HOSTKEY="${DIR}/ssh_host_ed25519_key"

trap cleanup EXIT

cleanup(){
    stop_sshd
    remove_hostkey
    remove_clientkey
}

remove_hostkey(){
    rm -fv "$HOSTKEY" "${HOSTKEY}.pub"
}

remove_clientkey(){
    filename="$1"
    rm -fv "$filename" "${filename}.pub"
}

test_client_key(){
    filename="$1"
    echo "$filename" | ssh localhost -i "$filename" -p56666 -tt echo 'hello!'
}

main(){
    stop_sshd
    cleanup
    make_host_key "$HOSTKEY"
    start_sshd

    while true
    do
        # Random hex string.
        RANDOM_STRING="$(random_string 20)"

        make_client_key "$RANDOM_STRING" "$RANDOM_STRING"

        test_client_key "$RANDOM_STRING"

        remove_clientkey "$RANDOM_STRING"
        sleep 1
    done

    stop_sshd
    cleanup

    return 0
}

main
