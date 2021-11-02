# Monitoring VM

Graphite + Grafana remote server

## Docker setup

We will be running docker in rootless mode. (instruction for ubuntu 20.04)

    sudo apt-get install ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo systemctl disable --now docker.service docker.socket
    dockerd-rootless-setuptool.sh install -f

## Installation

    cd
    git init
    git remote add origin git@github.com:kofeinu/monitoring-vm
    git pull origin master

Also we need to allow certain port binds for non-root users

    sudo sh -c "echo 'net.ipv4.ip_unprivileged_port_start=80' >> /etc/sysctl.conf"

Before graphite can actually be run we need to copy some base structures.
To do that run:

    docker run -d\
           --name graphite\
           --restart=always\
           graphiteapp/graphite-statsd
    docker stop graphite

Find volumes for `/opt/graphite/conf` and `/opt/graphite/storage`.
Then copy their contents to `/data/graphite/{conf,storage}`.
After that just `docker rm graphite`
