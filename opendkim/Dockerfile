FROM ubuntu:14.10

ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_GB en_GB.UTF-8 && dpkg-reconfigure locales

# Prerequisites
RUN echo "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d && \
    apt-get update && apt-get install -y opendkim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Nice place for your settings
VOLUME ["/mail_settings"]

# Configure boot script
COPY boot /
RUN chmod 755 /boot

ENV OPEN_DKIM=true

# Redirect logs for Docker to pickup
RUN ln -sf /dev/stdout /var/log/mail.log && \
  ln -sf /dev/stdout /var/log/mail.info && \
  ln -sf /dev/stdout /var/log/mail.warn && \
  ln -sf /dev/stderr /var/log/mail.err
# Make logs writable for everyone
RUN chmod 002 /var/log/mail.log \
  /var/log/mail.info \
  /var/log/mail.warn \
  /var/log/mail.err

EXPOSE 8891

ENTRYPOINT /boot; opendkim -f -p inet:8891@0.0.0.0
