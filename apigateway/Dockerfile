# Use OpenJDK 23 base image
FROM openjdk:23-jdk-slim

# Set working directory
WORKDIR /app

# Copy JAR file from target folder
COPY target/*.jar app.jar

# Expose API Gateway port (change if your gateway runs on another port)
EXPOSE 8080

# Run the Spring Boot JAR
ENTRYPOINT ["java", "-jar", "app.jar"]
