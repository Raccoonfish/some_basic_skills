#!/bin/bash
#Installed Weasis requaired

targ_dir="/opt/weasis/lib/app/resources"

sudo cp dicomCallingNodes.xml ${targ_dir}/dicomCallingNodes.xml
sudo cp dicomNodes.xml ${targ_dir}/dicomNodes.xml


#I added this part out of pure interest to see if I could simulate closing and opening a program from the GUI using the terminal
#better not to use it 
pkill -f weasis
sleep 3
/opt/weasis/bin/Weasis &> /dev/null &