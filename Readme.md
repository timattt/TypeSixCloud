# Облако для type-6

Тут лежат конфиги для поднятия облака в яндексе.

## Инструкция по выкатыванию в облако

### Terraform

LINK HERE

### K8S

#### Получение кредов для доступа в кластер

LINK HERE

#### Накатывание прочих подов

* Secrets

LINK HERE

* Services

LINK HERE

* Grafana and prometheus

LINK HERE

* Nginx

LINK HERE

* Получение внешнего ip-адреса

```
kubectl get service -A
```

## Параметры, доступные после всей настройки

* Внешний Ip для type-6
* URL базы данных
* URL k8s
* Token k8s