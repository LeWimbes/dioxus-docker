FROM rust:1-slim
ENV DEBIAN_FRONTEND=noninteractive

# Install Dioxus dependencies: https://dioxuslabs.com/learn/0.7/getting_started/#linux
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    libwebkit2gtk-4.1-dev \
    build-essential \
    curl \
    wget \
    file \
    libxdo-dev \
    libssl-dev \
    libayatana-appindicator3-dev \
    librsvg2-dev \
    lld && \
    rm -rf /var/lib/apt/lists/*

# Install wasm32 target
RUN rustup target add wasm32-unknown-unknown

# Install Dioxus CLI
ARG DIOXUS_CLI_VERSION
ARG TARGETARCH
RUN case "${TARGETARCH}" in \
        amd64) ARCH="x86_64" ;; \
        arm64) ARCH="aarch64" ;; \
        *) echo "Unsupported architecture: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    curl --proto '=https' --tlsv1.2 -fsSL https://github.com/DioxusLabs/dioxus/releases/download/v${DIOXUS_CLI_VERSION}/dx-${ARCH}-unknown-linux-gnu.tar.gz | \
    tar -xz -C /usr/local/cargo/bin
