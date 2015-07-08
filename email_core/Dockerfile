FROM ubuntu:14.10

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

# Prerequisites
RUN apt-get update && apt-get install -y \
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
ADD ./config/dovecot.mail /etc/dovecot/conf.d/10-mail.conf
ADD ./config/dovecot.ssl /etc/dovecot/conf.d/10-ssl.conf
ADD ./config/dovecot.auth /etc/dovecot/conf.d/10-auth.conf
ADD ./config/dovecot.master /etc/dovecot/conf.d/10-master.conf
ADD ./config/dovecot.lda /etc/dovecot/conf.d/15-lda.conf
ADD ./config/dovecot.imap /etc/dovecot/conf.d/20-imap.conf
# Uncomment to add verbose logging
# ADD ./config/dovecot.logging /etc/dovecot/conf.d/10-logging.conf

# Nice place for your settings
VOLUME ["/mail_settings"]

# Configure boot script
COPY boot /
RUN chmod 755 /boot

# Volume to store email
VOLUME ["/vmail"]
# Add user vmail that ownes mail
RUN groupadd -g 5000 vmail
RUN useradd -g vmail -u 5000 vmail -d /vmail -m

EXPOSE 25 143 587
ENTRYPOINT /boot; service rsyslog start; service postfix start; dovecot -F
