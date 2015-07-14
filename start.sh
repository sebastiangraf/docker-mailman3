docker stop dockermail_core
docker rm dockermail_core

docker stop dockermail_opendkim
docker rm dockermail_opendkim

docker run -d -v /opt/dockermail/settings:/mail_settings --name dockermail_opendkim dockermail_opendkim
docker run -d \
  -v /opt/dockermail/settings:/mail_settings \
  -v /opt/dockermail/vmail:/vmail \
  -p 25:25 \
  -p 143:143 \
  -p 587:587 \
  --link dockermail_opendkim:opendkim \
  --name dockermail_core dockermail_emailcore
