#!/bin/bash

# Zsh
./zsh.sh

# check zsh.sh status. 0 - ok, 1 - need restart
if [[ $? -eq 1 ]]; then
    exit 0
fi

./flatpak.sh