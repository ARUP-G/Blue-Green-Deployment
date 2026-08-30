# Stage 1: Build JAR
FROM maven:3.9.9-amazoncorretto-21-alpine AS builder

WORKDIR /usr/src/app
COPY . .  

RUN mvn clean package -DskipTests
    
# Stage 2: Run Application
FROM eclipse-temurin:21-jre-jammy-alpine

EXPOSE 8080
ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME

COPY --from=builder /usr/src/app/target/*.jar app.jar

CMD ["java", "-jar", "app.jar"]
