# LAMP Stack Environment

PHP is a popular general-purpose scripting language that is especially suited to web development. MariaDB Server is one of the most popular database servers in the world. It’s made by the original developers of MySQL and guaranteed to stay open source. Adminer (formerly phpMinAdmin) is a full-featured database management tool written in PHP. 

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|PHP|Apache PHP Server|[`php:8-apache`](https://hub.docker.com/_/php/)|<http://localhost:8088>|
|MariaDB|Database|[`mariadb:10`](https://hub.docker.com/_/mariadb)|<http://localhost:9906>|
|Adminer|DB Management|[`adminer:latest`](https://hub.docker.com/_/adminer/)|<http://localhost:8089>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

## References

- <https://www.section.io/engineering-education/dockerized-php-apache-and-mysql-container-development-environment/>
