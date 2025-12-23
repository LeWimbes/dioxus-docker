# Dioxus & TailwindCSS Docker Image

This repository is used to build and push Docker images for building applications using Dioxus and TailwindCSS.

```bash
sudo docker build --platform linux/amd64,linux/arm64 -t lewimbes/dioxus:latest -t lewimbes/dioxus:0.6.3 --push .
```

The alpine version was built using the below command:

```sh
docker build -f Dockerfile.alpine -t tomjtoth/dioxus-docker:0.7.2-alpine --push .
```
