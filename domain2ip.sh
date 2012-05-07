#!/bin/bash -e
#
# Prints out a html document with given domains and their associated ip address
# 

if test $# -ne 1; then
  echo "Usage: domain2ip.sh <file>"
  exit 1
fi

file=$1
name=$(basename "$file")

echo "<table><thead><tr><th>Domain</th><th>IP address</th></tr></thead>"

while read line
do
    ip=`dig "$line" +short`
    echo -e "<tr><td>$line</td><td>$ip</td></tr>"
done < $file

echo "</table>"

