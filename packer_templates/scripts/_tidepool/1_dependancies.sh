#!/bin/bash -eu

echo "==> Updating list of repositories"
sudo apt-get clean
sudo apt-get -y update

echo "==> Installing base package"
sudo apt-get install -y git gpm golang-go
