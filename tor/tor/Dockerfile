FROM alpine:latest

RUN apk update \
 && apk add --no-cache \
    tor \
    bash

RUN mkdir -p /etc/tor

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["tor", "-f", "/etc/tor/torrc"]
