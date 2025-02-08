#!/usr/bin/env bash

set -euo pipefail

kubectl \
  get \
  --raw \
  /api/v1/nodes/docker-desktop/proxy/stats/summary | \
    jq \
    '.pods[] | select(.podRef.name=="kubelet-stats-test-pod") | .memory.usageBytes / 1024 / 1024'

