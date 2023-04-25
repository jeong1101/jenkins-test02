FROM openjdk:7u111-jdk-alpine
EXPOSE 8080
ADD target/my-app2-1.0-SNAPSHOT.jar my-app2-1.0-SNAPSHOT.ja
ENTRYPOINT ["java","-jar", "my-app2-1.0-SNAPSHOT.jar"]
