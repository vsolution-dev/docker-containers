FROM haproxy:latest

USER root

RUN apt-get update \
 && apt-get install -y \
    curl

COPY ./torcheck.sh /usr/local/bin/torcheck.sh
RUN chmod +x /usr/local/bin/torcheck.sh

COPY ./haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
CMD ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
