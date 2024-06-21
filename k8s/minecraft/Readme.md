# Minecraft server

Выполнение команд:
```
kubectl exec POD_NAME -- cat /data/usercache.json
```

Копирование файлов на сервер:
```
kubectl cp minecraft-deployment-7bbc5c44b5-mjmg7:/data/server.properties server.properties -c minecraft
```