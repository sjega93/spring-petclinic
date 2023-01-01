# Build the application first using Maven
FROM  maven:latest as build
WORKDIR /app
COPY . .
RUN mvn install

# Inject the JAR file into a new container to keep the file small
FROM openjdk:latest
WORKDIR /app
COPY --from=build /app/target/spring-petclinic-3.0.0-SNAPSHOT.jar /app/app.jar
EXPOSE 8081
ENTRYPOINT ["sh", "-c"]
CMD ["java -jar app.jar"]
