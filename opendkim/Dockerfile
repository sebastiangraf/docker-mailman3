FROM ubuntu:14.10

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

# Prerequisites
RUN apt-get update && apt-get install -y \
    opendkim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Nice place for your settings
VOLUME ["/mail_settings"]

# Configure boot script
COPY boot /
RUN chmod 755 /boot

ENV OPEN_DKIM true
ENV OPEN_DKIM_PORT_8891_ADDR inet:8891

EXPOSE 8891
ENTRYPOINT ./boot; service rsyslog start; opendkim -f -p $OPEN_DKIM_PORT_8891_ADDR
