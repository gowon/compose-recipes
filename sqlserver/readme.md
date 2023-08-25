# SQL Server

Microsoft SQL Server is a proprietary relational database management system developed by Microsoft, that supports a wide variety of transaction processing, business intelligence and analytics applications in corporate IT environments.

## Containers

|Container|Purpose|Image|Ports|
|-|-|-|-|
|SQL Server|Relational Database|[`mcr.microsoft.com/mssql/server:2019-latest`](https://hub.docker.com/_/microsoft-mssql-server)|`1434`|
|MSSQL Tools|Relational Database|[`mcr.microsoft.com/mssql-tools:latest`](https://hub.docker.com/_/microsoft-mssql-tools)||

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

## Notes

The MSSSQL Tools image appears to be 6 years old; there is an unresolved issue <https://github.com/microsoft/mssql-docker/issues/786> inquiring about the situation. Until this is fixed, we should probably copy and build one of the Dockerfiles that exist in the <https://github.com/microsoft/mssql-docker/tree/master/linux/mssql-tools> repository.

## References

- <https://www.softwaredeveloper.blog/initialize-mssql-in-docker-container>
- <https://github.com/Microsoft/mssql-docker/issues/133#issuecomment-796472416>
- <https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables?view=sql-server-ver16>
- <https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=odbc%2Cwindows>
- <https://github.com/microsoft/mssql-docker/tree/master/linux/preview/examples/mssql-customize>
