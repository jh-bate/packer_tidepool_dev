#!/bin/sh -eux
export DEBIAN_FRONTEND=noninteractive

echo "disable release-upgrades"
sudo sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades;

echo "disable systemd apt timers/services"
sudo systemctl stop apt-daily.timer;
sudo systemctl stop apt-daily-upgrade.timer;
sudo systemctl disable apt-daily.timer;
sudo systemctl disable apt-daily-upgrade.timer;
sudo systemctl mask apt-daily.service;
sudo systemctl mask apt-daily-upgrade.service;
sudo systemctl daemon-reload;

echo "remove the unattended-upgrades and ubuntu-release-upgrader-core packages"
sudo rm -rf /var/log/unattended-upgrades;
sudo apt-get -y purge unattended-upgrades ubuntu-release-upgrader-core;

echo "update the package list"
sudo apt-get -y update;

echo "upgrade all installed packages incl. kernel and kernel headers"
sudo apt-get -y dist-upgrade -o Dpkg::Options::="--force-confnew";

sudo reboot
