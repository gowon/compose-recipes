# NuGet Server using BaGet

BaGet is a lightweight NuGet and symbol server.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|BaGet|NuGet Server|[`loicsharma/baget:latest`](https://hub.docker.com/r/loicsharma/baget)|<http://localhost:7080>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

The following commands us the default API Key `E2045F9611A34A58A99D96D6C5E4A679`:

```powershell
# Publish your first package with:
dotnet nuget push -s http://localhost:7080/v3/index.json -k E2045F9611A34A58A99D96D6C5E4A679 package.1.0.0.nupkg

# Publish your first symbol package with:
dotnet nuget push -s http://localhost:7080/v3/index.json -k E2045F9611A34A58A99D96D6C5E4A679 symbol.package.1.0.0.snupkg
```
