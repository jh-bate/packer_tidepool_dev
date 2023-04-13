#!/bin/sh -eu

TIDEPOOLDIR=${HOME:-/home/$SSH_USERNAME/tidepool}
echo "==> installing tidepool development into $TIDEPOOLDIR)"

git clone https://github.com/tidepool-org/development.git $TIDEPOOLDIR

export PATH=$PATH:$TIDEPOOLDIR/development/bin
tidepool help

cd $TIDEPOOLDIR/development

echo "==> apply KUBECONFIG"
# kubectl config view --flatten
export KUBECONFIG="$HOME/.kube/config"

echo "==> configuring ctlptl for tidepool"
ctlptl apply -f Kindconfig.yaml

echo "==> configuring glooctl for tidepool"
glooctl install gateway -n default --values Glooconfig.yaml

echo "==> tidepool server setup"
tidepool server-init
tidepool server-start
tidepool start