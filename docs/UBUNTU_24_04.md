# PostgreSQL 16 on Ubuntu 24.04 LTS

## Native install

```bash
sudo bash scripts/install-ubuntu2404-pg16.sh
```

Скрипт:

1. добавляет PostgreSQL PGDG repository для Ubuntu 24.04 (noble);
2. ставит PostgreSQL 16 и client;
3. включает сервис;
4. показывает версию и статус.

После установки:

```bash
sudo -u postgres psql -c "select version();"
sudo systemctl status postgresql
```

## Data and config

Типично для PGDG:

```text
/etc/postgresql/16/main/
/var/lib/postgresql/16/main/
```

Применение профиля:

```bash
sudo bash scripts/apply-profile.sh 1c
# или: web / rib
```

Скрипт кладёт snippet в `conf.d` и добавляет include_dir при необходимости.

## First database example

```sql
CREATE ROLE app LOGIN PASSWORD 'CHANGE_ME';
CREATE DATABASE app OWNER app ENCODING 'UTF8';
```

Не храните production-пароли в Git.

## Ubuntu host recommendations

- отдельный быстрый SSD/NVMe для PGDATA;
- backup на другой носитель/узел;
- swap не использовать как способ компенсировать недостаток RAM;
- синхронизировать время;
- контролировать `vm.dirty_*`, I/O latency и filesystem free space;
- перед изменением sysctl измерить baseline.

Набор параметров PostgreSQL в репозитории рассчитан как **пример для 16 GB RAM**, затем его надо адаптировать.
