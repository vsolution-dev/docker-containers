#!/bin/bash

function wait_for_elasticsearch {
  until curl -s "${ELASTICSEARCH_HOST}" | grep -q "missing authentication credentials"; do
    echo "Waiting for Elasticsearch to start..."
    sleep 1
  done
  echo "Elasticsearch is up and running"
}

function create_user {
	local username=$1
	local password=$2
	local role=$3

  local response=$(curl -s \
    -X POST \
    -H "Content-Type: application/json" \
    -u "elastic:${ELASTIC_PASSWORD}" \
    "${ELASTICSEARCH_HOST}/_security/user/${username}" \
    -d "{\"password\":\"${password}\",\"roles\":[\"${role}\"]}")

  echo "Creating user ${username} (${role}): ${response}"
}

function create_role {
  local role=$1
  local privileges=$2

  local response=$(curl -s \
    -X PUT \
    -H "Content-Type: application/json" \
    -u "elastic:${ELASTIC_PASSWORD}" \
    "${ELASTICSEARCH_HOST}/_security/role/${role}" \
    -d "${privileges}")

  echo "Creating role ${role}: ${response}"
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
