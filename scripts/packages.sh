#!/usr/bin/env bash

export APTARGS="-qq -o=Dpkg::Use-Pty=0"
export DEBIAN_FRONTEND=noninteractive

sudo DEBIAN_FRONTEND=noninteractive apt-get clean ${APTARGS}
sudo DEBIAN_FRONTEND=noninteractive apt-get update ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y ${APTARGS} cloud-utils ctop htop git vim curl wget tar software-properties-common htop unattended-upgrades gpg-agent apt-transport-https ca-certificates thin-provisioning-tools net-tools 

sudo unattended-upgrades -v

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
sudo echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo DEBIAN_FRONTEND=noninteractive apt-get -y update ${APTARGS}

sudo DEBIAN_FRONTEND=noninteractive apt-get -y install docker-ce=5:20.10.7~3-0~ubuntu-focal docker-ce-cli=5:20.10.7~3-0~ubuntu-focal containerd.io awscli ${APTARGS}
# sudo DEBIAN_FRONTEND=noninteractive apt-get -y install containerd.io awscli ${APTARGS}

sudo wget https://dl.minio.io/server/minio/release/linux-amd64/minio -O /home/ubuntu/minio
sudo chmod +x /home/ubuntu/minio
sudo wget https://dl.min.io/client/mc/release/linux-amd64/mc -O /home/ubuntu/mc
sudo chmod +x /home/ubuntu/mc

sudo mv /home/ubuntu/minio /usr/local/bin
sudo mv /home/ubuntu/mc /usr/local/bin
sudo useradd -r minio-user -s /sbin/nologin
sudo chown minio-user:minio-user /usr/local/bin/minio
sudo chown -R minio-user: /usr/local/share/minio
sudo mkdir /usr/local/share/minio
sudo mkdir /etc/minio
sudo chown minio-user:minio-user /etc/minio

sudo wget https://raw.githubusercontent.com/minio/minio-service/master/linux-systemd/minio.service -O /home/ubuntu/minio.service
sudo mv /home/ubuntu/minio.service /etc/systemd/system
