#!/bin/bash

date=$(date +%s)
while read -r replace with; do
  plist+="{on=1;replace=\"$replace\";with=\"$with\";},"
  sql+="INSERT INTO 'ZUSERDICTIONARYENTRY' VALUES($((++i)),1,1,0,0,0,0,$date,NULL,NULL,NULL,NULL,NULL,\"$with\",\"$replace\",NULL);"
done < <(sed 's/\\/\\\\/g;s/"/\\"/g' emojis.txt)
sqlite3 ~/Library/Dictionaries/CoreDataUbiquitySupport/$USER~*/UserDictionary/local/store/UserDictionary.db "delete from ZUSERDICTIONARYENTRY;$sql"
defaults write -g NSUserDictionaryReplacementItems "(${plist%?})"