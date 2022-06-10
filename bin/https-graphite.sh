#!/bin/bash -eu
/usr/bin/docker run \
                --name "${1}" \
                -v "${TRAEFIK_DATA:-traefik-data}:/letsencrypt/" \
                -p 6443:8081 \
                --network grafana-graphite \
                https-graphite \
                -cacert /letsencrypt/ca.crt \
                -cert /letsencrypt/acme.json \
                -hostname "${GRAFANA_DOMAIN}" \
                -target-host graphite.service
