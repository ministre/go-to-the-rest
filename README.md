# go-to-the-rest

## Описание

Приложение для отправки REST-запросов на Backend.

## Установка и конфигурация

### Вариант 1: Docker-контейнере

* Загрузить проект:

```bash
git clone https://github.com/ministre/go-to-the-rest.git
```

* Перейти в папку проекта:

```bash
cd go-to-the-rest/
```

* Отредактировать параметры конфигурации в файле config/config.json

```bash
nano config/config.json
```

* Собрать docker образ:

```bash
docker build --tag go-to-the-rest .
```

* Запустить docker контейнер:

```bash
docker run -it -v ${PWD}/config:/app/config go-to-the-rest /app/go-to-the-rest
```

### Вариант 2: Скомпилированное приложение

...

## Компиляция

...

## Запуск в cron

...
