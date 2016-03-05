FROM debian:jessie
MAINTAINER Helder Correia <me@heldercorreia.com>

RUN apt-get update \
 && apt-get install curl --no-install-recommends -y \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

RUN echo "deb http://debian.saltstack.com/debian jessie-saltstack main" > /etc/apt/sources.list.d/saltstack.list \
 && curl -sLO "http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key" \
 && apt-key add debian-salt-team-joehealy.gpg.key \
 && echo "b702969447140d5553e31e9701be13ca11cc0a7ed5fe2b30acb8491567560ee62f834772b5095d735dfcecb2384a5c1a20045f52861c417f50b68dd5ff4660e6  debian-salt-team-joehealy.gpg.key" | sha512sum -c \
 && rm -f debian-salt-team-joehealy.gpg.key \
 && apt-get update \
 && apt-get install --no-install-recommends -y python salt-master salt-cloud \
 && apt-get autoremove \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

EXPOSE 4505 4506
VOLUME /etc/salt /var/cache/salt /var/log/salt /var/run/salt
CMD ["/usr/bin/salt-master"]
