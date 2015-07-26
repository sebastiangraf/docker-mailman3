FROM ubuntu:14.10

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

# Prerequisites
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    apt-get update && apt-get install -y \
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

COPY ./config/05-node_id /etc/amavis/conf.d/05-node_id
COPY ./config/15-content_filter_mode /etc/amavis/conf.d/15-content_filter_mode
COPY ./config/50-user /etc/amavis/conf.d/50-user

# Nice place for your settings
VOLUME ["/mail_settings"]

# Configure boot script
COPY boot /
RUN chmod 755 /boot

ENV AMAVIS=true

# Redirect logs for Docker to pickup
RUN ln -sf /dev/stdout /var/log/razor-agent.log
RUN ln -sf /dev/stdout /var/log/mail.log
RUN ln -sf /dev/stdout /var/log/mail.info
RUN ln -sf /dev/stdout /var/log/mail.warn
RUN ln -sf /dev/stderr /var/log/mail.err

EXPOSE 10024

ENTRYPOINT ./boot; amavisd-new foreground
