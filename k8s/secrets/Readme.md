# Шаблоны команд для секретов

```
kubectl create secret generic type-6-basic-secrets `
--from-literal=type_6_github_client_id= `
--from-literal=type_6_github_client_secret= `
--from-literal=type_6_yandex_client_id= `
--from-literal=type_6_yandex_client_secret= `
--from-literal=type_6_database_jdbc_url="" `
--from-literal=type_6_database_password= `
--from-literal=type_6_client_id= `
--from-literal=type_6_client_secret= `
--from-literal=type_6_database_url= `
--from-literal=type_6_database_port= `
--from-literal=type_8_client_id= `
--from-literal=type_8_client_secret= `
--from-literal=type_12_client_id= `
--from-literal=type_12_client_secret= `
--from-literal=type_6_redis_password= `
--from-literal=type_6_redis_hostname=
```

```
kubectl create secret generic type-6-basic-secret-files `
    --from-file=./ssl/type-6/type-6-certificate `
    --from-file=./ssl/type-6/type-6-key `
    --from-file=./ssl/type-6-web/private_key.der `
    --from-file=./ssl/type-6-web/public_key.der
```

```
kubectl create secret generic type-10-mail-creds `
--from-literal=username=??? `
--from-literal=password=??? `
```

## Как создавать секреты для sll в фронте (не в проде сейчас)

```
kubectl create secret generic type-7-basic-secret-files `
    --from-file=./ssl/type-7/type-7-certificate `
    --from-file=./ssl/type-7/type-7-key
```