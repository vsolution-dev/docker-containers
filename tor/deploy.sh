#!/bin/sh

if [ "$1" = "--clean" ]; then
  docker compose -f .docker/docker-compose.yml down --rmi all -v
else
  docker compose -f .docker/docker-compose.yml down
fi

docker compose -f .docker/docker-compose.yml up -d
