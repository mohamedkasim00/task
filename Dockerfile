# Build stage
FROM maven:3.8.5-openjdk-17-slim AS build

# Set the working directory
WORKDIR /app
# Set the Maven version
ENV MAVEN_VERSION 3.9.4

# Install Maven
RUN apt-get update && \
    apt-get install -y wget && \
    wget http://www.eu.apache.org/dist/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar -xzf apache-maven-${MAVEN_VERSION}-bin.tar.gz -C /opt && \
    ln -s /opt/apache-maven-${MAVEN_VERSION} /opt/maven && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables for Maven
ENV MAVEN_HOME /opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH
# Set the working directory
WORKDIR /app
COPY ..

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
