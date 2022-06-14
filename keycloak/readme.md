# Keycloak

Keycloak is a high performance Java-based identity and access management solution. It lets developers add an authentication layer to their applications with minimum effort.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Keycloak|IAM|[`keycloak/keycloak:latest`](https://hub.docker.com/r/keycloak/keycloak)|<http://localhost:8080>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

## References

- <https://www.keycloak.org/getting-started/getting-started-docker>
- <https://github.com/adorsys/keycloak-config-cli>
- <https://github.com/tuxiem/AspNetCore-keycloak>
- <https://github.com/vip32/aspnetcore-keycloak>
- <https://github.com/Kayes-Islam/keycloak-demo>
- Security with Keycloak in React and Web Api in ASP.NET Core 5.0 C#
  - <https://systemweakness.com/security-in-react-and-webapi-in-asp-net-core-c-with-authentification-and-authorization-by-keycloak-1d076777a979>
  - <https://blog.devgenius.io/security-in-react-and-webapi-in-asp-net-core-c-with-authentification-and-authorization-by-keycloak-89ba14be7e5a>
  - <https://blog.devgenius.io/security-in-react-and-webapi-in-asp-net-core-c-with-authentification-and-authorization-by-keycloak-f890d340d093>
