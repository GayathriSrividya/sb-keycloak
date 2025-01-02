# Use Keycloak base image
FROM quay.io/keycloak/keycloak:21.1.2 as builder

# Build Keycloak with custom providers
ENV KC_DB=postgres
ENV KC_FEATURES=token-exchange
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV sunbird_user_service_base_url=http://localhost:9000

# Create directories
USER root
RUN mkdir -p /opt/keycloak/imports
RUN mkdir -p /opt/keycloak/providers
RUN chown -R keycloak:keycloak /opt/keycloak
USER keycloak

# Copy realm, providers and config
COPY keycloak-21.1.2/imports/sunbird-realm.json /opt/keycloak/imports/
COPY keycloak-21.1.2/providers/keycloak-email-phone-authenticator-1.0-SNAPSHOT.jar /opt/keycloak/providers/
COPY keycloak-21.1.2/conf/keycloak.conf /opt/keycloak/conf/

# Import realm and build
RUN /opt/keycloak/bin/kc.sh --verbose import --file /opt/keycloak/imports/sunbird-realm.json
RUN /opt/keycloak/bin/kc.sh build

# Create final image
FROM quay.io/keycloak/keycloak:21.1.2
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Set permissions
USER root
RUN chown -R keycloak:keycloak /opt/keycloak
USER keycloak

# Expose the default Keycloak port
EXPOSE 8080

WORKDIR /opt/keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev", "--spi", "connections-jpa-legacy-migration-strategy=update"]
