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

* Добавляем еще репозиторий:

```
helm repo add tricksterproxy https://helm.tricksterproxy.io
```

```
helm repo update
```

* Устанавливаем трикстер прокси:

```
helm install trickster tricksterproxy/trickster --namespace default -f trickster.yaml
```

* Проверяем, что все ок:

```
kubectl get pods -l "app=trickster"
```

* Устанавливаем графану:

```
kubectl apply -f grafana.yaml
```

* Проверяем, что все ок:

```
kubectl get pods -l "app=grafana"
```