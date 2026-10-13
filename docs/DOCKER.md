# PostgreSQL 16 in Docker / Podman

## Docker Compose

```bash
cd docker/postgres16
cp .env.example .env
docker compose up -d
docker compose ps
```

По умолчанию используется официальный образ `postgres:16-bookworm`.

## Podman

Тот же одиночный пример можно запускать:

```bash
cd docker/postgres16
podman compose up -d
```

Если локальный provider команды `podman compose` отсутствует, установите подходящий compose provider для вашей ОС.

## Storage

Данные вынесены в named volume. Для реального сервера предпочтительно явно решить:

- host path vs named volume;
- backup path;
- WAL/PITR storage;
- SELinux labels при Podman;
- ownership UID/GID.

## Profile

Compose монтирует пример `configs/postgresql/common-16gb.conf`. Для сценария 1С/Web/РИБ подключайте соответствующий snippet дополнительно или собирайте собственный профиль.
