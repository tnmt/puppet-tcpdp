#!/bin/sh
set -x

. /root/.aws_querybackup

if [ -n $1 ]; then
  /usr/local/bin/gothree $1
  if [ $? -ne 0 ]; then
     exit 1;
   fi
fi

exit 0
