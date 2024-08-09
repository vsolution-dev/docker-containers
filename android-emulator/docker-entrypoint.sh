#!/bin/bash
set -e

echo "no" | avdmanager --verbose create avd \
  --force \
  --name nexus \
  --device "Nexus 6" \
  --package "system-images;android-${API_LEVEL};google_apis;${ARCHITECTURE}"

emulator \
  -avd nexus \
  -no-window \
  -no-audio \
  -no-boot-anim

exec "$@"
