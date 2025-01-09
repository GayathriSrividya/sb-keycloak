#!/bin/bash

# Create backup directory
mkdir -p keycloak-backup/2025-01-09

# Backup Service
kubectl get service keycloak -n sunbird -o yaml > keycloak-backup/2025-01-09/keycloak-service.yaml

# Backup Deployment
kubectl get deployment keycloak -n sunbird -o yaml > keycloak-backup/2025-01-09/keycloak-deployment.yaml

# Backup ConfigMaps
kubectl get configmap keycloak -n sunbird -o yaml > keycloak-backup/2025-01-09/keycloak-cm.yaml
kubectl get configmap keycloak-env -n sunbird -o yaml > keycloak-backup/2025-01-09/keycloak-env-cm.yaml
kubectl get configmap keycloak-key -n sunbird -o yaml > keycloak-backup/2025-01-09/keycloak-key-cm.yaml
kubectl get configmap keycloak-kids-keys -n sunbird -o yaml > keycloak-backup/2025-01-09/keycloak-kids-keys-cm.yaml
kubectl get configmap keycloak-kids-keys-env -n sunbird -o yaml > keycloak-backup/2025-01-09/keycloak-kids-keys-env-cm.yaml
