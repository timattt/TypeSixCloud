# Облако для type-6

Тут лежат конфиги для поднятия облака в яндексе.

## Сервисы

* K8S кластер с 1 узлом
* Postgres

## Инструкция по выкатыванию в облако

### Terraform

* Подключаемся к облаку с помощью команды:

```
yc init
```

* Получаем токен для авторизации в terraform

```
yc iam create-token
```

* Устанавливаем terraform
* Подкладываем файл .terraformmrc в ~/.terraformrc
* Инициализируемся 

```
terraform init
```

* Запускаем конфигурацию

```
terraform apply -state="../state/state.json"
```

Здесь необходимо указать имя и пароль для пользователя из БД, идентификатор облака и папки - это все можно посмотреть на сайте облака. И токен,
который сгенерировали до этого. Данные для БД должны совпадать с тем, что используется в других микросервисах.

#### Альтернативный вариант авторизации вместо токена

Можно на сайте облака в панели сервисного акаунта сгенерировать **авторизированный** ключ и потом подложить его в папку скриптов.

### K8S

#### Получение кредов для доступа в кластер

* Устанавливаем конфигурацию k8s

```
yc managed-kubernetes cluster get-credentials type-6-k8s --external
```

* Проверяем, что все ок

```
kubectl config view
```

* Поднимаем сервисный аккаунт для k8s. В папке k8s выполняем:

```
kubectl apply -f sa.yaml
```

* Получаем токен авторизации:
  (Windows)

```
$SECRET = kubectl -n kube-system get secret -o json | `
  ConvertFrom-Json | `
  Select-Object -ExpandProperty items | `
  Where-Object { $_.metadata.name -like "*admin-user*" }
```

```
$SA_TOKEN = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($SECRET.data.token))
```

```
echo $SA_TOKEN
```

* Узнаем адрес кластера.

```
yc managed-kubernetes cluster list
```

Отсюда берем параметр external endpoint.

* Теперь у нас есть креды, для доступа в кластер.

#### Накатывание прочих подов

* Load balancer for type-6
Здесь не забываем указать ip адреса, которые должны использовать балансеры

```
kubectl apply -f type-6-load-balancer.yaml
```

* Load balancer for type-7 
Здесь не забываем указать ip адреса, которые должны использовать балансеры

```
kubectl apply -f type-7-load-balancer.yaml
```

* Secrets storage

Важно! В репозитории есть только шаблон этого файла. Его нужно заполнить секретами.

```
kubectl create secret generic type-6-basic-secrets `
--from-literal=type_6_github_client_id=? `
--from-literal=type_6_github_client_secret=? `
--from-literal=type_6_yandex_client_id=? `
--from-literal=type_6_yandex_client_secret=? `
--from-literal=type_6_database_url=? `
--from-literal=type_6_database_password=? `
--from-literal=type_6_client_id=? `
--from-literal=type_6_client_secret=? `
```

```
kubectl create secret generic type-6-basic-secret-files `
    --from-file=./ssl/type-6/type-6-certificate `
    --from-file=./ssl/type-6/type-6-key
```

```
kubectl create secret generic type-7-basic-secret-files `
    --from-file=./ssl/type-7/type-7-certificate `
    --from-file=./ssl/type-7/type-7-key
```

* Получение внешнего ip-адреса

```
kubectl get service -A
```

## Параметры, доступные после всей настройки

* Внешний Ip для type-6
* URL базы данных
* URL k8s
* Token k8s