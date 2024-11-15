#!/bin/bash

# Charger les variables d'environnement
source .env

# Créer le réseau pour Kafka si ce n'est pas déjà fait
#podman network inspect ${NETWORK_NAME} > /dev/null 2>&1 || podman network create ${NETWORK_NAME}


# Démarrer le broker Kafka
echo "Démarrage du broker Kafka..."
podman run -d --name ${BROKER_HOSTNAME} \
  --network=${NETWORK_NAME} \
  -e KAFKA_CLUSTER_ID=${CLUSTER_ID} \
  -e KAFKA_PROCESS_ROLES=broker \
  -e KAFKA_NODE_ID=${BROKER_ID} \
  -e KAFKA_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT \
  -e KAFKA_LISTENERS=PLAINTEXT://${BROKER_HOSTNAME}:${BROKER_PORT} \
  -e KAFKA_INTER_BROKER_LISTENER_NAME=PLAINTEXT \
  -e KAFKA_LOG_DIRS=${BROKER_LOG_DIR} \
  -e KAFKA_CONTROLLER_QUORUM_VOTERS=${CONTROLLER_ID}@${CONTROLLER_HOSTNAME}:${CONTROLLER_PORT} \
  -e KAFKA_CONTROLLER_LISTENER_NAMES=CONTROLLER \
  -e KAFKA_KRAFT_MODE=true \
  -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
  -e KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR=1 \
  -e KAFKA_TRANSACTION_STATE_LOG_MIN_ISR=1 \
  -e KAFKA_LOG_RETENTION_MS=259200000 \
  -v kafka-broker-data:${BROKER_LOG_DIR} \
  ${KAFKA_IMAGE}

echo "broker Kafka est démarré avec succès en mode KRaft."
