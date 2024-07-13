#!/bin/bash
set -e

source ./kibana.sh
source ./elasticsearch.sh

wait_for_elasticsearch

# kibana_system 사용자 비밀번호 변경

change_password "kibana_system" "${KIBANA_PASSWORD}"

# anonymous 사용자 권한 및 생성

create_role "anonymous" '{
  "cluster": [],
  "indices": [{
    "names": ["*"],
    "privileges": ["read"]
  }],
  "applications": [{
    "application": "kibana-.kibana",
    "privileges": ["feature_visualize.all","feature_dashboard.read","feature_dashboard.url_create"],
    "resources": ["*"]
  }]
}'

create_user "${ANONYMOUS_USERNAME}" "${ANONYMOUS_PASSWORD}" "anonymous"

# Saved objects 가져오기

wait_for_kibana

import_saved_objects "/usr/share/kibana/saved_objects.ndjson"
