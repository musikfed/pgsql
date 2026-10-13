# Kubernetes Patroni + etcd experiment

> Requires adaptation and testing. This is a topology sample, not a turn-key production operator.

## Build/push Patroni image

Build `cluster/docker/Dockerfile`, tag it in your registry, then replace:

```text
ghcr.io/replace-me/pgsql-patroni:16-lab
```

in `patroni.yaml`.

## Apply

```bash
kubectl apply -f namespace.yaml
kubectl apply -f etcd.yaml
kubectl apply -f patroni-config.yaml
cp patroni-secret.example.yaml patroni-secret.local.yaml
# edit passwords; do not commit the local file
kubectl apply -f patroni-secret.local.yaml
kubectl apply -f patroni.yaml
```

## Missing for production

- TLS and certificate rotation;
- leader-only service/router;
- anti-affinity and topology spread;
- PodDisruptionBudget;
- backup/PITR;
- monitoring;
- tested StorageClass;
- network policies;
- secret manager integration.
