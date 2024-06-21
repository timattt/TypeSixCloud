# Minecraft server

Выполнение команд:
```
kubectl exec POD_NAME -- cat /data/usercache.json
```

Копирование файлов на сервер:
```
kubectl cp POD_NAME:/data/server.properties server.properties -c minecraft
```