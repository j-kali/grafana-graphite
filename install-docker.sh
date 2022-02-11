#!/bin/bash -eu
apt_timeout=600
sudo apt-get -o DPkg::Lock::Timeout=${apt_timeout} -y update
sudo apt-get -o DPkg::Lock::Timeout=${apt_timeout} -y install ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get -o DPkg::Lock::Timeout=${apt_timeout} -y update
sudo apt-get -o DPkg::Lock::Timeout=${apt_timeout} -y install docker-ce docker-ce-cli containerd.io uidmap
sudo groupadd docker || true
sudo usermod -aG docker "${USER}"
sudo systemctl disable --now docker.service docker.socket
dockerd-rootless-setuptool.sh install -f
sudo loginctl enable-linger ubuntu
