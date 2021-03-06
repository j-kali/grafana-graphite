#!/bin/bash -eu
/usr/bin/docker run \
                --name "${1}" \
                -p 443:443 \
                -p 80:80 \
                -v "${TRAEFIK_DATA:-traefik-data}:/letsencrypt/" \
                -v /run/user/1000/docker.sock:/var/run/docker.sock \
                --network grafana-graphite \
                traefik:"${TRAEFIK_VERSION:-latest}" \
                --providers.docker=true \
                --entryPoints.port443.address=:443 \
                --entryPoints.port80.address=:80 \
                --certificatesResolvers.letsencrypt.acme.tlsChallenge=true \
                "--certificatesResolvers.letsencrypt.acme.email=${DOMAIN_EMAIL}" \
                --certificatesResolvers.letsencrypt.acme.storage=/letsencrypt/acme.json
