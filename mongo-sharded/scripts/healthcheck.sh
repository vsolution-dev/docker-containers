#!/bin/bash

echo $(mongosh --quiet --eval "
try {
  rs.status().ok
} catch {
  rs.initiate({
    _id: '$REPLICA_ID',
    configsvr: $REPLICA_CONFIG,
    members: $(echo $REPLICA_MEMBERS | jq -R 'split(",") | to_entries | map({ _id: .key, host: .value })')
  }).ok
}
")
