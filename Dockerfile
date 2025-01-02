# Use Ubuntu base image
FROM ubuntu:22.04

# Install OpenJDK (required for Keycloak)
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Create directory for mounting
RUN mkdir -p /opt/keycloak

# Expose the default Keycloak port
EXPOSE 8080

# Set working directory
WORKDIR /opt/keycloak

# Start Keycloak in development mode
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
