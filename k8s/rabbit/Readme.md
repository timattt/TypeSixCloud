# Как настраивать пересылку почты

* Заходим в админку яндекс360
* Покупаем тариф
* Теперь яндекс-почта привязана к корп аккаунту
* Далее добавляем домен
* Следует там инструкции - добавляем нужные записи в DNS
* Создаем в yandex360 пользователя, от имени которого будем отправлять письма
* При подключении к SMTP параметры могут быть такие:

```
email:
    display_name: 'Apricot Gitlab'
    from: 'info@akhpl.ru'
    reply_to: 'noreply@akhpl.ru'
  smtp:
    enabled: true
    address: 'smtp.yandex.ru'
    tls: true
    port: 465
    authentication: 'login'
    user_name: 'info@akhpl.ru'
    enable_starttls_auto: true
    domain: 'akhpl.ru'
    password:
      secret: 'smtp-password'
      key: 'password'

```