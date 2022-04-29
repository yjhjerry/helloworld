# syntax=docker/dockerfile:1
FROM maven:3.5-jdk-8 AS build
WORKDIR /app
COPY src /app/src
COPY pom.xml /app
RUN mvn -f /app/pom.xml clean package -DskipTests

#
# Package stage
#
FROM openjdk:8-jre-slim
COPY --from=build /app/target/*.jar /usr/local/lib/helloworld.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/helloworld.jar"]
