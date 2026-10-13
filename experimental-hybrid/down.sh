#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

docker compose --profile tools run --rm kubectl-console delete -f /workspace/k8s/nginx.yaml --ignore-not-found
docker compose --profile tools run --rm kubectl-console delete -f /workspace/k8s/onec.yaml --ignore-not-found
docker compose --profile tools run --rm kubectl-console delete -f /workspace/k8s/redis.yaml --ignore-not-found
docker compose --profile tools run --rm kubectl-console delete -f /workspace/k8s/namespace.yaml --ignore-not-found
