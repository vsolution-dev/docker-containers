#!/bin/sh

docker stack rm tor
docker-compose build --no-cache

docker stack deploy -c docker-compose.yml tor
