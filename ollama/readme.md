# Ollama

References:

- <https://github.com/valiantlynx/ollama-docker>
- <https://danielroelfs.com/blog/querying-databases-using-langchain-and-ollama/>

## Usage

### Containers

|Container|Purpose|Image|Ports|
|-|-|-|-|
|Ollama|LLM|[`ollama/ollama:latest`](https://hub.docker.com/r/ollama/ollama)|`11434`|
|Open WebUI|AI Chat Application|[`ghcr.io/open-webui/open-webui:main`](https://github.com/open-webui/open-webui/pkgs/container/open-webui)|`8080`|

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
