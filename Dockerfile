
FROM node:22-bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git openssh-client ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g @opencode/cli

ENV HOME=/data
WORKDIR /app

EXPOSE 10000

CMD ["sh", "-c", "set -eu; test -n \"${OPENCODE_PASSWORD:-}\"; mkdir -p /data/workspace; opencode service set password \"$OPENCODE_PASSWORD\"; cd /data/workspace; exec opencode serve --hostname 0.0.0.0 --port \"${PORT:-10000}\""]
