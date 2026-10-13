# PostgreSQL 16 Lab

面向 **Ubuntu 24.04 LTS + PostgreSQL 16** 的工程实验仓库：原生安装、Docker、Podman、Kubernetes、1C:Enterprise 调优、Web/API、RIB/交换负载，以及 Patroni + etcd 高可用实验。

> **实验性质。** 在生产环境使用前必须完成兼容性、压力、故障切换、备份恢复和安全测试。

## 架构方向

```text
原生 / Docker / Podman PostgreSQL 16
              |
        Patroni + etcd
              |
       Kubernetes 实验
```

混合实验中，Docker Compose 只运行一个资源受限的 `kubectl` 控制容器；1C、Redis、Nginx 实际运行在外部 Kubernetes 集群中。

1C 文件数据库不会直接存入 Redis。Redis 不是文件系统，文件数据库应位于 PVC/普通文件系统，Redis 仅作为缓存或协调服务。

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
