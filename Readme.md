# Облако для type-6

Тут лежат конфиги для поднятия облака в яндексе.

## Инфраструктура

```mermaid
graph TD;
 subgraph "Cloud"
    type-6[<a href='https://github.com/timattt/TypeSix'>type-6</a>] --> type-6-d[<a href='https://github.com/timattt/TypeSixD'>type-6-d</a>];
    type-7[<a href='https://github.com/timattt/TypeSeven'>type-7</a>];
    di{Postgres} --- type-6[<a href='https://github.com/timattt/TypeSix'>type-6</a>];
    type-6-d[<a href='https://github.com/timattt/TypeSixD'>type-6-d</a>] --> di{Postgres};
 end
 subgraph "Web"
   Browser -.-> type-7
   Browser -.-> type-6
 end
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
