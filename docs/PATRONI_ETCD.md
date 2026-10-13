# Patroni + etcd HA lab

## Topology

- 3 × etcd;
- 3 × Patroni/PostgreSQL 16;
- опционально HAProxy/connection router.

Docker lab:

```bash
cd cluster/docker
docker compose up -d --build
```

Podman lab:

```bash
cd cluster/podman
./up.sh
```

## Important

Этот кластер **экспериментальный**.

Перед production нужны:

- TLS между components;
- секреты вне compose files;
- backup/PITR;
- watchdog/fencing strategy;
- отдельные failure domains;
- минимум 3 etcd members;
- monitoring;
- тесты leader loss и network partition.

## Why etcd

Patroni использует etcd как DCS для election/leader lock/config. Репликация самих данных идёт стандартными средствами PostgreSQL streaming replication.

## Kubernetes

В `cluster/k8s` показан тот же принцип через StatefulSet. Container image Patroni надо собрать и разместить в registry. Манифесты требуют адаптации StorageClass и networking.
