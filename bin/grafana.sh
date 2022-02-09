#!/bin/bash -eu
/usr/bin/docker run \
                --name "${1}" \
                -v grafana-data:/var/lib/grafana \
                -v "${HOME}/.grafana-pass:/grafana-pass" \
                --label traefik.http.routers.grafana.entryPoints=port80 \
                --label "traefik.http.routers.grafana.rule=host(\`${GRAFANA_DOMAIN}\`)" \
                --label traefik.http.middlewares.grafana-redirect.redirectScheme.scheme=https \
                --label traefik.http.middlewares.grafana-redirect.redirectScheme.permanent=true \
                --label traefik.http.routers.grafana.middlewares=grafana-redirect \
                --label traefik.http.routers.grafana-ssl.entryPoints=port443 \
                --label "traefik.http.routers.grafana-ssl.rule=host(\`${GRAFANA_DOMAIN}\`)" \
                --label traefik.http.routers.grafana-ssl.tls=true \
                --label traefik.http.routers.grafana-ssl.tls.certResolver=letsencrypt \
                --label traefik.http.routers.grafana-ssl.service=grafana-ssl \
                --label traefik.http.services.grafana-ssl.loadBalancer.server.port=3000 \
                -e GF_SERVER_ROOT_URL="https://${GRAFANA_DOMAIN}" \
                -e GF_SERVER_DOMAIN="${GRAFANA_DOMAIN}" \
                -e GF_USERS_ALLOW_SIGN_UP=false \
                -e GF_SECURITY_ADMIN_USER=admin \
                -e GF_SECURITY_ADMIN_PASSWORD__FILE=/grafana-pass \
                -e GF_AUTH_ANONYMOUS_ENABLED=true \
                --network grafana-graphite \
                grafana/grafana
