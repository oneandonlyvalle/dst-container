#!/bin/bash
if [[ -z "$CLUSTER_TOKEN" ]]
then
  echo "You must give a CLUSTER_TOKEN"
  exit 1
fi

echo $CLUSTER_TOKEN > /home/dst/.klei/DoNotStarveTogether/$CLUSTER_NAME/cluster_token.txt

cd /home/dst/server_dst/bin

# start first server
./dontstarve_dedicated_server_nullrenderer -console -cluster $CLUSTER_NAME -shard Master &

#start second server
./dontstarve_dedicated_server_nullrenderer -console -cluster $CLUSTER_NAME -shard Caves &

# Wait for any process to exit
wait -n
  
# Exit with status of process that exited first
exit $?
