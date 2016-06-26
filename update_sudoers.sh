#!/bin/bash

LINE="www ALL=(ALL) NOPASSWD:/usr/bin/yum"
FILE="/etc/sudoers.d/cloud-init"

UPDATED=`grep "$LINE" $FILE | wc -l`
if [ $UPDATED = 0 ]; then
  sudo sh -c "echo '$LINE' >> $FILE"
  echo "Updated"
else
  echo "Already updated"
fi

