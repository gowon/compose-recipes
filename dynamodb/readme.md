# AWS DynamoDb Local with Admin GUI

Amazon DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|DynamoDB Local|Document DB|[`amazon/dynamodb-local:latest`](https://hub.docker.com/r/amazon/dynamodb-local)|<http://localhost:8000>|
|dynamodb-admin|GUI for DynamoDB|[`aaronshaf/dynamodb-admin:latest`](https://hub.docker.com/r/aaronshaf/dynamodb-admin)|<http://localhost:8001>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

```powershell
# Restore .NET global tools
dotnet tool restore

# To seed data:
dotnet script .\build.csx -- seed-data
```

## References

- <https://medium.com/platform-engineer/running-aws-dynamodb-local-with-docker-compose-6f75850aba1e>
- <https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBLocal.DownloadingAndRunning.html>
- <https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/SampleData.html>
- <https://hub.docker.com/r/aaronshaf/dynamodb-admin/>
- <https://github.com/aaronshaf/dynamodb-admin>
