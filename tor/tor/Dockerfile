FROM alpine:latest

RUN apk update \
 && apk add --no-cache \
    tor \
    supervisor \
    bash

COPY supervisord.conf /etc/supervisord.conf

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
