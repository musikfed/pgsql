# PostgreSQL 16 Lab

Інжынерная лабараторыя для **PostgreSQL 16 на Ubuntu 24.04 LTS**: натыўная ўстаноўка, Docker, Podman, Kubernetes, налады для 1C:Enterprise, web/API, РІБ і эксперыментальны HA-кластар Patroni + etcd.

> **Эксперыментальны статус.** Перад production патрэбныя тэсты сумяшчальнасці, нагрузкі, failover, backup/restore і бяспекі.

У гібрыднай схеме Docker Compose запускае толькі маленькі `kubectl`-кантэйнер, а 1C, Redis і Nginx працуюць у знешнім Kubernetes.

Файлавая база 1C не захоўваецца непасрэдна ў Redis. Redis не з'яўляецца файлавай сістэмай; база знаходзіцца на PVC/filesystem, а Redis выкарыстоўваецца для cache/coordination.

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
