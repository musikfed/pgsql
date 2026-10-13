# Backup / restore baseline

HA не заменяет backup.

Минимум для production-проекта:

1. регулярный base backup;
2. архивирование WAL;
3. хранение копий вне PostgreSQL node;
4. периодическая проверка restore;
5. отдельная политика retention;
6. документированный RPO/RTO.

Для небольших баз допустим `pg_dump`, для больших и HA обычно нужен физический backup/PITR toolchain.

Пример logical backup:

```bash
pg_dump -Fc -h localhost -U app app > app.dump
pg_restore --clean --if-exists -d app app.dump
```

Пароли не помещать в скрипты и Git.
