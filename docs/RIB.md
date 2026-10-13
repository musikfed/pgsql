# RIB / РИБ and heavy exchange workloads

РИБ — механизм уровня 1С. PostgreSQL не управляет логикой обмена, но испытывает burst-нагрузку при чтении/записи больших пакетов.

## PostgreSQL focus

Профиль `configs/postgresql/rib.conf`:

- увеличивает предел WAL между checkpoints;
- включает WAL compression;
- ускоряет autovacuum;
- делает checkpoint более плавным;
- усиливает диагностическое логирование.

## Operational checks

Перед большим обменом:

```sql
select pg_size_pretty(pg_wal_lsn_diff(pg_current_wal_lsn(),'0/0'));
select datname, xact_commit, xact_rollback, temp_bytes
from pg_stat_database;
```

Во время/после обмена следить за:

- free disk;
- WAL growth;
- long transactions;
- blocked sessions;
- replica lag;
- autovacuum backlog.

## Important

Если обмены стабильно создают проблемы, надо анализировать не только PostgreSQL, но и расписание РИБ, размер пакетов, конфигурацию 1С и конкуренцию с интерактивными пользователями.
