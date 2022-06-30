# Jaeger

Jaeger is a distributed tracing system. It is used for monitoring and troubleshooting microservices-based distributed systems.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Jaeger|Tracing|[`jaegertracing/all-in-one:1`](https://hub.docker.com/r/jaegertracing/all-in-one)|<http://localhost:16686/>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
