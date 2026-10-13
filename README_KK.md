# PostgreSQL 16 Lab

**Ubuntu 24.04 LTS + PostgreSQL 16** үшін инженерлік зертхана: native орнату, Docker, Podman, Kubernetes, 1C:Enterprise тюнингі, web/API, РИБ жүктемелері және Patroni + etcd HA эксперименті.

> **Эксперименттік жоба.** Production алдында compatibility, load, failover, backup/restore және security тесттері міндетті.

Гибридтік нұсқада Docker Compose тек ресурсы шектеулі `kubectl` басқару контейнерін іске қосады, ал 1C, Redis және Nginx workload-тары сыртқы Kubernetes ішінде жұмыс істейді.

1C файлдық базасы Redis ішінде тікелей сақталмайды. Redis filesystem емес; база PVC/filesystem ішінде, Redis cache/coordination үшін қолданылады.

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
