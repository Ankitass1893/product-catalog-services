# Use the official OpenJDK as the base image
FROM openjdk:17-jdk-slim

# Copy the application JAR file into the container
COPY target/product-catalog-dev.jar .

# Add any necessary configuration files (optional)
# Example: If you have an application.properties or application-dev.properties file
#COPY src/main/resources/application-dev.properties /app/config/

# Expose the application port
EXPOSE 8080

# Set environment variables for the "dev" profile
ENV SPRING_PROFILES_ACTIVE=dev

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "product-catalog-dev.jar"]
