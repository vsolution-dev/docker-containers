#!/bin/bash
set -e

cat > /etc/tor/torrc << EOF
SocksPort 0.0.0.0:9050
HTTPTunnelPort 0.0.0.0:8050

CircuitBuildTimeout 5

StrictNodes 1

ExitNodes ${EXIT_NODES}

NewCircuitPeriod 300
MaxCircuitDirtiness 300
EOF

exec "$@"
