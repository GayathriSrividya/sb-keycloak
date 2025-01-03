# Use Keycloak base image
FROM quay.io/keycloak/keycloak:26.0

# Copy your custom Keycloak configuration
COPY keycloak-21.1.2/conf/ /opt/keycloak/conf/
COPY keycloak-21.1.2/providers/ /opt/keycloak/providers/
COPY keycloak-21.1.2/themes/ /opt/keycloak/themes/
COPY keycloak-21.1.2/imports/ /opt/keycloak/imports/

# Runtime configuration
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/postgres
ENV KC_DB_USERNAME=postgres
ENV KC_DB_PASSWORD=postgres
ENV KC_HOSTNAME=localhost
ENV KC_FEATURES=token-exchange
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

USER 1000

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
