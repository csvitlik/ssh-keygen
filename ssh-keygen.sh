#!/bin/bash

[ -n "$LIB_SSH_KEYGEN" ] && return || readonly LIB_SSH_KEYGEN=1

make_client_key(){
    filename="$1"
    ssh_keygen 0 ed25519 "$filename-ed25519" "$filename"
    ssh_keygen 1024 dsa "$filename-dsa1024" "$filename"
    ssh_keygen 1024 rsa "$filename-rsa1024" "$filename"
    ssh_keygen 2048 rsa "$filename-rsa2048" "$filename"
    ssh_keygen 384 ecdsa "$filename-ecdsa384" "$filename"
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
