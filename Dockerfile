ARG JAVA_VERSION=8
FROM eclipse-temurin:${JAVA_VERSION}-jre-alpine

WORKDIR /data

ENV MC_ARGS=nogui
ENV SERVER_JAR=/data/server.jar
ENV MC_PIPE=/tmp/minecraft.stdin

COPY docker/mc /usr/local/bin/mc
COPY docker/minecraft-entrypoint /usr/local/bin/minecraft-entrypoint

RUN chmod +x /usr/local/bin/mc /usr/local/bin/minecraft-entrypoint

ENTRYPOINT ["/bin/sh", "/usr/local/bin/minecraft-entrypoint"]
