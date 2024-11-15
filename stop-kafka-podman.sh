#!/bin/bash

# Charger les variables d'environnement
source .env

# Arrêter les conteneurs Kafka (controller et broker)
echo "Arrêt du contrôleur Kafka (${CONTROLLER_HOSTNAME})..."
podman stop ${CONTROLLER_HOSTNAME}

echo "Arrêt du broker Kafka (${BROKER_HOSTNAME})..."
podman stop ${BROKER_HOSTNAME}

# Supprimer les conteneurs après l'arrêt (facultatif)
echo "Suppression des conteneurs..."
podman rm ${CONTROLLER_HOSTNAME}
podman rm ${BROKER_HOSTNAME}

# Optionnel : supprimer le réseau Kafka si plus nécessaire
echo "Suppression du réseau ${NETWORK_NAME}..."
podman network rm ${NETWORK_NAME}

echo "Kafka est arrêté et nettoyé."
