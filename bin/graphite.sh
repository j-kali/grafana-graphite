#!/bin/bash -eu
/usr/bin/docker run \
                --name "${1}" \
                --restart=always \
                -v /data/graphite/conf:/opt/graphite/conf \
                -v /data/graphite/storage:/opt/graphite/storage \
                -p 8080:80 \
                -p 2003-2004:2003-2004 \
                -p 2023-2024:2023-2024 \
                -p 8125:8125/udp \
                -p 8126:8126 \
                --network grafana-graphite \
                graphiteapp/graphite-statsd:"${GRAPHITE_VERSION:-latest}"
