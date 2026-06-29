# craftbox - A minimal Minecraft Java server container image

craftbox is a small container image for running a Minecraft server jar with **Temurin JRE on Alpine**.

The image does not include a Minecraft server jar. Mount your server directory at `/data` and provide `/data/server.jar`.

## docker-compose.yml example

```yaml
services:
  craftbox:
    image: ghcr.io/rftpnet/craftbox:java25
    container_name: craftbox
    restart: on-failure
    ports:
      - "25565:25565/tcp"
    volumes:
      - ./data:/data
    environment:
      JAVA_FLAGS: >-
        -Xmx1024M
        -XX:+UseG1GC
        -XX:MaxGCPauseMillis=200
        -XX:+DisableExplicitGC
        -XX:+PerfDisableSharedMem
        -XX:MaxMetaspaceSize=128M
      MC_ARGS: "nogui"
    stop_signal: SIGTERM
    stop_grace_period: 5m
```

Required:

- `JAVA_FLAGS`: Java flags for heap and GC tuning.
- `/data/server.jar`: the Minecraft server jar.

## Console Commands

The image includes `mc`, a small helper that writes to the server stdin pipe.

```sh
docker exec craftbox mc say hello
docker exec craftbox mc stop
```

The container entrypoint sends `stop` to the Minecraft process on `SIGTERM`, then waits for the server to exit. Use a Compose `stop_grace_period` long enough for world saving.

## Supported tags and recommended Java versions

| Tag | Java runtime | Minecraft version |
| --- | --- | --- |
| `java8` | Temurin JRE 8 on Alpine | 1.16.5 and older |
| `java17` | Temurin JRE 17 on Alpine | 1.17 - 1.20.4 |
| `java21` | Temurin JRE 21 on Alpine | 1.20.5 - 1.21.11 |
| `java25` | Temurin JRE 25 on Alpine | 26.1 and newer |

## Release Model

The release workflow checks the supported Temurin Alpine bases regularly. When any base changes, it rebuilds and publishes all supported Java variants together.

---
<p align="center">craftbox is not an official Mojang, Microsoft, or Minecraft project.</p>
