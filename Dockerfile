# Use Keycloak base image
FROM quay.io/keycloak/keycloak:26.0 as builder

# Configure a non-production grade database vendor for the build
ENV KC_DB=postgres
ENV KC_FEATURES=token-exchange
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_CACHE=local
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false

# Build optimized version for production
RUN /opt/keycloak/bin/kc.sh build --db=postgres

# Create final image
FROM quay.io/keycloak/keycloak:26.0
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Copy your custom Keycloak configuration
COPY keycloak-21.1.2/conf/ /opt/keycloak/conf/
COPY keycloak-21.1.2/providers/ /opt/keycloak/providers/
COPY keycloak-21.1.2/themes/ /opt/keycloak/themes/
COPY keycloak-21.1.2/imports/ /opt/keycloak/imports/

ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/postgres
ENV KC_DB_USERNAME=postgres
ENV KC_DB_PASSWORD=postgres
ENV KC_HOSTNAME=localhost
ENV KC_PROXY=edge

USER 1000

ENTRYPOINT [ "/opt/keycloak/bin/kc.sh", "start", "--optimized" ]
