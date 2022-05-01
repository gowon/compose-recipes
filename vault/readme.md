# HashiCorp Vault

Vault secures, stores, and tightly controls access to tokens, passwords, certificates, API keys, and other secrets in modern computing.

## Notes

Script needs to be executed using `--isolated-load-context`, <https://github.com/filipw/dotnet-script/issues/648>.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Vault|Secrets store|[`vault:latest`](https://hub.docker.com/_/vault)|<http://localhost:8200/ui>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

The root dev API Key is set to `fab5978b6ed44026a76bd0616fc2223e`:

```powershell
# Publish your first package with:
dotnet script .\build.csx --isolated-load-context -- test-secrets
```
