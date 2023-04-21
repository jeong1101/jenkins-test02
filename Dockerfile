From openjdk:11-jdk-alpine
COPY my-app2-1.0-SNAPSHOT.jar .
CMD ["java","-jar", "my-app2-1.0-SNAPSHOT.jar"]
