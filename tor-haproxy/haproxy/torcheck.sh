#!/bin/bash

response=$(curl -s -x socks5h://$3:9050 'https://check.torproject.org/api/ip')

if ! (echo "$response" | grep -q '"IsTor":true'); then
  exit 1
fi

exit 0
