#!/bin/bash -e
# Author:       Marco Ziesing
# Email:        m.ziesing@mediacluster.de
# Date:         2012-07-10
# Usage:        iconv_dir.sh <file> <from chartset> <to charset>
# Description:
# 
# 
#
# set -x # Uncomment to debug this script
# set -n # Uncomment to check syntax without any execution
# 

ICONVBIN='/usr/bin/iconv' # path to iconv binary

scrpt=${0##*/}  # script name

# Display usage if no parameters given
if [ $# -lt 3 ]; then
  echo "Usage: $scrpt <file> <from chartset> <to charset>"
  exit 1
fi

# Text color variables
txtred='\e[0;31m'       # red
txtgrn='\e[0;32m'       # green
txtylw='\e[0;33m'       # yellow
txtblu='\e[0;34m'       # blue
txtpur='\e[0;35m'       # purple
txtcyn='\e[0;36m'       # cyan
txtwht='\e[0;37m'       # white
bldred='\e[1;31m'       # red    - Bold
bldgrn='\e[1;32m'       # green
bldylw='\e[1;33m'       # yellow
bldblu='\e[1;34m'       # blue
bldpur='\e[1;35m'       # purple
bldcyn='\e[1;36m'       # cyan
bldwht='\e[1;37m'       # white
txtund=$(tput sgr 0 1)  # Underline
txtbld=$(tput bold)     # Bold
txtrst='\e[0m'          # Text reset

# Feedback indicators
info=${bldwht}*${txtrst}
pass=${bldblu}*${txtrst}
warn=${bldred}!${txtrst}

for f in $1/*
do
  if test -f $f; then
    echo -e "${pass} Converting $f"
    /bin/mv $f $f.old
    $ICONVBIN -f $2 -t $3 $f.old > $f
  else
    echo -e "${warn} Skipping $f - not a regular file";
  fi
done
