# MinIO

MinIO is a High Performance Object Storage released under GNU Affero General Public License v3.0. It is API compatible with Amazon S3 cloud storage service. Use MinIO to build high performance infrastructure for machine learning, analytics and application data workloads.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Minio|S3-compatible Blob Storage|[`minio:latest`](https://hub.docker.com/r/minio/minio)|<http://localhost:9001/>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
