#!/bin/bash
set -e

for INSTANCE in $(seq 0 $((INSTANCES-1))); do
    cat > /etc/tor/torrc-${INSTANCE} << EOF
DataDirectory /var/lib/tor-${INSTANCE}
SocksPort 0.0.0.0:$((9050 + INSTANCE))
HTTPTunnelPort 0.0.0.0:$((8050 + INSTANCE))

CircuitBuildTimeout 5

StrictNodes 1

NewCircuitPeriod 300
MaxCircuitDirtiness 300

StrictNodes 1
ExitNodes ${EXIT_NODES}

EOF
done

exec "$@"
