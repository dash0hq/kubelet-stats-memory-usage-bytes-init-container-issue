#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"

pushd init-container > /dev/null
docker build . -t kubelet-stat-test-init-container-image
popd > /dev/null

test_yaml=${1:-}
if [[ -z "$test_yaml" ]]; then
  echo "Missing mandatory parameter: either provide pod-without-issue.yaml or pod-with-issue.yaml"
  exit 1
fi

target_namespace=${2:-kubelet-stats-test}

# delete resources from previous test runs.
kubectl delete pod -n "${target_namespace}" kubelet-stats-test-pod --force --grace-period=0 --ignore-not-found --wait=true || true
# kubectl delete ns "${target_namespace}" --ignore-not-found --wait=true

# create/deploy resources
if ! kubectl get ns "$target_namespace" &> /dev/null; then
  kubectl create ns "$target_namespace"
fi
echo deploying "$test_yaml"...
kubectl apply -n "${target_namespace}" -f "$test_yaml"
echo ... "$test_yaml" has been deployed

