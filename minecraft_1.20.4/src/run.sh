#!/bin/sh

pipe=/tmp/minecraft.input

rm -f $pipe
mkfifo $pipe

shutdown() {
    date
    echo "Stopping minecraft server"
    echo 'stop' >$pipe
}

echo 'Set EULA'
echo "eula=$EULA" > /opt/minecraft/eula.txt

echo 'Create server.properties file'
echo -e "\
enable-jmx-monitoring=false\n\
level-seed=$LEVEL_SEED\n\
rcon.port=25575\n\
enable-command-block=$ENABLE_COMMAND_BLOCK\n\
gamemode=$GAMEMODE\n\
enable-query=false\n\
generator-settings={}\n\
enforce-secure-profile=$ENFORCE_SECURE_PROFILE\n\
level-name=world\n\
motd=$MOTD\n\
query.port=25565\n\
pvp=$PVP\n\
generate-structures=$GENERATE_STRUCTURES\n\
max-chained-neighbor-updates=1000000\n\
difficulty=$DIFFICULTY\n\
network-compression-threshold=256\n\
require-resource-pack=false\n\
max-tick-time=60000\n\
max-players=$MAX_PLAYERS\n\
use-native-transport=true\n\
enable-status=true\n\
online-mode=$ONLINE_MODE\n\
allow-flight=$ALLOW_FLIGHT\n\
broadcast-rcon-to-ops=true\n\
view-distance=$VIEW_DISTANCE\n\
resource-pack-prompt=\n\
server-ip=$SERVER_IP\n\
allow-nether=$ALLOW_NETHER\n\
server-port=25565\n\
enable-rcon=false\n\
sync-chunk-writes=true\n\
op-permission-level=4\n\
prevent-proxy-connections=false\n\
hide-online-players=false\n\
resource-pack=\n\
entity-broadcast-range-percentage=100\n\
simulation-distance=$SIMULATION_DISTANCE\n\
player-idle-timeout=0\n\
rcon.password=\n\
force-gamemode=false\n\
rate-limit=0\n\
hardcore=$HARDCORE\n\
white-list=$WHITE_LIST\n\
broadcast-console-to-ops=true\n\
previews-chat=false\n\
spawn-npcs=$SPAWN_NPCS\n\
spawn-animals=$SPAWN_ANIMALS\n\
function-permission-level=2\n\
level-type=minecraft\:normal\n\
text-filtering-config=\n\
spawn-monsters=$SPAWN_MONSTERS\n\
enforce-whitelist=$ENFORCE_WHITELIST\n\
resource-pack-sha1=\n\
spawn-protection=$SPAWN_PROTECTION\n\
max-world-size=29999984\n\
" > /opt/minecraft/server.properties

trap "shutdown" HUP INT QUIT ABRT KILL ALRM TERM TSTP

echo 'Starting minecraft server'
tail -f $pipe | java "-Xms$JAVA_HEAP_MIN" "-Xmx$JAVA_HEAP_MAX" -jar "/opt/minecraft/server.jar" &

./minecraft "whitelist add $ADMIN"
./minecraft "op $ADMIN"

while [ "$(pidof java)" != "" ]
do
    echo "Shutting down ..."
    wait "$(pidof java)"
done
