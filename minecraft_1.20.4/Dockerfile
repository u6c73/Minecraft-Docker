FROM debian:stable

RUN apt-get update && apt-get install default-jre default-jdk -y

STOPSIGNAL SIGTERM

#ARG JAR_URL=https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar

ENV JAVA_HEAP_MIN=1G \
    JAVA_HEAP_MAX=4G

ENV EULA=false \
    ALLOW_FLIGHT=false \
    ALLOW_NETHER=true \
    DIFFICULTY=normal \
    ENABLE_COMMAND_BLOCK=false \
    ENFORCE_SECURE_PROFILE=true \
    ENFORCE_WHITELIST=true \
    GAMEMODE=survival \
    GENERATE_STRUCTURES=true \
    HARDCORE=false \
    LEVEL_SEED= \
    MAX_PLAYERS=5 \
    MOTD=A\ Minecraft\ Server \
    ONLINE_MODE=true \
    PVP=true \
    SERVER_IP= \
    SIMULATION_DISTANCE=16 \
    SPAWN_ANIMALS=true \
    SPAWN_MONSTERS=true \
    SPAWN_NPCS=true \
    SPAWN_PROTECTION=0 \
    VIEW_DISTANCE=16 \
    WHITE_LIST=true \
    ADMIN=

WORKDIR /opt/minecraft

COPY /src /opt/minecraft
RUN  chmod +x /opt/minecraft/run.sh
RUN  chmod +x /opt/minecraft/minecraft

#Server
EXPOSE 25565
#RCON
EXPOSE 25575

ENTRYPOINT [ "/opt/minecraft/run.sh" ]