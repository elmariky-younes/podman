#démarrer le controleur et le brokeur kafka en mode kraft
```bash
./start-ctrl-broker-podman.sh
```
#arrêter le controleur et le brokeur kafka en mode kraft
```bash
./stop-kafka-podman.sh
```

#créer le topic avec podman
```bash
podman exec kafka-broker /opt/kafka/bin/kafka-topics.sh \
  --create \                            
  --topic my-test-topic \
  --bootstrap-server kafka-broker:9093 \
  --partitions 3 \
  --replication-factor 1
```
#produire dans le topic
```bash
./kafka-console-producer.sh --topic my-test-topic --bootstrap-server kafka-broker:9093
```
#consume dans le topic
```bash
./kafka-console-consumer.sh --bootstrap-server kafka-broker:9093 --topic my-test-topic --from-beginning
```