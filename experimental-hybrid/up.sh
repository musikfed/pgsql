#!/usr/bin/env bash
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"
cd "$HERE"

[ -f .env ] || { echo "Copy .env.example to .env and set KUBECONFIG"; exit 1; }

docker compose --profile tools run --rm kubectl-console apply -f /workspace/k8s/namespace.yaml
docker compose --profile tools run --rm kubectl-console apply -f /workspace/k8s/redis.yaml
docker compose --profile tools run --rm kubectl-console apply -f /workspace/k8s/onec.yaml
docker compose --profile tools run --rm kubectl-console apply -f /workspace/k8s/nginx.yaml

echo
echo "Experimental workloads submitted."
echo "Check:"
echo "  docker compose --profile tools run --rm kubectl-console -n onec-hybrid get pods,svc,pvc"
echo "Local UI test:"
echo "  docker compose --profile tools run --rm kubectl-console -n onec-hybrid port-forward svc/onec-nginx 8080:80"
