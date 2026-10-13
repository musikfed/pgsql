# PostgreSQL 16 Lab

**Ubuntu 24.04 LTS дээр PostgreSQL 16** ашиглах инженерийн лаборатори: native суулгалт, Docker, Podman, Kubernetes, 1C:Enterprise tuning, web/API, RIB ачаалал, Patroni + etcd HA туршилт.

> **Experimental.** Production орчинд ашиглахаас өмнө compatibility, load, failover, backup/restore, security тест заавал хийнэ.

Hybrid хувилбарт Docker Compose зөвхөн бага нөөцтэй `kubectl` control container ажиллуулна. 1C, Redis, Nginx workload-ууд гадаад Kubernetes cluster дээр ажиллана.

1C file database-ийг Redis дотор шууд хадгалахгүй. Redis нь filesystem биш; file database PVC/filesystem дээр, Redis нь cache/coordination зориулалтаар ашиглагдана.

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
