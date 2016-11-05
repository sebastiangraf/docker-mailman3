#!/bin/bash

export CONFIG_FILE=/mail_settings/config.json
export IP=`ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'`
export DB=$MAILMAN_HOME/var/mailman-web/mailman-web.sqlite

# Remove stale lock file, so Mailman does not complain on restart
if [ -f $MAILMAN_HOME/var/locks/master.lck ]; then
    rm $MAILMAN_HOME/var/locks/master.lck
fi

if [ -f "$CONFIG_FILE" ]; then
  # Run boot scripts
  for SCRIPT in /boot.d/*
  do
    if [ -f "$SCRIPT" -a -x "$SCRIPT" ]; then
      "$SCRIPT"
    fi
  done
else
  echo "Cant find config JSON, giving up."
fi
