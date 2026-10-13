# PostgreSQL 16 for web sites and APIs

Профиль `configs/postgresql/web.conf` рассчитан на большое число коротких запросов.

## Recommended pattern

```text
Nginx / API
    |
PgBouncer
    |
PostgreSQL 16
```

PgBouncer снижает цену большого количества короткоживущих подключений.

## Watch

- p95/p99 query latency;
- pool saturation;
- `pg_stat_statements`;
- cache hit ratio;
- locks;
- temp files;
- checkpoint spikes;
- slow queries.

## Indexing

Не увеличивайте память вместо исправления плохих запросов. Начинайте с execution plans и индексов:

```sql
EXPLAIN (ANALYZE, BUFFERS) SELECT ...;
```

## JIT

Для множества коротких OLTP-запросов JIT часто не окупает startup cost, поэтому web profile отключает его как стартовую гипотезу. Проверяйте на своей нагрузке.
