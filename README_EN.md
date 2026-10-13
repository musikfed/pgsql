# PostgreSQL 16 Lab

Engineering lab for **PostgreSQL 16 on Ubuntu 24.04 LTS** with native installation, Docker, Podman, Kubernetes, 1C:Enterprise tuning, web/API workloads, RIB/exchange workloads, and experimental Patroni + etcd HA.

> **Experimental.** The repository is intended as a practical architecture and deployment baseline. It still requires compatibility, load, failover, backup/restore, and security testing before production use.

## Main tracks

- native PostgreSQL 16 on Ubuntu 24.04;
- single-node Docker/Podman;
- tuning profiles for 1C, web/API and RIB;
- 3-node Patroni/PostgreSQL + 3-node etcd lab;
- Kubernetes version of the HA idea;
- hybrid experiment where Docker Compose runs only a resource-limited `kubectl` console while workloads run in an external Kubernetes cluster.

## Experimental hybrid

```text
Docker Compose
└── kubectl-console (0.25 CPU / 128 MiB)
        |
        v
external Kubernetes
├── 1C workload + PVC
├── Redis workload
└── Nginx workload
```

A 1C file information base is **not stored directly in Redis**. Redis is not a filesystem and is used only for cache/coordination in this experiment. The file base lives on a PVC/filesystem. A licensed 1C image must be supplied by the user.

## Docs

- [Ubuntu 24.04](docs/UBUNTU_24_04.md)
- [Tuning](docs/TUNING.md)
- [1C](docs/ONEC_ENTERPRISE.md)
- [Web/API](docs/WEB_WORKLOAD.md)
- [RIB](docs/RIB.md)
- [Patroni + etcd](docs/PATRONI_ETCD.md)
- [Hybrid experiment](docs/HYBRID_EXPERIMENT.md)
- [Backup/restore](docs/BACKUP_RESTORE.md)

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
