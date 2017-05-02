#!/bin/bash

if [[ -z "$1" ]]
then
  echo "missing folder path... exiting..."
  exit 1
elif [[ ! -d "$1" ]]
then
  echo "not a directory... exiting..."
  exit 1
fi

if [[ ! -z "$2" ]] && [[ "$2" = "force" ]]
then
  FORCE=1
  for III in {3..1}; do
    echo "will change permissions in ""$III"" second(s)"
    sleep 1
  done
  
else
  FORCE=0
  echo "dry-run..."
fi

# Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPT=$(readlink -f "$0")
# Absolute path this script is in, thus /home/user/bin
SCRIPTPATH=$(dirname "$SCRIPT")

DD=$(readlink -f "$1")
CL=$(find "$DD" -maxdepth 3 -type f -name ".permconf")

while IFS='' read -r filePath || [[ -n "$filePath" ]]; do
  echo $filePath
  while IFS='' read -r line || [[ -n "$line" ]]; do
    echo " - ""$line"
    PP=$(echo $line | awk '{ print $1 }')
    RP=${PP:0:1}
    if [[ "$RP" = "." ]]
    then
      echo "$RP""WWWORKK"
      dirPath=$(dirname "$filePath")
      PP=$(echo "$PP" | sed  -n -e 's,^\.,,p')
      PP="$dirPath""$PP"
    fi
    
    # number=${filename:offset:length}
  done < "$filePath"
done <<< "$CL"



