#!/bin/bash
set -e

function wait_for_elasticsearch {
  until curl -s "${ELASTICSEARCH_HOST}" | grep -q "missing authentication credentials"; do
    echo "Waiting for Elasticsearch to start..."
    sleep 1
  done
  echo "Elasticsearch is up and running"
}

function change_password {
	local username=$1
	local password=$2

  local response=$(curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    -u "elastic:${ELASTIC_PASSWORD}" \
    "${ELASTICSEARCH_HOST}/_security/user/${username}/_password" \
    -d "{\"password\":\"${password}\"}")

  echo "Changing password for user ${username}: ${response}"
}

wait_for_elasticsearch

change_password "kibana_system" "${KIBANA_PASSWORD}"
