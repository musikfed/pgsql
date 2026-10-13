# PostgreSQL 16 Lab: Ubuntu 24.04, 1C, Web, RIB, Patroni/etcd and Kubernetes

Практический лабораторный репозиторий вокруг **PostgreSQL 16** на **Ubuntu 24.04 LTS**: нативная установка, Docker, Podman, Kubernetes, профили настройки под 1С:Предприятие, веб-нагрузки, РИБ, а также экспериментальные HA-схемы Patroni + etcd.

> **Статус: experimental / lab.** Структура, конфиги и сценарии собраны как рабочая инженерная основа, но **не считаются production-ready без нагрузочных, failover, backup/restore и compatibility-тестов именно на вашей версии 1С и инфраструктуре**.

## Языки

[English](README_EN.md) · [Русский](README_RU.md) · [हिन्दी](README_HI.md) · [简体中文](README_ZH-CN.md) · [Қазақша](README_KK.md) · [Монгол](README_MN.md) · [Саха тыла](README_SAH.md) · [Беларуская](README_BE.md) · [한국어](README_KO.md)

## Что внутри

- PostgreSQL 16 на Ubuntu 24.04 **без контейнеров**;
- PostgreSQL 16 в **Docker Compose**;
- запуск тех же лабораторных схем через **Podman**;
- базовые профили тюнинга для:
  - 1С:Предприятие;
  - веб-сайтов/API;
  - РИБ/обменов с высокой интенсивностью записи;
- HA-лаборатория **3 × PostgreSQL/Patroni + 3 × etcd**;
- черновая схема переноса Patroni/etcd в Kubernetes;
- экспериментальный гибрид:
  - Docker Compose поднимает только маленький контейнер с `kubectl` — «пульт»;
  - сами workload'ы живут **в Kubernetes**, вне Docker Compose;
  - три отдельные workload-группы: 1С, Redis, Nginx.

## Важное ограничение по файловой базе 1С и Redis

**Файловую информационную базу 1С нельзя честно представить как базу, хранящуюся непосредственно в Redis.** Redis — не POSIX-файловая система и не поддерживаемое хранилище файловой ИБ 1С.

Поэтому экспериментальная схема в этом репозитории делает безопаснее и реалистичнее:

```text
1C pod
├── пустая файловая ИБ -> PVC / обычный filesystem volume
└── Redis -> временный cache / coordination / demo state

Nginx pod
└── reverse proxy к опубликованному HTTP endpoint 1C

kubectl-console (Docker Compose)
└── только управляет Kubernetes через kubeconfig
```

Если нужна серверная ИБ 1С, вместо файлового режима следует использовать PostgreSQL и штатный клиент-серверный режим 1С.

## Быстрый выбор

| Сценарий | Путь |
|---|---|
| Ubuntu 24.04 + PostgreSQL 16 | [docs/UBUNTU_24_04.md](docs/UBUNTU_24_04.md) |
| Docker | [docs/DOCKER.md](docs/DOCKER.md) |
| Настройка PostgreSQL | [docs/TUNING.md](docs/TUNING.md) |
| Patroni + etcd | [docs/PATRONI_ETCD.md](docs/PATRONI_ETCD.md) |
| Эксперимент Docker + Kubernetes | [docs/HYBRID_EXPERIMENT.md](docs/HYBRID_EXPERIMENT.md) |
| Общая архитектура | [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md) |
| Статус/ограничения | [docs/STATUS.md](docs/STATUS.md) |

## Структура

```text
configs/postgresql/       tuning profiles
docker/postgres16/        single-node PostgreSQL 16
cluster/docker/           Patroni + etcd lab
cluster/podman/           Podman launch path
cluster/k8s/              Kubernetes HA experiment
experimental-hybrid/      Docker kubectl console + K8s workloads
scripts/                  install/apply helpers
docs/                     architecture and runbooks
```

## Совместимость с 1С

Версия PostgreSQL сама по себе не гарантирует поддержку конкретной версией платформы 1С. **Перед production-внедрением проверьте официальную матрицу совместимости вашей версии 1С:Предприятия с PostgreSQL 16 и используемыми расширениями.**

## Контакты

- Email: [feudor.lab@yandex.ru](mailto:feudor.lab@yandex.ru)
- Telegram: [@Feudorlab1](https://t.me/Feudorlab1)
