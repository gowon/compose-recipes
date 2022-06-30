# Seq

Seq is a real-time search and analysis server for structured application log data.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Seq|Distributed Logger|[`datalust/seq:latest`](https://hub.docker.com/r/datalust/seq)|<http://localhost:5340/>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
