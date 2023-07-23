#!/bin/bash
set -euo pipefail

# Install kubeadm, kubelet, and kubectl
# Source: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
# With amendment: https://github.com/kubernetes/website/issues/42144

echo "➡️  Install apt dependencies"
sudo apt-get update
sudo apt-get install --quiet --yes \
  ca-certificates \
  curl \
  gnupg

echo "➡️  Download the public signing key"
sudo curl --fail --silent --show-error --location \
  --output /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
  https://dl.k8s.io/apt/doc/apt-key.gpg 

echo "➡️  Add the Kubernetes apt repository"
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

echo "➡️  Install kubelet, kubeadm and kubectl, and pin their version"
sudo apt-get update
sudo apt-get install --yes \
  kubelet \
  kubeadm \
  kubectl

# TODO: We probably need to fetch a specific version..
sudo apt-mark hold kubelet kubeadm kubectl
