# LAMP Stack Environment

PHP is a popular general-purpose scripting language that is especially suited to web development.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|PHP|Apache PHP Server|[`php:8-apache`](https://hub.docker.com/r/jenkins/jenkins)|<http://localhost:8000>|
|MySQL|Database|[`mysql:latest`](https://hub.docker.com/r/jenkins/ssh-agent)|<http://localhost:9906>|

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
