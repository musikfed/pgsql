# Experimental hybrid: Docker control console + Kubernetes workloads

> **Это концептуально рабочая лабораторная схема, но она требует доработки и тестирования. Не production-ready.**

## Idea

Docker Compose поднимает **только один маленький контейнер**:

```text
kubectl-console
CPU: 0.25
RAM: 128 MiB
kubeconfig: read-only
```

Он не является Kubernetes master и не создаёт кластер. Он лишь подключается к **уже существующему Kubernetes API**.

Снаружи Docker Compose, в Kubernetes, создаются:

1. **1C pod/deployment**
   - ваш лицензированный Linux image 1С;
   - пустая файловая ИБ создаётся на PVC;
   - image в репозитории не распространяется;
2. **Redis pod/deployment**
   - cache/demo coordination;
   - **не хранит файловую ИБ 1С**;
3. **Nginx pod/deployment**
   - reverse proxy к HTTP endpoint опубликованной 1С.

## Flow

```text
docker compose up kubectl-console
        |
        v
kubectl apply -f k8s/
        |
        v
Kubernetes
├── onec-app
├── redis
└── nginx
```

## Start

```bash
cd experimental-hybrid
cp .env.example .env
./up.sh
```

Перед запуском укажите image с законно установленной 1С и проверьте `KUBECONFIG`.

## About Nginx and 1C publication

Nginx в этой схеме — внешний reverse proxy. Внутри 1C image должен существовать корректно настроенный и поддерживаемый HTTP endpoint публикации. Сам Nginx не заменяет механизм публикации платформы 1С.
