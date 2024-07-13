#!/bin/bash
set -e

envsubst < .env.template > .env

git pull

composer install \
  --no-interaction \
  --no-plugins \
  --no-scripts \
  --no-dev \
  --prefer-dist

php artisan migrate \
  --force

exec "$@"
