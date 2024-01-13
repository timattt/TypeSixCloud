# Облако для type-6

Тут лежат конфиги для поднятия облака в яндексе.

## Инфраструктура

```mermaid
graph TD;
 subgraph Type-6-cloud
    type-6 --> type-6-d;
    type-7 ---> type-6;
    type-7 -.-> type-6;
    di{Postgres} --- type-6;
    type-6-d --> di{Postgres};
 end
 subgraph Web
   Browser -.-> type-7
 end
click type-6 "https://github.com/timattt/TypeSix"
```

## Инструкция по выкатыванию в облако

* [Terraform](https://github.com/timattt/TypeSixCloud/tree/master/terraform)
* K8S
  * [Получение кредов для доступа в кластер](https://github.com/timattt/TypeSixCloud/tree/master/k8s/clusterCredentials)
  * Накатывание прочих подов
    * [Секреты](https://github.com/timattt/TypeSixCloud/tree/master/k8s/secrets)
    * [Сервисы](https://github.com/timattt/TypeSixCloud/tree/master/k8s/services)
    * [Grafana и Prometheus](https://github.com/timattt/TypeSixCloud/tree/master/k8s/grafanaAndPrometheus)
    * [Nginx](https://github.com/timattt/TypeSixCloud/tree/master/k8s/nginx)
