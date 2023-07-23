#!/bin/bash
set -uo pipefail

# Install kubeadm, kubelet, and kubectl
# Source: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#installing-kubeadm-kubelet-and-kubectl
# With amendment: https://github.com/kubernetes/website/issues/42144

echo-success () {
  echo -e "\e[32m ✔  $1\e[0m" >&2
}

echo-information () {
  echo -e "\e[34m ⓘ  $1\e[0m" >&2
}

echo-error () {
  echo -e "\e[31m !  $1\e[0m" >&2
}

echo-warning () {
  echo -e "\e[33m ⚠  $1\e[0m" >&2
}

echo-subsidiary () {
  echo -e "\e[37m    $1\e[0m" >&2
}

echo-step () {
  echo -e "\e[0m »  $1\e[0m" >&2
}

validate-is-root() {
  if [[ $(/usr/bin/id -u) -ne 0 ]]
  then
    echo-error "Root is required"
    exit 1
  fi
}

validate-is-root

echo-information "Installing kubeadm, kubelet, and kubectl"

echo-step "Installing apt dependencies"
if ! (
  set -e
  apt-get update > /dev/null
  apt-get install --quiet --yes \
    ca-certificates \
    curl \
    gnupg
)
then
  echo-error "Failed to install apt dependencies"
  exit 1
fi

echo-step "Setup the Kubernetes repository"
if ! (
  set -e
  curl --fail --silent --show-error --location \
    --output /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
    https://dl.k8s.io/apt/doc/apt-key.gpg
  echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
)
then
  echo-error "Failed to setup the Kubernetes repository"
  exit 1
fi

echo-step "Install kubelet, kubeadm and kubectl"
if ! (
  set -e
  apt-get update > /dev/null
  apt-get install --quiet --yes \
    kubelet \
    kubeadm \
    kubectl
)
then
  echo-error "Failed to install kubelet, kubeadm and kubectl"
  exit 1
fi

# TODO: We probably need to fetch a specific version..
echo-step "Pin versions"
if ! apt-mark hold kubelet kubeadm kubectl
then
  echo-error "Failed to pin versions"
  exit 1
fi

echo-success "Installed ${COMMAND}"
echo-subsidiary "$(kubelet --version)"
echo-subsidiary "$(kubeadm --version)"
echo-subsidiary "$(kubectl --version)"
