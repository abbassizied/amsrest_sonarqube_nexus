# Use official Maven image as build stage
FROM maven:3.8.4-openjdk-17 AS build

# Set the working directory to /app
WORKDIR /app

# Copy the pom.xml and ssrc directories to the container
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean install -DskipTests


# Use official OpenJDK image as runtime stage
FROM openjdk:17-jdk-alpine

# Set the working directory to /app
WORKDIR /app

# Copy the executable JAR file from the build stage to the runtime stage

COPY --from=build /app/target/ams_rest-0.0.1-SNAPSHOT.jar .

# Expose the port that the application listens on
EXPOSE 8080

# Set the command to run the application
CMD ["java", "-jar", "ams_rest-0.0.1-SNAPSHOT.jar"]
