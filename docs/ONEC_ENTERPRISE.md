# PostgreSQL 16 for 1C:Enterprise / 1С:Предприятие

## Goal

Этот раздел описывает **стартовую** конфигурацию PostgreSQL 16 для клиент-серверной 1С.

Главное правило: сначала проверьте, что ваша версия платформы 1С официально совместима с PostgreSQL 16.

## Baseline

Для узла ~16 GB RAM:

```text
shared_buffers           4 GB
effective_cache_size    12 GB
maintenance_work_mem     1 GB
work_mem                16 MB
max_connections          300 (пример, не цель)
wal_compression          on
track_io_timing          on
log_lock_waits           on
```

Профили:

```text
configs/postgresql/common-16gb.conf
configs/postgresql/1c-enterprise.conf
```

## Why moderate work_mem

`work_mem` выделяется не один раз на сервер, а может выделяться на множество операций каждого соединения. При сотнях sessions слишком большое значение быстро съедает RAM.

## Locks

Для 1С особенно полезно наблюдать:

```sql
select pid, usename, state, wait_event_type, wait_event, query
from pg_stat_activity
where datname = current_database();

select * from pg_locks where not granted;
```

## Autovacuum

Не отключать. При интенсивной 1С-нагрузке лучше ускорять autovacuum и измерять bloat, чем запускать редкий тяжёлый vacuum вручную.

## Durability

Для ускорения **не отключать**:

```text
fsync
full_page_writes
```

`synchronous_commit` менять только после осознанной оценки риска потери последних подтверждённых транзакций.

## File mode vs PostgreSQL mode

Файловая ИБ 1С — отдельная модель хранения и PostgreSQL там не участвует. Для серьёзной многопользовательской нагрузки этот репозиторий ориентирован прежде всего на клиент-серверную ИБ 1С + PostgreSQL.
