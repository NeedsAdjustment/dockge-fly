FROM alpine:latest as builder
WORKDIR /app
COPY start.sh /app/start.sh

FROM louislam/uptime-kuma:1

USER root

COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscaled /app/tailscaled
COPY --from=docker.io/tailscale/tailscale:stable /usr/local/bin/tailscale /app/tailscale
COPY --from=builder /app/start.sh /app/start.sh

RUN mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale

WORKDIR /app
EXPOSE 3001

CMD ["/app/start.sh"]