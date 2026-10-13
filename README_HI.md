# PostgreSQL 16 Lab

**Ubuntu 24.04 LTS पर PostgreSQL 16** के लिए इंजीनियरिंग लैब: native installation, Docker, Podman, Kubernetes, 1C:Enterprise tuning, web/API workloads, RIB/exchange workloads और Patroni + etcd HA प्रयोग।

> यह **experimental** प्रोजेक्ट है। Production से पहले compatibility, load, failover, backup/restore और security testing आवश्यक है।

## Architecture

```text
Native / Docker / Podman PostgreSQL 16
             |
      Patroni + etcd HA
             |
      Kubernetes experiment
```

Hybrid प्रयोग में Docker Compose केवल कम-resource वाला `kubectl` console चलाता है; 1C, Redis और Nginx workloads बाहरी Kubernetes cluster में चलते हैं।

1C file database सीधे Redis में नहीं रखी जाती। Redis filesystem नहीं है; file database PVC/filesystem पर रहती है और Redis केवल cache/coordination के लिए है।

## Contact / Контакты

- Email: feudor.lab@yandex.ru
- Telegram: @Feudorlab1
