# Dioxus Docker Image

[![Build status](https://github.com/lewimbes/dioxus-docker/actions/workflows/auto-build-on-release.yml/badge.svg)](https://github.com/lewimbes/dioxus-docker/actions/workflows/auto-build-on-release.yml)

Automatically builds and publishes **multi‑architecture Docker images** for [Dioxus](https://dioxuslabs.com) which can be used to build Dioxus apps in a containerized environment.

---

## ✨ Why use this image?

- **Multi‑arch** – runs on `linux/amd64` and `linux/arm64`.
- **Automatic rebuilds** – whenever a new Dioxus version is released.
- Available from **Docker Hub** (`lewimbes/dioxus`) and **GHCR** (`ghcr.io/lewimbes/dioxus-docker`).

---

## 📦 Quick start

```bash
# Pull the latest image
docker pull ghcr.io/lewimbes/dioxus-docker:latest

# Or pin a specific version
docker pull ghcr.io/lewimbes/dioxus-docker:0.7.2
docker pull ghcr.io/lewimbes/dioxus-docker:0.7
docker pull ghcr.io/lewimbes/dioxus-docker:0
```

---

## 🛠️ Build it yourself

```bash
docker buildx build \
  --platform linux/amd64,linux/arm64 \
  --build-arg DIOXUS_CLI_VERSION=0.7.2 \
  -t dioxus:0.7.2 .
```

---

## 🚀 Usage

Below are some examples of how to use the Dioxus Docker image to build your Dioxus app.  
While these may not fit your use case exactly, they should provide a good starting point.

### Locally

```bash
docker run --rm \
  -u $(id -u):$(id -g) \
  -e CARGO_HOME=/tmp/cargo \
  -e HOME=/tmp \
  -v .:/workspace \
  -w /workspace \
  ghcr.io/lewimbes/dioxus-docker:0.7.2 \
  dx build --release
```

### For GitHub Pages CD

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: ["main"]

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/lewimbes/dioxus-docker:0.7.2
    steps:
      - name: Checkout
        uses: actions/checkout@v6

      - name: Build Dioxus App
        run: dx build --release --platform web

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v4
        with:
          path: target/dx/<my-project>/release/web/public/

  deploy:
    needs: build
    runs-on: ubuntu-latest
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### For GitLab Pages CD

```yaml
image: ghcr.io/lewimbes/dioxus-docker:0.7.2

pages:
  stage: deploy
  script:
    - dx build --release --platform web
    - cp -a target/dx/<my-project>/release/web/public/. public/
  artifacts:
    paths:
      - public
  cache:
    key: target
    paths:
      - target/
  rules:
    - if: $CI_COMMIT_BRANCH == $CI_DEFAULT_BRANCH
```

---

## 🤖 How the workflow works

A single GitHub Actions workflow keeps the image fresh:

- **Triggers**

  - A daily scheduled run that checks whether Dioxus has a new release.

- **If an update is needed**, the job:

  - Builds a new Dioxus image for linux/amd64 and linux/arm64.
  - Tags the result (latest, full semver, major‑minor, major).
  - Pushes to **Docker Hub** and **GHCR**.

See [`auto-build-on-release.yml`](./.github/workflows/auto-build-on-release.yml) for full details.

---

## 📝 License

This repository is licensed under either the **MIT License** or the **Apache License 2.0**.  
The upstream project [Dioxus](https://github.com/dioxuslabs/dioxus) is licensed under either the **MIT License** or the **Apache License 2.0**.

---

### Official resources

- Upstream project – <https://dioxuslabs.com>
