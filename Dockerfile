FROM jelastic/maven:3.9.5-openjdk-21 AS build
COPY /src /src
COPY pom.xml /
RUN mvn -f pom.xml clean package

FROM openjdk:21-jdk-slim
COPY --from=build /target/*.jar application.jar
EXPOSE 8082
ENTRYPOINT ["java", "-jar", "application.jar"]