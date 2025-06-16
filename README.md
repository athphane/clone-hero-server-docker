# clone-hero-server 🎸 🥁 🐳

Docker image for Clone Hero dedicated server software. Available on [Docker Hub](https://hub.docker.com/r/corysanin/clone-hero-server).

Clone the repository and start the server with Docker Compose:

```bash
docker compose up
```

Server settings can be customised with environment variables:

- `SERVER_NAME` – name shown in the server browser (default `clone-hero-server-docker`)
- `SERVER_PASSWORD` – password required to join the server
- `CONNECT_IP` – IP address to bind (default `0.0.0.0`)
- `CONNECT_PORT` – UDP port to listen on (default `14242`)

Example:

```bash
SERVER_NAME="My Server" SERVER_PASSWORD="secret" docker compose up
```

## Publishing to GitHub Container Registry

A GitHub Actions workflow is provided to automatically build and publish the
Docker image to the GitHub Container Registry whenever changes are pushed to the
`main` branch. Ensure that the `GHCR` permissions are enabled for the repository
and that the workflow has access to `GITHUB_TOKEN`.

To trigger the workflow manually, navigate to the "Actions" tab on GitHub and
run the *Build and publish to GHCR* workflow.

