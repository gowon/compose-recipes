#!/usr/bin/env pwsh

New-Item -ItemType Directory -Path "extensions" -Force

# https://github.com/p2-inc/keycloak-magic-link
Invoke-WebRequest -Uri "https://repo1.maven.org/maven2/io/phasetwo/keycloak/keycloak-magic-link/0.20/keycloak-magic-link-0.20.jar" -OutFile ".\extensions\keycloak-magic-link-0.20.jar"