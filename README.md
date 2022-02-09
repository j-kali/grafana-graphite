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

Or just:

    ./install-docker.sh

## Installation

    cd
    git init
    git remote add origin git@github.com:kofeinu/monitoring-vm
    git pull origin master
    systemctl --user daemon-reload

Also we need to allow certain port binds for non-root users

    sudo sysctl net.ipv4.ip_unprivileged_port_start=80
    sudo sh -c "echo 'net.ipv4.ip_unprivileged_port_start=80' >> /etc/sysctl.conf"

Before graphite can actually be run we need storage locations in `/data/graphite/{conf,storage}`

For proper `HTTPS` setup you need to define `GRAFANA_DOMAIN` and `DOMAIN_EMAIL`, e.g.,:

    echo "GRAFANA_DOMAIN=$(curl ifconfig.io 2> /dev/null) | rev | cut -d " " -f 1 | tail -c +2 | rev" > ${HOME}/.config/environment.d/GRAFANA_DOMAIN.conf
    echo "DOMAIN_EMAIL=cute.kitten@playing.ball" > ${HOME}/.config/environment.d/DOMAIN_EMAIL.conf
    systemctl --user daemon-reload
