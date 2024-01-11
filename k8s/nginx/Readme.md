# Установка NGINX

## Добавляем репозиторий

```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
```

```
helm repo update
```

## Устанавливаем nginx

Не забываем в файле values.yaml указать нужные статические IP

```
helm install ingress-nginx -f values.yaml ingress-nginx/ingress-nginx
```

## Генерация сертификата

```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.12.1/cert-manager.yaml
```

```
kubectl apply -f acme-issuer.yaml
```

## Настройка проксирования

```
kubectl apply -f ingress.yaml
```