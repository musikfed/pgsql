# PostgreSQL 16 tuning profiles

> Значения ниже — стартовая точка для лабораторного узла около **16 GB RAM и SSD/NVMe**. Это не универсальный production preset.

## Common

`configs/postgresql/common-16gb.conf`:

- shared_buffers = 4GB;
- effective_cache_size = 12GB;
- maintenance_work_mem = 1GB;
- checkpoint_timeout = 15min;
- max_wal_size = 8GB;
- wal_compression = on;
- random_page_cost = 1.1;
- effective_io_concurrency = 200;
- track_io_timing = on.

## 1C:Enterprise profile

Цели:

- много конкурентных транзакций;
- чувствительность к lock latency;
- активный temp/WAL workload;
- autovacuum не должен отставать.

Профиль: `configs/postgresql/1c-enterprise.conf`.

Особенности:

- `max_connections=300` — только пример; лучше считать реальные sessions;
- умеренный `work_mem`, чтобы 300 соединений не съели RAM;
- агрессивнее autovacuum;
- `log_lock_waits=on`;
- `deadlock_timeout=1s` для диагностики;
- `idle_in_transaction_session_timeout` ограничивает зависшие транзакции, но перед включением проверьте поведение конкретной 1С-конфигурации.

**Не используйте параметры, отключающие fsync/full_page_writes для ускорения.**

## Web/API profile

Профиль `web.conf`:

- меньше max_connections при наличии pooler;
- короткие statement timeouts;
- JIT выключен для большого количества коротких запросов;
- рекомендуется PgBouncer перед PostgreSQL.

## RIB / exchange profile

Профиль `rib.conf` ориентирован на bursts записи:

- увеличенный max_wal_size;
- более частый autovacuum;
- wal_compression;
- контроль replication/WAL growth;
- обязательный мониторинг диска во время больших обменов.

РИБ относится к уровню 1С, а PostgreSQL-профиль только помогает БД переживать характер нагрузки.

## Measure, do not guess

Смотрите:

```sql
select * from pg_stat_database;
select * from pg_stat_bgwriter;
select * from pg_stat_wal;
select * from pg_stat_activity;
```

Для серьёзного тюнинга добавьте pg_stat_statements и собирайте p95/p99 latency.
