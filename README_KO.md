# PostgreSQL 16 Lab

**Ubuntu 24.04 LTS의 PostgreSQL 16**을 위한 엔지니어링 실험 저장소입니다. Native 설치, Docker, Podman, Kubernetes, 1C:Enterprise 튜닝, Web/API, RIB/교환 부하, Patroni + etcd HA 실험을 포함합니다.

> **실험 단계입니다.** Production 사용 전 호환성, 부하, failover, backup/restore, 보안 테스트가 필요합니다.

Hybrid 구조에서는 Docker Compose가 리소스 제한된 `kubectl` 제어 컨테이너만 실행하고, 실제 1C/Redis/Nginx workload는 외부 Kubernetes cluster에서 실행됩니다.

1C 파일 데이터베이스는 Redis에 직접 저장하지 않습니다. Redis는 filesystem이 아니므로 파일 DB는 PVC/filesystem에 두고 Redis는 cache/coordination 용도로만 사용합니다.

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
