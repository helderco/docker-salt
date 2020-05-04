FROM debian:buster
LABEL maintainer=helder

RUN apt-get update \
 && apt-get install wget gnupg2 ca-certificates --no-install-recommends -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ARG RELEASE=latest
RUN wget -O - https://repo.saltstack.com/py3/debian/10/amd64/${RELEASE}/SALTSTACK-GPG-KEY.pub | apt-key add - \
 && echo "deb http://repo.saltstack.com/py3/debian/10/amd64/${RELEASE} buster main" >> /etc/apt/sources.list.d/saltstack.list \
 && apt-get update \
 && apt-get install -y salt-master \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 4505 4506
VOLUME /etc/salt /var/cache/salt /var/log/salt /var/run/salt
CMD ["/usr/bin/salt-master"]
