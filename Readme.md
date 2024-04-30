# Облако для type-6

Тут лежат конфиги для поднятия облака в яндексе.

## Ссылки

* [**Grafana**](https://grafana.shlimtech.org)
* [**Pattern**](http://pattern.shlimtech.org)
* [**SSO**](https://service.shlimtech.org/sso/pages/login)

## Инфраструктура

```mermaid
graph TD;
 subgraph "Cloud"
    di{Postgres} --- type-6;
    type-8 --- type-6;
    type-6 --- rabbit;
    type-10 --- rabbit;

 end
 subgraph "Web"
   Browser -.-> type-6;
type-10 -.-> SMTP;
   Browser -.-> type-8;
   
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
    * [Логирование](https://github.com/timattt/TypeSixCloud/tree/master/k8s/logging)
