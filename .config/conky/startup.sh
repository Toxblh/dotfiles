#!/bin/sh
killall conky
# sleep 5
conky -q -c ${HOME}/.config/conky/conky-clock.conf &
conky -q -c ${HOME}/.config/conky/conky.conf & exit
