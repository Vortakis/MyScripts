#!/bin/bash
count=0
zenity --info --text 'Your realise your Drive Contents will be erased!?'

echo "Your Google Drive Contents will be erased! Are you sure they do not contain updated dat?! Say [Yes, proceed] or [No, wait!!]"
read reply


if [ "$reply" == "Yes, proceed" ] 
then
  while [ "$reply" == "Yes, proceed" ] 
  do
    echo $count
    cd /home/nikos/Documents/Dissertation
    cp ./* /home/nikos/Documents/Dissertation\ Again/. 
    cp ./* /home/nikos/Google\ Drive/3rd\ Year/Dissertation/.
    count=$(($count+ 1))
    zenity --info --text 'Your files have been backed up!! In 10 minutes the script to back up will run again.' &
    sleep 10m
  done
elif [ "$reply" == "No, wait!!" ]
then 
  echo "Script Aborted ;)"
fi

