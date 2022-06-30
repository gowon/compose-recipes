# smtp4dev

smtp4dev is a dummy SMTP server that lets you test your application without spamming your real customers and without needing to set up a complicated real email server with a special configuration.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|smtp4dev|SMTP server|[`rnwood/smtp4dev:v3`](https://hub.docker.com/r/rnwood/smtp4dev)|<http://localhost:5080/>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
