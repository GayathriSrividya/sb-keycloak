# Use a specific version of Keycloak
FROM quay.io/keycloak/keycloak:23.0.6

# Set the working directory
WORKDIR /opt/keycloak

# Environment variables for configuration
ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_FEATURES=token-exchange
ENV KC_HTTP_RELATIVE_PATH=/auth
ENV KEYCLOAK_ADMIN=admin
ENV KEYCLOAK_ADMIN_PASSWORD=admin

# Create necessary directories
USER root
RUN mkdir -p /opt/keycloak/providers
RUN mkdir -p /opt/keycloak/themes/sunbird
RUN chown -R keycloak:keycloak /opt/keycloak/providers
RUN chown -R keycloak:keycloak /opt/keycloak/themes/sunbird

# Switch back to keycloak user
USER keycloak

# Copy custom provider JAR and dependencies
COPY --chown=keycloak:keycloak opt/jboss/keycloak/providers/keycloak-email-phone-autthenticator-1.0-SNAPSHOT.jar /opt/keycloak/providers/
COPY --chown=keycloak:keycloak opt/jboss/keycloak/providers/dependencies.txt /opt/keycloak/providers/

# Copy custom Sunbird theme
COPY --chown=keycloak:keycloak opt/jboss/keycloak/themes/sunbird /opt/keycloak/themes/sunbird/

# Build Keycloak with dependencies
RUN /opt/keycloak/bin/kc.sh build --db=postgres

# Expose the default Keycloak port
EXPOSE 8080

# Start Keycloak in development mode
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
