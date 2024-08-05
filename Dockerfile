# First stage: build the application
FROM docker.io/library/maven:3.8.5-openjdk-17-slim AS build

# Set the working directory in the build stage
WORKDIR /app

# Copy the application source code to the container
COPY . /app
RUN ./mvnw clean install
# Give execution permissions to the mvnw script
RUN chmod +x ./mvnw

# Package the application without running tests
RUN ./mvnw package -DskipTests

# Second stage: create the runtime image
FROM docker.io/library/eclipse-temurin:17-jre

# Set the working directory in the final stage
WORKDIR /app

# Copy the built application from the build stage
COPY --from=build /app/target/*.jar ./app.jar

# Command to run the application
CMD ["java", "-jar", "./app.jar"]
