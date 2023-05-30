# Use a suitable Kafka base image
FROM confluentinc/cp-kafka:latest

# Set environment variables
ENV KAFKA_BROKER_ID=1
ENV KAFKA_LISTENERS=PLAINTEXT://:9092
ENV KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://localhost:9092
ENV KAFKA_LOG_DIRS=/kafka/logs

# Install Kafka binaries
RUN apt-get update && apt-get install -y wget
RUN wget https://archive.apache.org/dist/kafka/2.8.0/kafka_2.13-2.8.0.tgz
RUN tar -xzf kafka_2.13-2.8.0.tgz -C /opt

# Configure Kafka broker 1
COPY server.properties /opt/kafka_2.13-2.8.0/config/server.properties
RUN sed -i "s|{{KAFKA_BROKER_ID}}|$KAFKA_BROKER_ID|g" /opt/kafka_2.13-2.8.0/config/server.properties
RUN sed -i "s|{{KAFKA_LISTENERS}}|$KAFKA_LISTENERS|g" /opt/kafka_2.13-2.8.0/config/server.properties
RUN sed -i "s|{{KAFKA_ADVERTISED_LISTENERS}}|$KAFKA_ADVERTISED_LISTENERS|g" /opt/kafka_2.13-2.8.0/config/server.properties
RUN sed -i "s|{{KAFKA_LOG_DIRS}}|$KAFKA_LOG_DIRS|g" /opt/kafka_2.13-2.8.0/config/server.properties

# Expose Kafka port
EXPOSE 9092

# Start Kafka broker 1
CMD ["/opt/kafka_2.13-2.8.0/bin/kafka-server-start.sh", "/opt/kafka_2.13-2.8.0/config/server.properties"]
