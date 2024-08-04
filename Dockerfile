# Build stage
FROM maven:3.8.5-openjdk-17-slim AS build
# Set the working directory
WORKDIR /app
COPY . /app

# Build the application
RUN ./mvnw package -DskipTests

# Run stage
FROM eclipse-temurin:17-jre

# Set the working directory
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/*.jar /app/app.jar

# Expose the port the application runs on
EXPOSE 8080

# Define the entry point for the container
CMD ["java", "-jar", "/app/app.jar"]
