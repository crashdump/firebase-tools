FROM node:lts-slim
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.name="firebase-tools" \
      org.label-schema.description="Firebase CLI"

ARG FIREBASE_TOOLS_VERSION
ENV FIREBASE_TOOLS_VERSION ${FIREBASE_TOOLS_VERSION}

EXPOSE 4000
EXPOSE 5000
EXPOSE 5001
EXPOSE 8080
EXPOSE 8085
EXPOSE 9000
EXPOSE 9005
EXPOSE 9099
EXPOSE 9199

RUN apt-get update && \
    apt-get install -y autoconf automake bash g++ libtool make curl openjdk-17-jre-headless python3
RUN npm install -g firebase-tools@${FIREBASE_TOOLS_VERSION} typescript && \
    npm cache clean --force
RUN firebase setup:emulators:ui && \
    firebase setup:emulators:firestore && \
    firebase setup:emulators:pubsub && \
    firebase setup:emulators:storage && \
    firebase -V && \
    java -version

VOLUME /opt/.cache
WORKDIR /opt
ENTRYPOINT ["/usr/local/bin/firebase"]