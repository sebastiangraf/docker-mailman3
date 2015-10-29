FROM ubuntu:15.10

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

# Prerequisites
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    apt-get update && apt-get install -y \
    rsyslog \
    ssl-cert \
    postfix \
    dovecot-imapd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Postfix configuration
ADD ./config/postfix.main.cf /etc/postfix/main.cf
ADD ./config/postfix.master.cf.append /etc/postfix/master-additional.cf
RUN cat /etc/postfix/master-additional.cf >> /etc/postfix/master.cf

# Dovecot configuration
COPY ./config/dovecot.mail /etc/dovecot/conf.d/10-mail.conf
COPY ./config/dovecot.ssl /etc/dovecot/conf.d/10-ssl.conf
COPY ./config/dovecot.auth /etc/dovecot/conf.d/10-auth.conf
COPY ./config/dovecot.master /etc/dovecot/conf.d/10-master.conf
COPY ./config/dovecot.lda /etc/dovecot/conf.d/15-lda.conf
COPY ./config/dovecot.imap /etc/dovecot/conf.d/20-imap.conf
# Uncomment to add verbose logging
# COPY ./config/dovecot.logging /etc/dovecot/conf.d/10-logging.conf
COPY ./config/rsyslog.conf /etc/rsyslog.conf

# Nice place for your settings
VOLUME ["/mail_settings"]

# Copy boot scripts
COPY boot /
RUN chmod 755 /boot
COPY boot.d /boot.d
RUN chmod -R 755 /boot.d

# Volume to store email
VOLUME ["/vmail"]

# Add user vmail that ownes mail
RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /vmail -m

EXPOSE 25 143 587
ENTRYPOINT /boot; service postfix start; service dovecot start; rsyslogd -n
