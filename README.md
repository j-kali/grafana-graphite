# Monitoring VM

Graphite + Grafana remote server

## Podman setup

Installation from the package should be enough.

    apt-get install curl wget gnupg2 -y
    source /etc/os-release
    sh -c "echo 'deb http://download.opensuse.org/repositories/devel:/kubic:/libcontainers:/stable/xUbuntu_${VERSION_ID}/ /' > /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list"
    wget -nv https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_${VERSION_ID}/Release.key -O- | apt-key add -
    apt-get update -qq -y
    apt-get -qq --yes install podman

## Installation

    cd
    git init
    git remote add origin git@github.com:kofeinu/monitoring-vm
    git pull origin master

Also we need to allow certain port binds for non-root users

    sudo sh -c "echo 'net.ipv4.ip_unprivileged_port_start=80' >> /etc/sysctl.conf"

Before graphite can actually be run we need to copy some base structures.
To do that run:

    podman run -d\
           --name graphite\
           --restart=always\
           graphiteapp/graphite-statsd
    podman stop graphite

Find volumes for `/opt/graphite/conf` and `/opt/graphite/storage`.
Then copy their contents to `/data/graphite/{conf,storage}`.
After that just `podman rm graphite`
