# Настройка Prometheus и Grafana

* Добавляем репозиторий:

```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

```
helm repo update
```

* Устанавливаем прометеус:

```
helm install type-6-prom prometheus-community/prometheus
```

* Проверяем, что все ок:

```
kubectl get pods -l "app.kubernetes.io/instance=type-6-prom"
```

* Устанавливаем графану:

```
kubectl apply -f grafana.yaml
```

* Проверяем, что все ок:

```
kubectl get pods -l "app=grafana"
```