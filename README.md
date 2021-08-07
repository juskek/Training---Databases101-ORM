# Docker + Django + MySQL

## Build and run the container

 - run `docker-compose build`.
 - run `docker-compose up -d` to run the container as a daemon.

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
