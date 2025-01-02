# Use Keycloak base image
FROM quay.io/keycloak/keycloak:21.1.2 AS builder

# Build Keycloak with custom providers
ENV KC_DB=postgres
ENV KC_DB_URL=jdbc:postgresql://host.docker.internal:5432/postgres
ENV KC_DB_USERNAME=postgres
ENV KC_DB_PASSWORD=postgres
ENV KC_FEATURES=token-exchange
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Create final image
FROM quay.io/keycloak/keycloak:21.1.2
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Copy your custom Keycloak configuration
COPY keycloak-21.1.2/conf/ /opt/keycloak/conf/
COPY keycloak-21.1.2/providers/ /opt/keycloak/providers/
COPY keycloak-21.1.2/themes/ /opt/keycloak/themes/
COPY keycloak-21.1.2/imports/ /opt/keycloak/imports/

# Set permissions
USER root
RUN chown -R keycloak:keycloak /opt/keycloak
USER keycloak

# Build first
RUN /opt/keycloak/bin/kc.sh build

# Expose the default Keycloak port
EXPOSE 8080

WORKDIR /opt/keycloak

# Start with import and migration strategy
CMD /opt/keycloak/bin/kc.sh --verbose import --file /opt/keycloak/imports/sunbird-realm.json && \
    /opt/keycloak/bin/kc.sh start-dev --spi connections-jpa-legacy-migration-strategy=update
