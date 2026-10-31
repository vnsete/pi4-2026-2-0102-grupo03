FROM maven:3.9-eclipse-temurin-21 AS build
ARG MODULE
WORKDIR /app
COPY ${MODULE}/pom.xml ./pom.xml
RUN mvn -B dependency:go-offline
COPY ${MODULE}/src ./src
RUN mvn -B -DskipTests package dependency:copy-dependencies -DoutputDirectory=target/dependency
RUN mkdir -p /app/target/dependency

FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/classes ./classes
COPY --from=build /app/target/dependency ./lib
