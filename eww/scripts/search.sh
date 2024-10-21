#!/bin/sh

#echo "hola" >> /home/rosu/.config/eww/scripts/search-text.txt

list=$(ls /usr/bin/ | grep -m 10 -i "$1")
buf=""
for l in $list ; do
  buf="$buf (button :onclick \"$l &\" \"$l\")"
done
echo "(box :orientation \"h\" :spacing 5 :halign \"center\" :valign \"center\" $buf)" > /home/rosu/.config/eww/scripts/search-text.txt