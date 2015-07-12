FROM ubuntu:14.10

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

# Prerequisites
RUN apt-get update && apt-get install -y \
    amavisd-new \
    spamassassin \
    libnet-dns-perl \
    libmail-spf-perl \
    pyzor \
    razor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up razor and pyzor
RUN su - amavis -s /bin/bash && razor-admin -create && razor-admin -register && pyzor discover

COPY ./config/amavis-content_filter_mode /etc/amavis/conf.d/15-content_filter_mode

# Nice place for your settings
VOLUME ["/mail_settings"]

# Configure boot script
COPY boot /
RUN chmod 755 /boot

ENV AMAVIS=true

ENTRYPOINT ./boot; service rsyslog start; amavisd foreground
