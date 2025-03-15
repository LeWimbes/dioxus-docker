FROM rust:1 AS builder

RUN cargo install dioxus-cli --version 0.6.1

RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64; \
    elif [ "$ARCH" = "aarch64" ]; then \
        curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-arm64; \
    else \
        echo "Unsupported architecture"; exit 1; \
    fi && \
    mv tailwindcss-linux-* tailwindcss && \
    chmod +x tailwindcss


FROM rust:1-slim

RUN apt-get update && apt-get full-upgrade -y \
    && apt-get install -y build-essential pkg-config libssl-dev \
    && rm -rf /var/lib/apt/lists/*

RUN rustup target add wasm32-unknown-unknown

COPY --from=builder /usr/local/cargo/bin/dx /usr/local/cargo/bin/dx
COPY --from=builder /tailwindcss /usr/local/bin/tailwindcss
