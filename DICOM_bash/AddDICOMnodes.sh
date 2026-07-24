#!/bin/bash
#Installed Weasis requaired

targ_dir="/opt/weasis/lib/app/resources"

sudo cp dicomCallingNodes.xml ${targ_dir}/dicomCallingNodes.xml
sudo cp dicomNodes.xml ${targ_dir}/dicomNodes.xml

pkill -f weasis
sleep 3
/opt/weasis/bin/Weasis &> /dev/null &