# Use OpenJDK 23 slim image
FROM openjdk:23-jdk-slim

# Set working directory inside container
WORKDIR /app

# Copy the built jar file into container
COPY target/*.jar app.jar

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]
