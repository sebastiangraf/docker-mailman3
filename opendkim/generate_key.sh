#!/bin/bash
if [ -z "$1" ]
  then
    echo "Please provide a domain, for example: generate_key.sh example.com"
else
  domain="$1"
  docker run --rm adaline/dockermail-opendkim /keygen "$1" > "$1".opendkim_key
fi
