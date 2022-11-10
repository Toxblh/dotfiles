#!/bin/sh
killall conky

sleep 3

# conky -q -c ${HOME}/.config/conky/conky-clock.conf &
conky -q -c ${HOME}/.config/conky/conky.conf & exit
