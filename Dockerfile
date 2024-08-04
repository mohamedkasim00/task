# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Package the application
RUN ./mvnw package

# Make port 8080 available to the world outside this container
EXPOSE 8080
CMD ["/bin/sh", "-c", "java -jar /app/target/*.jar"]
