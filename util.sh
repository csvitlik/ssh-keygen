#!/bin/bash

[ -n "$LIB_UTIL" ] && return || readonly LIB_UTIL=1

source "${DIR}/ssh-keygen.sh"

random_string(){
    length="$1"
    # Not sure where I found this one.
    echo "$(dd if=/dev/random bs=$length count=1 | xxd -ps -c $length)"
}
