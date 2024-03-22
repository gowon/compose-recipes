# SQL Server

Microsoft SQL Server is a proprietary relational database management system developed by Microsoft, that supports a wide variety of transaction processing, business intelligence and analytics applications in corporate IT environments.

## Containers

|Container|Purpose|Image|Ports|
|-|-|-|-|
|SQL Server 2022|Relational Database|Dockerfile based on [`mcr.microsoft.com/mssql/server:2022-CU12-ubuntu-22.04`](https://hub.docker.com/_/microsoft-mssql-server)|`11433:1433`|
|MSSQL Tools|CLI Tool|[`mcr.microsoft.com/mssql-tools:latest`](https://hub.docker.com/_/microsoft-mssql-tools)||

## Usage

```powershell
# The init profile is to sidecar containers to initialize resources:
docker-compose --profile init up -d

# Otherwise, to spin up all containers run:
docker-compose up -d

# To teardown down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

## Notes

### Full-Text Search Support

By default, there is currently no Full-Text Search Support in the Docker Images for Microsoft SQL Serverby Microsoft. The only option currently available is to create your own Docker Image, which includes Full-Text Search in the form of the MSSQL Agent. Full-Text Search Support can be verified in your SQL Server instance by runnning the following query:

```sql
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')) PRINT 'INSTALLED' ELSE PRINT 'NOT INSTALLED'
GO
```

### SQL Server Agent

SQL Server Agent is a component of Microsoft SQL Server that is responsible to execute & schedule tasks or jobs in SQL Server. This can be enabled by setting the environment variable `MSSQL_AGENT_ENABLED` to `true`. You can verify that the agent is running by executing the following query:

```sql
SELECT dss.[status], dss.[status_desc] FROM sys.dm_server_services dss WHERE dss.[servicename] LIKE N'SQL Server Agent (%'
```

### MSSQL Tools Docker Image is stale

There is a published MSSSQL Tools image on the microsoft artifacts repository, however it many years old; see issue <https://github.com/microsoft/mssql-docker/issues/786>. As of Feb 2024, this older tools image still works without issue for MSSQL, but without updates there is a risk of this tool breaking compatiblity. If you require the latest tools and feature, there are unofficial containers of `sqlcmd` and the newer `go-sqlcmd` tools that can be used as an alternative:

- <https://github.com/fabiang/docker-sqlcmd>
- <https://github.com/fabiang/docker-go-sqlcmd>

## References

- <https://www.softwaredeveloper.blog/initialize-mssql-in-docker-container>
- <https://github.com/Microsoft/mssql-docker/issues/133#issuecomment-796472416>
- <https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables?view=sql-server-ver16>
- <https://learn.microsoft.com/en-us/sql/tools/sqlcmd/sqlcmd-utility?view=sql-server-ver16&tabs=odbc%2Cwindows>
- <https://github.com/microsoft/mssql-docker/tree/master/linux/preview/examples/mssql-customize>
- <https://gist.github.com/shawmanz32na/ee39c8aecdf643384e810d8dd4c8afae>
- Full Text Search Support
  - <https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure?view=sql-server-ver16&pivots=cs1-bash#examples-of-custom-docker-containers>
  - <https://github.com/twright-msft/mssql-node-docker-demo-app>
  - <https://tedspence.com/a-sql-server-docker-container-with-full-text-search-a1b7c5fc308c>
    - <https://github.com/tspence/docker-examples>
