#!/bin/bash
echo "Running `basename "$0"`"

SETTINGS_LOCAL=$MAILMAN_HOME/mailman_web/settings_local.py

# Get settings from config
smtp_host=$(jq -r '.settings.myhostname' $CONFIG_FILE)
secret_key=$(jq -r '.settings | .mailman | .secret_key' "$CONFIG_FILE")
allowed_hosts=$(jq '.settings | .mailman | .domains + ["127.0.0.1"]' "$CONFIG_FILE")
browserid_audiences=$(jq '.settings | .mailman | .domains | map("https://"+., "http://"+.)' "$CONFIG_FILE")
language_code=$(jq -r '.settings | .mailman | .language_code' "$CONFIG_FILE")
time_zone=$(jq -r '.settings | .mailman | .time_zone' "$CONFIG_FILE")
admin_email=$(jq -r '.settings | .mailman | .admin_email' "$CONFIG_FILE")

cat <<EOF > $SETTINGS_LOCAL
# coding=utf-8

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': "$DB",
    }
}
EMAIL_HOST = "$smtp_host"
SECRET_KEY = "$secret_key"
MAILMAN_ARCHIVER_KEY = "$secret_key"
ALLOWED_HOSTS = $allowed_hosts
BROWSERID_AUDIENCES = $browserid_audiences
SECURE_PROXY_SSL_HEADER = ('HTTP_X_FORWARDED_PROTO', 'https')
USE_X_FORWARDED_HOST = True
USE_SSL = True
USE_INTERNAL_AUTH = True
DEFAULT_FROM_EMAIL = "$admin_email"
LANGUAGE_CODE = "$language_code"
TIME_ZONE = "$time_zone"
EOF