#!/bin/bash

docker build -t hello-world .

docker run -d \
  -l traefik.enable=true \
  -l traefik.http.routers.hello-world.rule=PathPrefix\(\`/landing\`\) \
  -l traefik.http.routers.hello-world.priority=999 \
  -l traefik.http.routers.hello-world.tls=true \
  -l traefik.http.routers.hello-world.tls.certresolver=le \
  -l traefik.http.routers.hello-world.entrypoints=websecure \
  -l traefik.http.routers.hello-world-http.entrypoints=web \
  -l traefik.http.routers.hello-world-http.rule=PathPrefix\(\`/landing\`\) \
  -l traefik.http.middlewares.redirect-to-https.redirectscheme.scheme=https \
  -l traefik.http.middlewares.redirect-to-https.redirectscheme.permanent=true \
  -l traefik.http.routers.hello-world-http.middlewares=redirect-to-https \
  -l traefik.http.services.hello-world.loadbalancer.server.port=4000 \
  --name="hello-world" \
  --restart="unless-stopped" \
  --network="web" \
  "hello-world"
