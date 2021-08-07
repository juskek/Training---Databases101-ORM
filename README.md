# Docker + Django + MySQL

## Clone the repo

 - `cd user/Github` (or wherever)
 - `git clone https://github.com/JamesDHW/docker-django-mysql.git`
 - `cd docker-django-mysql`
 
## Build and run the container

 - run `docker-compose build` to build the container.
 - run `docker-compose up -d` to run the container as a daemon.
 - go to `localhost:8000` and see a basic Django page.

## Run the `web` service

 - run `docker-compose exec web bash` to open a bash console for the `web` container.
 - run `ping db` to ping the `db` service.

expected output:

```
...
64 bytes from docker-django-mysql_db_1.docker-django-mysql_default (172.22.0.2): icmp_seq=27 ttl=64 time=0.220 ms
64 bytes from docker-django-mysql_db_1.docker-django-mysql_default (172.22.0.2): icmp_seq=28 ttl=64 time=0.451 ms
...
```

This should mean that your `web` service (where Django runs) can talk to your `db` service (running your SQL server).

 - run `ps aux | grep mysql` to get any process that's running which contains `mysql` in the name - if you get output, a proccess has been found.

Quit the bash shell for `web` with `cntrl+d`.

## Run the `db` service

 - run `docker-compose exec db bash` to open a bash console for the `db` container.
 - run `mysql -u root -p my-app-db` (where `root` is username and `my-app-db` is the databse name).
 - type in your password (`password`).

You should now be connected to the mysql client for your database.

 - run `SHOW TABLES` to view all the tables (should be none).
 - run `CREATE TABLE users ( firstName varchar(255) );` to create a table (you can press enter, the command is only executed after a `;`).
 - run `SHOW TABLES` to see the table you created.

Quit the bash shell for `db` with `cntrl+d`.


# How I made this project


 - `mkdir DockerMySQL && cd DockerMySQL && git init && git remote add origin ...` - make new git repo
 - `python -m django startproject DockerMySQL` - django init new project


### Add `Dockerfile`

```
FROM python:3.6
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade pip

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

RUN mkdir /DockerMySQL
WORKDIR /DockerMySQL
COPY ./DockerMySQL /DockerMySQL
```

### Add `docker-compose.yml`

```
version: '3'

services:
  db:
    image: mysql:5.7
    ports:
      - '3306:3306'
    environment:
       MYSQL_DATABASE: 'my-app-db'
       MYSQL_ROOT_PASSWORD: 'password'
  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - ./DockerMySQL:/DockerMySQL
    ports:
      - "8000:8000"
    depends_on:
      - db

```

### Add `requirements.txt`

```
Django==1.11.5
mysqlclient==1.3.12
django-mysql==2.2.0
```

### In `settings.py` add `DATABASES` variable

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'my-app-db',
        'USER': 'root',
        'PASSWORD': 'password',
        'HOST': '192.168.1.97', <-- I think this might be wrong now but if it works 🤷‍♂️
        'PORT': 3306,
    }
}
```

### Remove the default `DATABASES` variable

[View the commit here](https://github.com/JamesDHW/docker-django-mysql/commit/89ede0086036726c9798a8c01b1093e2452e89d3)


```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}
```

