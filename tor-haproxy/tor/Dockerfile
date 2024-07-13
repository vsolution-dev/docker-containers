FROM alpine:latest

RUN apk update \
 && apk add --no-cache \
    tor

COPY torrc /etc/tor/

EXPOSE 9050
CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
