#!/bin/bash -eu
/usr/bin/docker run \
                --name "${1}" \
                --hostname "$(hostname)" \
                -v /data:/data \
                -v /:/mnt/root \
                -v "${HOME}/telegraf.conf":/etc/telegraf/telegraf.conf \
                --network grafana-graphite \
                telegraf:"${TELEGRAF_VERSION:-latest}"
