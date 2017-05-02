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

# for each conf file
while IFS='' read -r permFilePath || [[ -n "$permFilePath" ]]; do
  echo $permFilePath
  # for each permission
  while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$line"
    # validate Path
    PP=$(echo $line | awk '{ print $1 }')
    RP1=${PP:0:1}
    RP2=${PP:1:1}
    if [[ "$RP1" = "." ]] && [[ ! "$RP2" =~ [a-zA-Z0-9_-] ]]
    then
      # echo "$RP""WWWORKK"
      dirPath=$(dirname "$permFilePath")
      PP=$(echo "$PP" | sed  -n -e 's,^\.,,p')
      PP="$dirPath""$PP"
    fi
    # echo "$PP"
    
    # validate permission
  done < "$filePath"
done <<< "$CL"



