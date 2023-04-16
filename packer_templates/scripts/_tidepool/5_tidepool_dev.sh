#!/bin/sh -eu

TIDEPOOLDIR="$HOME/tidepool/development"
echo "==> installing tidepool development into $TIDEPOOLDIR)"

git clone https://github.com/tidepool-org/development.git $TIDEPOOLDIR

export PATH=$PATH:$TIDEPOOLDIR/bin
tidepool help

cd $TIDEPOOLDIR

echo "==> apply KUBECONFIG"
kubectl config view --flatten > $HOME/.kube/config
export KUBECONFIG="$HOME/.kube/config"

echo "==> configuring ctlptl for tidepool"
ctlptl apply -f Kindconfig.yaml

echo "==> configuring glooctl for tidepool"
glooctl install gateway -n default --values Glooconfig.yaml

echo "==> tidepool server setup"
tidepool server-init
tidepool server-start