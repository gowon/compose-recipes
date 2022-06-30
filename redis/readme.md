# Redis

Redis is an open source key-value store that functions as a data structure server. Redis Commander is a Redis web management tool written in node.js

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Redis|KV Storage|[`redis:7-alpine`](https://hub.docker.com/_/redis)|<http://localhost:6379/>|
|Redis Commander|Redis Admin UI|[`rediscommander/redis-commander:latest`](https://hub.docker.com/r/rediscommander/redis-commander)|<http://localhost:8881/>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
