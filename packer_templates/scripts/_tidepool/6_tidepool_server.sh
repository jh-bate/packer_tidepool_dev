#!/bin/sh -eu

TIDEPOOLDIR="$HOME/tidepool/development"

echo "==> apply KUBECONFIG"
kubectl config view --flatten >${HOME}/.kube/config
export KUBECONFIG=${HOME}/.kube/config

cd ${TIDEPOOLDIR}

echo "==> configuring ctlptl for tidepool"
ctlptl apply -f Kindconfig.yaml

echo "==> configuring glooctl for tidepool"
glooctl install gateway -n default --values Glooconfig.yaml

echo "==> tidepool server setup"
tidepool server-init
tidepool server-start
