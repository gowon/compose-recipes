# Keycloak

Keycloak is a high performance Java-based identity and access management solution. It lets developers add an authentication layer to their applications with minimum effort.

## Containers

|Container|Purpose|Image|Port|
|-|-|-|-|
|Keycloak|IAM|[`keycloak/keycloak:22.0`](https://hub.docker.com/r/keycloak/keycloak)|[`8080`](http://localhost:8080)|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```

## Health checks

Keycloak takes about 6-10 seconds before it is ready. `curl` was removed from the image for security reason, so a custom healthcheck script is created to perfom a healthcheck. See <https://github.com/keycloak/keycloak/issues/17273>.

## Export Realm Data

```bash
opt/keycloak/bin/kc.sh export --file tmp/export.json --realm test --users realm_file
```

> See <https://www.opcito.com/blogs/how-to-import/export-realm-in-keycloak>

## References

- Keycloack
  - <https://www.keycloak.org/getting-started/getting-started-docker>
  - <https://www.keycloak.org/server/containers#_running_a_standard_keycloak_container>
  - <https://www.keycloak.org/server/all-config>
  - <https://www.keycloak.org/extensions.html>
  - <https://hackmd.io/@tPxwddC0R3uDaZSGNlIInA/r1VAnz9Rc#Start-the-container-as-developer-environment>
- Importing/Exporting realms
  - <https://suedbroecker.net/2022/12/08/export-a-keycloak-version-20-realm/>
  - <https://www.keycloak.org/server/importExport>
- Integrating Keycloak and Blazor WASM
  - <https://github.com/NikiforovAll/keycloak-authorization-services-dotnet>
  - <https://nikiforovall.github.io/blazor/dotnet/2022/12/08/dotnet-keycloak-blazorwasm-auth.html>
- <https://github.com/adorsys/keycloak-config-cli>
- <https://github.com/tuxiem/AspNetCore-keycloak>
- <https://github.com/vip32/aspnetcore-keycloak>
- <https://github.com/Kayes-Islam/keycloak-demo>
