#!/bin/bash
# Get GlusterFS cluster topology for use with heketi

# Get settings from the file
source settings

#
gcloud config set project ${PROJECT}

node_tpl=$(cat heketi-node.tpl)
topology_tpl=$(cat heketi-topology.tpl)
topology=""
separator=""
# Get servers info
for (( i=1; i<=${COUNT}; i++ ))
do
     # Get the compute instances
    NODE_EXTERNAL_IP=$(gcloud compute instances describe ${SERVER}-${i} --zone ${REGION}-${ZONES[$i-1]} \
        --format='value(networkInterfaces[0].accessConfigs[0].natIP)')
    NODE_INTERNAL_IP=$(gcloud compute instances describe ${SERVER}-${i} --zone ${REGION}-${ZONES[$i-1]} \
        --format='value(networkInterfaces[0].networkIP)')
#    NODE_NAME=$(gcloud compute instances describe ${SERVER}-${i} --zone ${REGION}-${ZONES[$i-1]} --format='value(name)')
    printf -v NODE "$node_tpl" "$NODE_EXTERNAL_IP" "$NODE_INTERNAL_IP" $i

    topology+=$separator$NODE
    separator=","
done

printf "$topology_tpl" "$topology"

