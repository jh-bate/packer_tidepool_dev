#!/bin/sh -eu

KUBE_VERSION=v1.21.12

echo "==> Installing kubectl $KUBE_VERSION"
cd /tmp
curl -LO "https://storage.googleapis.com/kubernetes-release/release/${KUBE_VERSION}/bin/linux/amd64/kubectl"
chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl
kubectl version --client

HELM_VERSION=v3.9.1

echo "==> Installing helm $HELM_VERSION"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
DESIRED_VERSION=$HELM_VERSION ./get_helm.sh
helm version

TILT_VERSION=0.30.5

echo "==> Installing tilt $TILT_VERSION"

curl -fsSL https://github.com/windmilleng/tilt/releases/download/v${TILT_VERSION}/tilt.${TILT_VERSION}.linux.x86_64.tar.gz
tar -xzv tilt
mv tilt /usr/local/bin/tilt
tilt version

CTLPTL_VERSION="0.8.18"

echo "==> Installing ctlptl $CTLPTL_VERSION"

curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v${CTLPTL_VERSION}/ctlptl.${CTLPTL_VERSION}.linux.x86_64.tar.gz
tar -xzv -C /usr/local/bin ctlptl

# ctlptl config
# ctlptl apply -f Kindconfig.yaml

echo "==> Installing gloo"

curl -sL https://run.solo.io/gloo/install | sh
export PATH=$HOME/.gloo/bin:$PATH
glooctl version

# TODO apply 
# glooctl install gateway -n default --values Glooconfig.yaml

echo "==> Installing netcat"

sudo apt-get -y install netcat

echo "==> Installing kind"

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
mv ./kind /usr/local/bin/kind
