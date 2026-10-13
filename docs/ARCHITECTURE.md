# Architecture / Архитектура

## 1. Standalone PostgreSQL

```text
1C / Web / RIB clients
        |
        v
 PostgreSQL 16
        |
        +--> data directory
        +--> WAL
        +--> backup/PITR target
```

Два режима поставки:

```text
Ubuntu 24.04 native
или
Docker/Podman container
```

## 2. HA lab: Patroni + etcd

```text
                   +------------------+
clients ---------->| HAProxy/endpoint |
                   +--------+---------+
                            |
              +-------------+-------------+
              |             |             |
          Patroni-1     Patroni-2     Patroni-3
          PostgreSQL    PostgreSQL    PostgreSQL
              |             |             |
              +------ streaming repl -----+
                            |
              +-------------+-------------+
              |             |             |
            etcd-1        etcd-2        etcd-3
```

etcd хранит DCS/leader state. Данные PostgreSQL через etcd **не передаются**.

## 3. Kubernetes HA experiment

```text
StatefulSet etcd (3)
        |
StatefulSet Patroni/PostgreSQL (3)
        |
Service / optional HAProxy
        |
clients
```

Для production понадобятся нормальные StorageClass, anti-affinity, PodDisruptionBudget, backups, monitoring и проверенный способ маршрутизации только на leader.

## 4. Experimental hybrid control model

```text
Docker Compose
└── kubectl-console
    ├── CPU/RAM сильно ограничены
    ├── kubeconfig read-only
    └── применяет manifests
             |
             v
      external Kubernetes
      ├── Pod/Deployment: 1C
      ├── Pod/Deployment: Redis
      └── Pod/Deployment: Nginx
```

Это специально гибридная схема: **Docker не запускает workload'ы**, Docker даёт только маленький control-console.

## 5. 1C file database caveat

Файловая ИБ 1С должна жить на filesystem/PVC. Redis в эксперименте используется только как отдельный ephemeral service/cache/demo coordination layer. Хранить файловую ИБ прямо в Redis этот проект не предлагает.
