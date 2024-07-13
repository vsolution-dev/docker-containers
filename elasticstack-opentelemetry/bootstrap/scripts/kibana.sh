#!/bin/bash

function wait_for_kibana {
  until curl -s -I ${KIBANA_HOST} | grep -q 'HTTP/1.1 302 Found'; do
    echo "Waiting for Kibana to start..."
    sleep 1
  done
  echo "Kibana is up and running"
}

function import_saved_objects {
  local filename=$1

  if [[ ! -f "${filename}" ]]; then
    echo "File ${filename} does not exist. Skipping import of saved objects."
    return
  fi

  local response=$(curl -s \
    -X POST \
    -H "kbn-xsrf: true" \
    -u "elastic:${ELASTIC_PASSWORD}" \
    "${KIBANA_HOST}/api/saved_objects/_import" \
    --form file=@"${filename}")

  echo "Importing saved objects from ${filename}: ${response}"
}
