#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

required=(
  README.md
  docs/ARCHITECTURE.md
  docs/UBUNTU_24_04.md
  docs/TUNING.md
  docker/postgres16/docker-compose.yml
  cluster/docker/docker-compose.yml
  cluster/k8s/etcd.yaml
  cluster/k8s/patroni.yaml
  experimental-hybrid/docker-compose.yml
  experimental-hybrid/k8s/onec.yaml
)

for f in "${required[@]}"; do
  [ -f "$ROOT/$f" ] || { echo "MISSING: $f"; exit 1; }
done

bash -n "$ROOT/scripts/install-ubuntu2404-pg16.sh"
bash -n "$ROOT/scripts/apply-profile.sh"
bash -n "$ROOT/scripts/validate.sh"
bash -n "$ROOT/cluster/podman/up.sh"
bash -n "$ROOT/cluster/podman/down.sh"
bash -n "$ROOT/experimental-hybrid/up.sh"
bash -n "$ROOT/experimental-hybrid/down.sh"

if command -v docker >/dev/null 2>&1; then
  (cd "$ROOT/docker/postgres16" && cp -n .env.example .env.validate >/dev/null 2>&1 || true)
  echo "Docker found; compose runtime validation is intentionally not started."
fi

echo "Static repository checks passed."
