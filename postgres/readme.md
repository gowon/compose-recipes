# PostgreSQL Server

Postgres, is a free and open-source relational database management system (RDBMS) emphasizing extensibility and SQL compliance.

## Containers

|Container|Purpose|Image|Ports|
|-|-|-|-|
|PostgreSQL|Relational Database|[`postgres:16-alpine`](https://hub.docker.com/_/postgres)|`5432`|
|pgAdmin 4|Admin GUI|[`dpage/pgadmin4:8`](https://hub.docker.com/r/dpage/pgadmin4)|`80`|
|CloudBeaver Community Edition|Admin GUI|[`dbeaver/cloudbeaver:24`](https://hub.docker.com/r/dbeaver/cloudbeaver)|`8978`|

## Usage

### With CloudBeaver UI

Use the following command to execute this recipe:

```powershell
docker-compose -f cloudbeaver.docker-compose.yaml up -d
```

To teardown the services:

```powershell
docker-compose -f cloudbeaver.docker-compose.yaml down
```

Finally, to teardown all services and data in the `docker-compose.yaml`:

```powershell
docker-compose -f cloudbeaver.docker-compose.yaml down -v
```

### With pgAdmin UI

Use the following command to execute this recipe:

```powershell
docker-compose -f pgadmin.docker-compose.yaml up -d
```

To teardown the services:

```powershell
docker-compose -f pgadmin.docker-compose.yaml down
```

Finally, to teardown all services and data in the `docker-compose.yaml`:

```powershell
docker-compose -f pgadmin.docker-compose.yaml down -v
```

### Initializing multiple databases

The shell script `create-additional-postgresql-databases.sh` in the mounted `docker-entrypoint-initdb.d` folder adds support to initialize multiple databases. Using the `POSTGRES_ADDITIONAL_DATABASES` environment variable, you can set multiple databases using a CSV string.

> See <https://github.com/mrts/docker-postgresql-multiple-databases> for more information

## Notes

- By default, if the environment variable `POSTGRES_DB` is not specified, Postgres will create a database with the same name as `POSTGRES_USER`.
- Postgres client `psql` connects to a database named after the user by default. If that does not exist, you will get the error  This is why you get the error: `FATAL:  database "<$POSTGRES_USER>" does not exist`. You can connect to the default system database `postgres` and then issue your query.

> See <https://stackoverflow.com/a/19426770/7644876>

## References

- <https://stackoverflow.com/a/77519799>
- <https://stackoverflow.com/a/70040661>
- <https://github.com/pgadmin-org/pgadmin4/issues/6257#issuecomment-1660359154>
- CloudBeaver
  - <https://github.com/dbeaver/cloudbeaver/issues/2165#issuecomment-1834257959>
  - <https://medium.com/@dionathan.chrys/setting-up-databases-access-with-cloudbeaver-on-kubernetes-7a811c04f24c>
