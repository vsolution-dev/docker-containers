#!/bin/bash
set -e

/usr/local/bin/docker-entrypoint.sh "$@" &

until mongosh --eval 'db.runCommand("ping").ok' --quiet
do
  sleep 1
done

mongosh <<EOF
use admin

db.createUser({
  user: '$MONGO_USERNAME',
  pwd: '$MONGO_PASSWORD',
  roles: [{
    role: 'readWrite',
    db: '$MONGO_DATABASE'
  }]
})

for (const shard of '$MONGO_SHARDS'.split(',')) {
  sh.addShard(shard.trim())
}

sh.enableSharding('$MONGO_DATABASE')
EOF

tail -f /dev/null
