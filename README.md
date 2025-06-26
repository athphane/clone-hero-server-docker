# Clone Hero Server Docker 🎸 🥁 🐳

Docker image for running a Clone Hero dedicated server. This project was forked from the original [GitLab repository by corysanin/clone-hero-server](https://gitlab.com/CorySanin/clone-hero-server-docker).

## Compatibility

This Docker image is currently built for Clone Hero version **v1.0.0.4080-final**.

## Quick Start

Create a docker-compose.yml file like the sample below in the Configuration section, then run:

```bash
docker compose up
```

## Configuration

Server settings can be customized using environment variables in your docker-compose.yml file:

| Variable | Description | Default Value |
|----------|-------------|---------------|
| `SERVER_NAME` | Name shown in the server browser | `clone-hero-server-docker` |
| `SERVER_PASSWORD` | Password required to join the server | `password` |
| `CONNECT_IP` | IP address to bind | `0.0.0.0` |
| `CONNECT_PORT` | UDP port to listen on | `14242` |

### Sample docker-compose.yml

```yaml
services:
  clone-hero-server:
    image: ghcr.io/athphane/clone-hero-server-docker:latest
    ports:
      - "14242:14242"
    environment:
      SERVER_NAME: "My Clone Hero Server"
      SERVER_PASSWORD: rockon
      CONNECT_IP: 0.0.0.0
      CONNECT_PORT: 14242
    container_name: clone-hero-server
    restart: unless-stopped
```

