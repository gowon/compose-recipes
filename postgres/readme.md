# PostgreSQL Server

Postgres, is a free and open-source relational database management system (RDBMS) emphasizing extensibility and SQL compliance.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|PostgreSQL|Relational Database|[`postgres:14-alpine`](https://hub.docker.com/_/postgres)|<http://localhost:5432>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
