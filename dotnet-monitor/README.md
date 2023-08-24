# Dotnet Container Benchmarking

## Containers

|Container|Purpose|Image|
|-|-|-|
|.NET Samples|Sample ASP.NET Core application|[`mcr.microsoft.com/dotnet/samples:aspnetapp`](https://mcr.microsoft.com/en-us/product/dotnet/samples/about)|
|`aspnetapp6`|Sample ASP.NET Core application|Based on <https://github.com/dotnet/dotnet-docker/tree/main/samples/aspnetapp>|
|`aspnetapp7`|Sample ASP.NET Core application|Based on <https://github.com/dotnet/dotnet-docker/tree/main/samples/aspnetapp>|
|.NET Monitor|Diagnostics|[`mcr.microsoft.com/dotnet/monitor:6`](https://mcr.microsoft.com/en-us/product/dotnet/monitor/about)|
|.NET Monitor|Diagnostics|[`mcr.microsoft.com/dotnet/monitor:7`](https://mcr.microsoft.com/en-us/product/dotnet/monitor/about)|

## Demo

```powershell
# To spin up all containers run:
## .NET 6.0 example
docker compose --project-name monitor6 --profile net60 up -d

## .NET 7.0 example
docker compose --project-name monitor7 --profile net70 up -d

# To spin down all containers run:
docker compose down

# To delete all data run:
docker compose down -v
```

## Docker Configuration

An external docker network is used to bridge multiple separate docker instances for I/O.  Use the following commands in PowerShell to manage the networks used in this solution:

```powershell
# create external docker networks
docker network create monitor-shared

# delete external docker networks
docker network rm monitor-shared
```

## `dotnet-monitor` Sidecar Container

### Configuration

```powershell
dotnet-monitor config show
```

- <https://learn.microsoft.com/en-us/dotnet/core/runtime-config/debugging-profiling>
- <https://learn.microsoft.com/en-us/dotnet/core/diagnostics/available-counters>
- <https://learn.microsoft.com/en-us/aspnet/core/fundamentals/servers/kestrel/diagnostics?view=aspnetcore-7.0>

## Simulating Load

### Gocannon

```powershell
.\gocannon.exe http://localhost:<APP_PORT>/ --duration 30s --trust-all
```

## Visualization

### Unofficial `dotnet-monitor` UI

`dotnet-monitor UI` is easy to access user experience for `dotnet-monitor`. It is accessed by pointing the website <https://dotnet-monitor-ui.dev/> to your dotnet-monitor endpoint.

The following configuration needs to be added to your `dotnet-monitor` container:

```json
  "CorsConfiguration": {
    "AllowedOrigins": "https://dotnet-monitor-ui.dev"
  }
```

### Grafana

- <https://dotnetos.org/blog/2021-11-22-dotnet-monitor-grafana/>

## Garbage Collection

- <https://www.infoq.com/news/2022/11/GCCollectionMode-Aggressive/>

## References

- <https://github.com/dotnet/dotnet-monitor>
- <https://blog.steadycoding.com/asp-net-core-3-1-response-time-and-memory-spikes-in-kubernetes/>
- <https://learn.microsoft.com/en-us/events/dotnetconf-2020/collecting-aspnet-core-performance-traces-in-a-kubernetes-cluster>
- <https://github.com/ecoAPM/LoadTestToolbox>
