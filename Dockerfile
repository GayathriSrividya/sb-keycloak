# Use Keycloak base image
FROM quay.io/keycloak/keycloak:21.1.2 AS builder

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

# Set environment variables for proper configuration
ENV KC_PROXY=edge
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_HTTP_RELATIVE_PATH=/auth
ENV KC_SPI_LOGIN_PROTOCOL_OPENID_CONNECT_LEGACY_LOGOUT_REDIRECT_URI=true

# Build first
RUN /opt/keycloak/bin/kc.sh build

# Expose the default Keycloak port
EXPOSE 8080

WORKDIR /opt/keycloak

# Start Keycloak with proper configuration
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized", "--import-realm", "--spi-connections-jpa-legacy-migration-strategy=update"]