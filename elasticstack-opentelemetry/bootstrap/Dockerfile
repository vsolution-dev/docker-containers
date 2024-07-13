FROM alpine:latest

RUN apk add --no-cache \
    curl \
    bash

COPY . .
RUN chmod +x *.sh

ENTRYPOINT ["./docker-entrypoint.sh"]
