FROM ubuntu:14.04
# does not work with 16.04 because of newer python version

MAINTAINER Bastian Lemke

ENV DEBIAN_FRONTEND noninteractive

# Enable backports repository - needed for jq 1.4
RUN echo "deb http://archive.ubuntu.com/ubuntu trusty-backports main restricted universe multiverse" >> \
    /etc/apt/sources.list

# Prerequisites
RUN apt-get update && \
    apt-get install -y \
    git \
    python3-dev \
    python3-pip \
    python-dev \
    python-pip \
    python-virtualenv \
    ruby-sass \
    nodejs \
    postfix \
    jq/trusty-backports \
    expect \
    rsyslog \
    npm && \
    npm install -g less && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./config/rsyslog.conf /etc/rsyslog.conf

# Install mailman bundler
RUN git clone https://gitlab.com/mailman/mailman-bundler.git mailman

WORKDIR /mailman
RUN virtualenv venv
RUN . venv/bin/activate
RUN pip install zc.buildout
RUN buildout

# Downgrade to compatible falcon version - see https://gitlab.com/mailman/postorius/issues/122
RUN . venv-3.4/bin/activate && pip install --upgrade falcon==0.3

# Configure boot scripts
COPY boot /
COPY boot.d /boot.d
RUN chmod 755 /boot /boot.d/*

ENV MAILMAN=true
ENV MAILMAN_HOME=/mailman

EXPOSE 80 8024
VOLUME /mailman/var
VOLUME /mailman/deployment
VOLUME /mail_settings

CMD /boot; rsyslogd -n
