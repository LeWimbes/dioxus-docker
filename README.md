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
