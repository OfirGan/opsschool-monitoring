locals {
  install-monitor-server = <<END_TEXT
#!/bin/bash

#
# Install Docker
#
mkdir -p /home/ubuntu/opsschool
sudo chown -R ubuntu:ubuntu /home/ubuntu/opsschool

sudo apt-get update -y
sudo apt install docker.io -y
sudo apt install docker-compose -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ubuntu
sudo chmod 666 /var/run/docker.sock


# This script downloads and installs node_exporter of the requested version on a host.
# node_exporter is set up as a systemd service, which requiers a daemon-reload.
# BLAME: DamDam (Adam Bihari)

node_exporter_ver="0.18.0"

wget \
  https://github.com/prometheus/node_exporter/releases/download/v$node_exporter_ver/node_exporter-$node_exporter_ver.linux-amd64.tar.gz \
  -O /tmp/node_exporter-$node_exporter_ver.linux-amd64.tar.gz

tar zxvf /tmp/node_exporter-$node_exporter_ver.linux-amd64.tar.gz

sudo cp ./node_exporter-$node_exporter_ver.linux-amd64/node_exporter /usr/local/bin

sudo useradd --no-create-home --shell /bin/false node_exporter

sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

sudo mkdir -p /var/lib/node_exporter/textfile_collector
sudo chown node_exporter:node_exporter /var/lib/node_exporter
sudo chown node_exporter:node_exporter /var/lib/node_exporter/textfile_collector

sudo tee /etc/systemd/system/node_exporter.service &>/dev/null << EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
Group=node_exporter
Type=simple
ExecStart=/usr/local/bin/node_exporter --collector.textfile.directory /var/lib/node_exporter/textfile_collector \
 --no-collector.infiniband

[Install]
WantedBy=multi-user.target
EOF

rm -rf /tmp/node_exporter-$node_exporter_ver.linux-amd64.tar.gz \
  ./node_exporter-$node_exporter_ver.linux-amd64

sudo systemctl daemon-reload

sudo systemctl start node_exporter

systemctl status --no-pager node_exporter

sudo systemctl enable node_exporter

END_TEXT
}
