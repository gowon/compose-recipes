# .NET Aspire Dashboard

The [.NET Aspire Dashboard](https://aspiredashboard.com/) is a comprehensive tool for application diagnostics and monitoring. The dashboard allows you to closely track various aspects of your app, including logs, traces, and environment configurations, in real-time. It's purpose-built to enhance the local development experience, providing an insightful overview of your app's state and structure.

## Usage

### Containers

|Container|Purpose|Image|Ports|
|-|-|-|-|
|Aspire|Monitoring Dashboard|[`mcr.microsoft.com/dotnet/aspire-dashboard:8`](https://mcr.microsoft.com/en-us/artifact/mar/dotnet/aspire-dashboard/about)|`18888` `18889` `18890`|

### Docker Compose

Use the following command to execute this recipe:

```powershell
docker-compose up -d
```

To teardown the services:

```powershell
docker-compose down
```

Finally, to teardown all services and data in the `docker-compose.yaml`:

```powershell
docker-compose down -v
```
