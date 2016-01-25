#!/bin/bash

export CONFIG_FILE=/mail_settings/config.json

if [ -f "$CONFIG_FILE" ]; then
  # Run boot scripts
  for SCRIPT in ./boot.d/*
  do
    if [ -f "$SCRIPT" -a -x "$SCRIPT" ]; then
      "$SCRIPT"
    fi
  done
else
  echo "Cant find config JSON, giving up."
fi
