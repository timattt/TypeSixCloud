# Облако для type-6

Тут лежат конфиги для поднятия облака в яндексе.

## Ссылки

* [**Grafana**](https://grafana-shlim-tech.ru/)
* [**mipt.match**](http://mipt-match.ru/)

## Инфраструктура

```mermaid
graph TD;
 subgraph "Cloud"
    type-7[<a href='https://github.com/timattt/TypeSeven'>type-7</a>];
    di{Postgres} --- type-6[<a href='https://github.com/timattt/TypeSix'>type-6</a>];
    type-7-d[<a href='https://github.com/timattt/TypeSevenD'>type-7-d</a>] --> di{Postgres};
    type-7-m[<a href='https://github.com/timattt/TypeSevenM'>type-7-m</a>] --> di{Postgres};
    type-7-m[<a href='https://github.com/timattt/TypeSevenM'>type-7-m</a>] -.-> type-6[<a href='https://github.com/timattt/TypeSix'>type-6</a>];
    type-7-m[<a href='https://github.com/timattt/TypeSevenM'>type-7-m</a>] --> type-7-d[<a href='https://github.com/timattt/TypeSevenD'>type-7-d</a>];

 end
 subgraph "Web"
   Browser --> type-7[<a href='https://github.com/timattt/TypeSeven'>type-7</a>];
   Browser -.-> type-6[<a href='https://github.com/timattt/TypeSix'>type-6</a>];
   Browser --> type-7-m[<a href='https://github.com/timattt/TypeSevenM'>type-7-m</a>];

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
