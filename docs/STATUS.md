# Status / Статус

Этот репозиторий — **инженерная лаборатория**, а не готовый SLA-продукт.

## Что можно считать основой

- структура развёртывания;
- PostgreSQL 16 на Ubuntu 24.04;
- пример Docker Compose для одиночного PostgreSQL;
- профили postgresql.conf;
- HA-топология Patroni + etcd;
- Kubernetes/Podman заготовки;
- гибридная модель Docker Compose + Kubernetes control console.

## Что обязательно тестировать перед production

1. Совместимость конкретной версии 1С с PostgreSQL 16.
2. Нагрузку 1С на реальных объёмах и количестве пользователей.
3. Блокировки, autovacuum, checkpoint/WAL pressure.
4. Backup + restore, включая PITR.
5. Patroni failover и split-brain scenarios.
6. Потерю одного/двух etcd members.
7. PersistentVolume, fencing и topology в Kubernetes.
8. Публикацию 1С через выбранный web stack.
9. Лицензирование 1С и легальность используемых container images.

Идея и структура практически применимы, но текущие манифесты требуют доработки и стендовых испытаний.
