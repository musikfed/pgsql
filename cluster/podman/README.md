# Podman Patroni/etcd lab

Схема намеренно использует тот же compose definition, что и Docker, чтобы не поддерживать две расходящиеся HA-конфигурации.

```bash
cd cluster/podman
cp ../docker/.env.example ../docker/.env
./up.sh
```

Нужны Podman и compose provider. Rootless mode рекомендуется для лаборатории, но volume permissions/SELinux labels надо проверять на вашей системе.

Остановка:

```bash
./down.sh
```

> Experimental. Failover/backup/TLS не считаются проверенными.
