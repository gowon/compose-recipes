# Casdoor

Casdoor is an open-source Identity and Access Management (IAM) / Single-Sign-On (SSO) platform with web UI supporting OAuth 2.0, OIDC, SAML, CAS, LDAP, WebAuthn, TOTP and MFA.

## Containers

|Container|Purpose|Image|Path|
|-|-|-|-|
|Casdoor|IAM|[`casbin/casdoor-all-in-one:latest`](https://hub.docker.com/r/casbin/casdoor-all-in-one)|<http://localhost:16686/>|

## Usage

```powershell
# To spin up all containers run:
docker-compose up -d

# To spin down all containers run:
docker-compose down

# To delete all data run:
docker-compose down -v
```
