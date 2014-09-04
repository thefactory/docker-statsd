# StatsD

FROM thefactory/base
MAINTAINER Mike Babineau mike@thefactory.com

# Install NodeJS
ADD http://nodejs.org/dist/v0.10.31/node-v0.10.31-linux-x64.tar.gz /tmp/node.tgz
RUN mkdir -p /opt/node && tar xzf /tmp/node.tgz -C /opt/node --strip=1 && rm -f /tmp/node.tgz

# Install StatsD
ADD https://github.com/etsy/statsd/archive/9cf48db0fe9365f9c26ad5623c1e776d0192b601.tar.gz /tmp/statsd.tgz
RUN mkdir -p /opt/statsd && tar xzf /tmp/statsd.tgz -C /opt/statsd --strip=1 && rm -f /tmp/statsd.tgz
ADD config.js /opt/statsd/config.js

USER root
EXPOSE  8125/udp
EXPOSE  8126/tcp

ENTRYPOINT ["/opt/node/bin/node", "/opt/statsd/stats.js", "/opt/statsd/config.js"]
