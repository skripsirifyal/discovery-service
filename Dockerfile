FROM gradle:7.5-jdk11-alpine as builder
COPY --chown=gradle:gradle . /home/gradle/src/discovery-service
WORKDIR /home/gradle/src/discovery-service
RUN gradle bootJar --no-daemon --stacktrace

FROM eclipse-temurin:11-alpine

ARG JAR_FILE=/build/libs/*.jar
COPY --from=builder /home/gradle/src/discovery-service/build/libs/*.jar discovery-service-0.0.1.jar

CMD ["java", "-jar", "/discovery-service-0.0.1.jar"]