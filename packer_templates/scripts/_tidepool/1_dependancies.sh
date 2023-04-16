#!/bin/bash -eu

echo "==> Updating list of repositories"
apt-get clean
apt-get -y update

echo "==> Installing base package"
apt-get install -y git vim gpm golang-go

