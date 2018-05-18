#!/bin/bash
# Install heketi

if [ "$1" = "" ]
then
    echo "Usage: install_heketi TOPOLOGY_FILE PATH_TO_HEKETI_DEPLOY_SCRIPT"
    exit
fi

TOPOLOGY_FILE=${PWD}/$1
DEPLOY_SCRIPT=$2/gk-deploy

if [ ! -f "$TOPOLOGY_FILE" ]; then
    echo  "ERROR: $TOPOLOGY_FILE topology file does not exists!"
    exit
fi
if [ ! -f "$DEPLOY_SCRIPT" ]; then
    echo  "ERROR: $DEPLOY_SCRIPT script does not exists!"
    exit
fi

ARGS=${@:3}

$DEPLOY_SCRIPT $ARGS "$TOPOLOGY_FILE"