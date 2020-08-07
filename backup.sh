#!/bin/bash

# ~/.config
input="./config.conf"
while IFS= read -r line
do
  echo "$line"
  cp -R ~/.config/$line ./.config/
done < "$input"

# ~
input="./home.conf"
while IFS= read -r line
do
  echo "$line"
  cp -R ~/$line ./.home/
done < "$input"
