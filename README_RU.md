# PostgreSQL 16 Lab

Инженерная лаборатория для **PostgreSQL 16 на Ubuntu 24.04 LTS**: нативная установка, Docker, Podman, Kubernetes, тюнинг под 1С:Предприятие, сайты/API, РИБ и экспериментальный HA-кластер Patroni + etcd.

> **Статус: экспериментальный.** В рамках идеи структура рабочая, но перед production нужны реальные тесты совместимости, нагрузки, failover, backup/restore и безопасности.

## Основные сценарии

- PostgreSQL 16 напрямую на Ubuntu 24.04;
- одиночный PostgreSQL в Docker и Podman;
- профили 1С / web / РИБ;
- 3 PostgreSQL/Patroni + 3 etcd;
- экспериментальная Kubernetes-схема;
- гибрид: Docker Compose содержит только маленький `kubectl`-контейнер, а 1С, Redis и Nginx запускаются pod'ами в Kubernetes.

## Гибридная схема

```text
Docker Compose
└── kubectl-console (0.25 CPU / 128 MiB)
        |
        v
внешний Kubernetes
├── 1С + PVC с файловой ИБ
├── Redis
└── Nginx
```

Файловая ИБ 1С **не помещается в Redis**: Redis не является файловой системой. В эксперименте Redis используется как cache/coordination service, а файловая база находится на PVC. Образ 1С пользователь должен предоставить самостоятельно и легально.

## Документация

- [Ubuntu 24.04](docs/UBUNTU_24_04.md)
- [Тюнинг](docs/TUNING.md)
- [1С](docs/ONEC_ENTERPRISE.md)
- [Web/API](docs/WEB_WORKLOAD.md)
- [РИБ](docs/RIB.md)
- [Patroni + etcd](docs/PATRONI_ETCD.md)
- [Гибридный эксперимент](docs/HYBRID_EXPERIMENT.md)
- [Backup/restore](docs/BACKUP_RESTORE.md)

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
