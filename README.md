# go-to-the-rest

## Описание

Микросервис для отправки REST-запросов на Backend сервер.

## Установка и конфигурация

### Вариант 1: Сборка Docker-образа и запуск в контейнере

* Загрузить проект:

```shell
git clone https://github.com/ministre/go-to-the-rest.git
```

* Перейти в папку проекта:

```shell
cd go-to-the-rest/
```

* Отредактировать параметры конфигурации в файле config/config.json

```shell
nano config/config.json
```

* Собрать docker образ:

```shell
docker build --tag go-to-the-rest .
```

* Запустить docker контейнер и отправить REST запрос:

```shell
docker run -it -v ${PWD}/config:/app/config go-to-the-rest /app/go-to-the-rest
```

### Запуск в docker-compose.yml

* Создать папку конфигурации

```shell
mkdir -p myproject/config
```

* Создать файл config.json с заданными параметрами конфигурации:

```shell
echo '{ "url": "http://localhost:8000/api/v1/test/", "method": "POST", "token": "Bearer 12345" }' > myproject/config/config.json
```

* Перейти в папку проекта и создать файл docker-compose.yml

```shell
cd myproject && nano docker-compose.yml
```

```yaml
version: '3'

services:

  task-bot:
    container_name: go-to-the-rest
    image: ministre/go-to-the-rest:1.0-alpine
    volumes:
      - ./config:/app/config/
```

* Собрать контейнер

```shell
docker compose up --build
```

### Вариант 3: Скомпилированное приложение

...

## Компиляция

...

## Запуск в cron

...
