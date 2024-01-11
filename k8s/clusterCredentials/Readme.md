# Получение токена и адреса кластера для CI/CD

* Устанавливаем конфигурацию k8s, чтобы можно было использовать локально утилиту kubectl

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