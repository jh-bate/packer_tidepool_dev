#!/bin/sh -eu

KUBE_VERSION=v1.21.12

echo "==> Installing kubectl $KUBE_VERSION"
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /etc/apt/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

HELM_VERSION=v3.9.1

echo "==> Installing helm $HELM_VERSION"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
DESIRED_VERSION=$HELM_VERSION ./get_helm.sh
helm version

CTLPTL_VERSION="0.8.18"
curl -fsSL https://github.com/tilt-dev/ctlptl/releases/download/v$CTLPTL_VERSION/ctlptl.$CTLPTL_VERSION.linux.x86_64.tar.gz | sudo tar -xzv -C /usr/local/bin ctlptl

TILT_VERSION=0.30.5

echo "==> Installing tilt $TILT_VERSION"
curl -fsSL https://github.com/tilt-dev/tilt/releases/download/v$TILT_VERSION/tilt.$TILT_VERSION.x86_64.tar.gz | tar -xzv tilt && sudo mv tilt /usr/local/bin/tilt

echo "==> Installing gloo"

curl -sL https://run.solo.io/gloo/install | sh
export PATH=$HOME/.gloo/bin:$PATH
glooctl version

echo "==> Installing netcat"

sudo apt-get -y install netcat

echo "==> Installing kind"

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
