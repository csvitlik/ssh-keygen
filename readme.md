# ssh-keygen

I once read somewhere that it would be a good idea to have software
that periodically generates, adds, uses, then discards various types of
SSH keys.

This is an implementation of that software.

# Use

    $ bash main.sh >/dev/null 2>&1 &

It will generate a new SSH key once a second,
DSA 1024, ECDSA 384, ED25519, RSA 1024 and RSA 2048.
