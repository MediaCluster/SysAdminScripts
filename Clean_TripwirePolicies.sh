#!/bin/sh
 
cat ~/twtest.txt |
while read line
  do
  FILE=`echo $line | awk '{ print $2 }'`
  sed -i "/^[ \t]*${FILE}/ s/^/#/" ~/twpol.txt
done
