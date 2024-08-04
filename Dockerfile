# Use Eclipse Temurin JRE 17 as the base image
FROM docker.io/library/eclipse-temurin:17-jre@sha256:34cc39fcd17383dfbe9b1e1ff29efb89c770913698be71db32e7e4be25bce2e0 AS base

# Create a working directory
WORKDIR /app

# Build stage
FROM base AS build

# Set the working directory in the build stage
WORKDIR /app

# Copy the application source code to the container
COPY . /app

# Give execution permissions to the mvnw script
RUN chmod +x ./mvnw

# Package the application without running tests
RUN ./mvnw package -DskipTests

# Final stage
FROM base AS final

# Set the working directory in the final stage
WORKDIR /app

# Copy the built application from the build stage
COPY --from=build /app/target/*.jar ./app.jar

# Command to run the application
CMD ["java", "-jar", "./app.jar"]
