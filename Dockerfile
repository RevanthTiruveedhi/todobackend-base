FROM ubuntu:18.04
MAINTAINER Rev

ENV TERM=xterm-256color

RUN sed -i "s/http:\/\/archive./http:\/\/nz.archive./g" /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y \
    -o APT::Install-Recommend=false -o APT::Install-Suggests=false \
    python3 python-virtualenv python-mysqldb

RUN virtualenv /appenv && \
    . /appenv/bin/activate && \
    apt install python3-pip -y && \
    pip3 install --upgrade pip

ADD scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

LABEL application=todobackend