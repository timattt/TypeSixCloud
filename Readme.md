# Облако для type-6

Тут лежат конфиги для поднятия облака в яндексе.

## Ссылки

* [**Grafana**](https://grafana.shlimtech.org)
* [**Pattern**](http://pattern.shlimtech.org)
* [**SSO**](https://service.shlimtech.org/sso/pages/login)
* [**Rutesil**](https://rutesil.shlimtech.org/)

## Инфраструктура

```mermaid
graph TD;
 subgraph "Cloud"
    di{Postgres} --- type-6;
    type-8 --- type-6;
    type-6 --- rabbit;
    type-10 --- rabbit;
    type-9;
 end
 subgraph "Local"
    type-2;
 end
 subgraph "Web"
   Browser -.-> type-6;
   type-10 -.-> SMTP;
   Browser -.-> type-8;
   Browser -.-> type-2;
   Browser -.-> type-9;
 end

```

### Список активных репозиториев

* [**Type-2**](https://github.com/timattt/TypeTwo)
* [**Type-6**](https://github.com/timattt/TypeSix)
* [**Type-6-BL**](https://github.com/timattt/TypeSixBusinessLogic)
* [**Type-8**](https://github.com/timattt/TypeEight)
* [**Type-9**](https://github.com/timattt/TypeNine)
* [**Type-10**](https://github.com/timattt/typeten)

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
