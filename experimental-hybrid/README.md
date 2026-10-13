# Experimental Docker + Kubernetes hybrid

> **Requires further development and testing.** This repository documents the idea and runnable manifest skeleton; it is not a supported 1C distribution.

## What Docker Compose does

Only a tiny `kubectl` console exists in Compose:

```text
CPU limit: 0.25
RAM limit: 128 MiB
ports: none
kubeconfig: read-only
```

It connects to an existing Kubernetes cluster. It does **not** run Kubernetes inside Docker.

## What Kubernetes runs

```text
onec-app    -> licensed user-supplied 1C image
redis       -> ephemeral cache / demo coordination
onec-nginx  -> reverse proxy
```

The 1C workload mounts a PVC at `/srv/onec`. The init container only creates the directory `/srv/onec/filedb`; the actual 1C image must create/open a valid blank information base and publish an HTTP endpoint.

## Redis warning

The file information base is **not placed inside Redis**. Redis is not a supported filesystem for a 1C file database. If you need PostgreSQL-backed 1C, use client-server 1C + PostgreSQL instead.

## Start

```bash
cp .env.example .env
# edit KUBECONFIG
./up.sh
```

Then inspect:

```bash
docker compose --profile tools run --rm kubectl-console -n onec-hybrid get pods,svc,pvc
```

For local access to Nginx:

```bash
docker compose --profile tools run --rm kubectl-console -n onec-hybrid port-forward svc/onec-nginx 8080:80
```

The 1C pod will intentionally stay in ImagePullBackOff until the placeholder image is replaced with a licensed image you control.
