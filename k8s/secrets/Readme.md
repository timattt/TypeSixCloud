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
--from-literal=type_8_client_secret=
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

```
kubectl create secret generic type-10-mail-creds `
--from-literal=username=??? `
--from-literal=password=??? `
```