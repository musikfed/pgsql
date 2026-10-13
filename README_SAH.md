# PostgreSQL 16 Lab

**Ubuntu 24.04 LTS + PostgreSQL 16** үлэтигэр инженернай лаборатория: native туруоруу, Docker, Podman, Kubernetes, 1C:Enterprise tuning, web/API, РИБ нагрузката уонна Patroni + etcd HA эксперимент.

> **Экспериментальнай проект.** Production иннинэ compatibility, load, failover, backup/restore уонна security тесттэр наадалар.

Hybrid схемата Docker Compose кыра ресурсунан `kubectl` control container-ы эрэ ыытар; 1C, Redis уонна Nginx workload-тар тас Kubernetes cluster-га үлэлииллэр.

1C файловай база Redis иһигэр түүтүнэн ууруллубат. Redis filesystem буолбат; база PVC/filesystem-га, Redis cache/coordination үлэтигэр туттуллар.

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
