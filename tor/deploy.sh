#!/bin/sh

docker compose down --rmi all -v
docker compose up -d
