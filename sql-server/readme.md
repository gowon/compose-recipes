# SQL Server

SQL Server is a relational database management system developed by Microsoft.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|SQL Server 2022 Developer Edition|Relational Database|[`server:2022-latest`](https://hub.docker.com/_/microsoft-mssql-server)|<http://localhost:1433>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
