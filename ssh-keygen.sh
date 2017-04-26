#!/bin/bash

[ -n "$LIB_SSH_KEYGEN" ] && return || readonly LIB_SSH_KEYGEN=1

make_client_key(){
    filename="$1"
    ssh_keygen 0 ed25519 "$filename" "$filename"
}

make_host_key(){
    filename="$1"
    ssh_keygen 0 ed25519 "$filename" ""
}

ssh_keygen(){
    bits="$1"
    type="$2"
    keyfile="$3"
    new_passphrase="" # Disabled passphrase for now

    # Disable bits parameter for ed25519 keys
    BITS="-b $bits"
    [[ "$type" = "ed25519" ]] && BITS=

    ssh-keygen $BITS -t "$type" -f "$keyfile" -N "$new_passphrase"
}
