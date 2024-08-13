FROM rust:1 as builder

RUN cargo install --git https://github.com/DioxusLabs/dioxus --rev a2180b92e990f4d70c56d64bd7d9d960c13d3eb7 dioxus-cli
RUN curl -sLO https://github.com/tailwindlabs/tailwindcss/releases/latest/download/tailwindcss-linux-x64
RUN mv tailwindcss-linux-x64 tailwindcss
RUN chmod +x tailwindcss


FROM rust:1-slim

RUN apt-get update && apt-get full-upgrade -y \
    && apt-get install -y build-essential pkg-config libssl-dev \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/local/cargo/bin/dx /usr/local/cargo/bin/dx
COPY --from=builder /tailwindcss /usr/local/bin/tailwindcss
