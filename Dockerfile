#Download image from artifactory
ARG REGISTRY
FROM openjdk:11-jdk
#FROM $REGISTRY/openjdk:11-jdk

WORKDIR /app

#Define ARG Again -ARG variables declared before the first FROM need to be declered again
ARG REGISTRY
MAINTAINER Elad Hirsch

# Add downloaded artifacts from jfrog cli to the image
RUN ls -lR
ADD ./client.tgz .
ADD ./server.jar .

# RUN curl $REGISTRY/libs-release-local/com/jfrog/backend/1.0.0/backend-1.0.0.jar --output server.jar
# RUN curl $REGISTRY/npm-local/frontend/-/frontend-3.0.0.tgz --output client.tgz

#Extract vue app
RUN ls -lR
#RUN tar -xzf client.tgz
#RUN rm client.tgz

# Set JAVA OPTS + Static file location
ENV STATIC_FILE_LOCATION="/app/package/target/dist/"
# ENV GO_SERVICE="127.0.0.1"
ENV JAVA_OPTS=""

# Fire up our Spring Boot app
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Dspring.profiles.active=remote -Djava.security.egd=file:/dev/./urandom -jar /app/server.jar" ]
