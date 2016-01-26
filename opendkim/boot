#!/bin/bash

# Remove defunct rsyslog PID, so it does not complain on restart
if [ -f /var/run/rsyslogd.pid ]; then
	rm /var/run/rsyslogd.pid
fi

# Rebuild DKIM tables from found key files
cat /dev/null > /etc/opendkim/KeyTable
cat /dev/null > /etc/opendkim/SigningTable

for KEY_FILE in /mail_settings/*.opendkim_key
do
  key_filename=`basename "$KEY_FILE"`
  echo "Adding key $key_filename"

  domain=`echo "$key_filename" | rev | cut -c 14- | rev`

  cp "$KEY_FILE" "/etc/opendkim/$key_filename"
  chown root:root "/etc/opendkim/$key_filename"
  chmod 600 "/etc/opendkim/$key_filename"

  echo "default._domainkey.$domain $domain:default:/etc/opendkim/$key_filename" >> /etc/opendkim/KeyTable
  echo "*@$domain default._domainkey.$domain" >> /etc/opendkim/SigningTable
done
