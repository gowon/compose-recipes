# SQL Server

Microsoft SQL Server is a relational database management system (RDBMS). Applications and tools connect to a SQL Server instance or database, and communicate using Transact-SQL (T-SQL).

## Usage

### Containers

|Container|Purpose|Image|Ports|
|-|-|-|-|
|SQL Server 2022 on Linux|Relational Database|Dockerfile based on [`mcr.microsoft.com/mssql/server:2022-CU15-GDR1-ubuntu-22.04`](https://mcr.microsoft.com/en-us/artifact/mar/mssql/server/about)|`1433`|
|SQL tools (`bcp` and `sqlcmd`)|SQL tools|Dockerfile based on [`alpine:3.20`](https://hub.docker.com/_/alpine)||
|SQL tools (`bcp` and `sqlcmd`) w/ Locale support|SQL tools|Dockerfile based on [`ubuntu:24.04`](https://hub.docker.com/_/ubuntu/)||
|CloudBeaver Community Edition|Admin GUI|[`dbeaver/cloudbeaver:24`](https://hub.docker.com/r/dbeaver/cloudbeaver)|`8978`|

You can build the custom SQL Server image by running the following command:

```powershell
docker build --tag 'mssql-server2022:fts' --file .\mssql-server2022-fts.Dockerfile .
```

> [!NOTE]
> Due to the size of the packages that need to be downloaded and installed during build, this command generate an image ~4GB in size and can take up to 5 minutes to complete depending on the specs of your machine.

You can build the Alpine-based SQL tools image by running the following command:

```powershell
docker build --tag 'mssql-tools18:alpine-3.20' --file .\mssql-tools18-alpine.Dockerfile .
```

You can build the Ubuntu-based SQL tools image by running the following command:

```powershell
docker build --tag 'mssql-tools18:ubuntu-24.04' --file .\mssql-tools18-ubuntu.Dockerfile .
```

### Docker Compose

This recipe supports bootstrapping the services by running an `init` profile. To run the `docker-compose.yaml` in this configuration:

```powershell
docker-compose --profile init up -d
```

On subsequent runs, you can run the `docker-compose.yaml` regularly:

```powershell
docker-compose up -d
```

To teardown the services:

```powershell
docker-compose down
```

Finally, to teardown all services and data in the `docker-compose.yaml`, including the ones used for initialization:

```powershell
docker-compose --profile init down -v
```

## Notes

### Custom SQL Server 2022 Docker Image

The official [Microsoft SQL Server - Ubuntu based images](https://mcr.microsoft.com/en-us/artifact/mar/mssql/server/about) do not include optional components that may be necessary for use case. In order to integrate these components, you have to create a custom image, then download and install each component. The following is a non-exhaustive list of components:

|Component|Description|
|-|-|
|[`mssql-server-agent`](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-sql-agent?view=sql-server-ver16&tabs=rhel)|SQL Server Agent (Included with the mssql-server package and is disabled by default.)|
|[`mssql-server-extensibility`](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-machine-learning-sql-2022?view=sql-server-ver16#install-mssql-server-extensibility-package)|Extensibility framework used to run Python and R.|
|[`mssql-server-fts`](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-full-text-search?view=sql-server-ver16&tabs=ubuntu)|SQL Server Full-Text Search|
|[`mssql-server-ha`](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-ha-basics?view=sql-server-ver16)|high availability (HA)|
|[`mssql-server-is`](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-ssis?view=sql-server-ver16&tabs=ubuntu)|SQL Server Integration Services|
|[`mssql-server-polybase`](https://learn.microsoft.com/en-us/sql/relational-databases/polybase/polybase-linux-setup?view=sql-server-ver16&tabs=ubuntu)|Data virtualization with PolyBase|
|[`mssql-server-sqliosim`](https://learn.microsoft.com/en-us/troubleshoot/sql/tools/sqliosim-utility-simulate-activity-disk-subsystem-linux?tabs=ubuntu)|SQLIOSim utility to simulate SQL Server activity on a disk subsystem|

References:

- <https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-configure-environment-variables?view=sql-server-ver16>
- <https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-configure?view=sql-server-linux-ver16>
- <https://github.com/microsoft/mssql-docker/tree/master/linux/preview>
- <https://github.com/Microsoft/mssql-docker/issues/133#issuecomment-796472416>

#### Verifying components

- Full-Text Search Support can be verified in your SQL Server instance by running the following query:

    ```sql
    IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')) PRINT 'FULLTEXT INSTALLED' ELSE PRINT 'FULLTEXT NOT INSTALLED'
    GO
    ```

- The SQL Server Agent is a component of Microsoft SQL Server that is responsible to execute & schedule tasks or jobs in SQL Server. This can be enabled by setting the environment variable `MSSQL_AGENT_ENABLED` to `true`. You can verify that the agent is running by executing the following query:

    ```sql
    IF (4 = (SELECT dss.[status] FROM sys.dm_server_services dss WHERE dss.[servicename] LIKE N'SQL Server Agent (%'))  PRINT 'SQL SERVER AGENT RUNNING' ELSE PRINT 'SQL SERVER AGENT NOT RUNNING'
    GO
    ```

#### Integrated OpenTelemetry Collector

The [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) has also been installed in the Dockerfile to be able to pull metrics from the SQL Server instance. To enable the integrated OpenTelemetry Collector for the image, set the environment variable `USE_OTELCOL` to `true`. The collector can be configured by editing the `mssql-server.otelcol-config.yaml` file.

References:

- <https://opentelemetry.io/docs/collector/installation/#linux>
- <https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/sqlserverreceiver>

#### Running multiple processes in a container with Supervisor

Traditionally a Docker container runs a single process when it is launched, for example an Apache daemon or a SSH server daemon. In our use case, we want to run multiple services (SQL Server and the OpenTelemetry Collector) in the same container; we also want both processes to be managed by docker in the same way as the traditional scenarios. We make use of the process management tool, [Supervisor](http://supervisord.org/), to manage multiple processes in our container.

- <https://docs.docker.com/engine/containers/multi-service_container/>
- <https://advancedweb.hu/supervisor-with-docker-lessons-learned/>
- <https://dev.to/pratapkute/multiple-services-in-a-docker-container-with-supervisord-2g13>

#### Restoring databases from backup files

In order to restore databases from backup files, those files need to be accessible from the SQL Server instance and should be mounted to the container. This recipe facilitates that by mounting the subfolder `backups` to `/var/backups` in the SQL Server instance in `docker-compose.yaml`.

### Custom SQL Tools Images

As of this writing, the [official image for Microsoft SQL Server command line tools (`sqlcmd`/`bcp`) in a Linux](https://hub.docker.com/r/microsoft/mssql-tools) container includes version 13.1.0007.0 of the tools, which are stale; see issue <https://github.com/microsoft/mssql-docker/issues/786>. In order to use the latest versions of the SQL tools, we have to create a custom image.

There are two images with different bases, `alpine` and `ubuntu`. The Alpine-based image is significantly smaller (~48MB) than the Ubuntu-based image (~169MB), but does not support locales. If locale support is important to your use case, then you need to use the Ubuntu-based image.

To use the SQL Tools directly from the CLI, use the following command:

```powershell
docker run --rm mssql-tools18:alpine-3.20 sqlcmd -?
```

References:

- <https://github.com/microsoft/mssql-docker/tree/master/linux/mssql-tools>
- <https://hub.docker.com/r/microsoft/mssql-tools>
- <https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-setup-tools?view=sql-server-ver16&tabs=ubuntu-install>
- <https://learn.microsoft.com/en-us/sql/connect/odbc/linux-mac/installing-the-microsoft-odbc-driver-for-sql-server?view=sql-server-linux-ver16&tabs=alpine18-install%2Calpine17-install%2Cdebian8-install%2Credhat7-13-install%2Crhel7-offline>
- <https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16>
- <https://learn.microsoft.com/en-us/sql/tools/overview-sql-tools?view=sql-server-ver16#command-line-tools>

#### Automating execution of SQL scripts with `mssql-tools18`

This recipe includes the shell script `run-scripts.sh` in the `docker-compose.yaml`, which will scan it's folder for SQL scripts and execute them in alphabetical order by their file name to bootstrap your SQL Server. The script can be configured by passing the following environment variables:

|Environment Variable|Description|Default Value|
|-|-|-|
|`MSSQL_HOST`|The hostname of the SQL Server instance the script will connect to.|-|
|`MSSQL_SA_PASSWORD`|The password for the `sa` user account for `MSSQL_HOST`.|-|
|`MSSQL_HOST_CONNECTION_MAX_RETRIES`|Max number of attempts the script will take to successfully connect to `MSSQL_HOST`.|5|
|`MSSQL_HOST_CONNECTION_RETRY_WAIT_SECONDS`|The number of seconds to wait between connection attempts.|3|
