#!/usr/bin/env bash
set -e
set -x

NODE_NAME=es-s2-localdisk
CONTAINER_NAME=elasticsearch-1
VOLUME=/docker/elasticsearch-1
CLUSTER_NAME=rednut-dev


docker rm -f $CONTAINER_NAME || echo "not a container yet: '$CONTAINER_NAME'"


docker run \
        -d \
        --name="$CONTAINER_NAME" \
        -p 127.0.0.1:9200:9200 \
        -p 127.0.0.1:9300:9300 \
        -v $VOLUME:/data \
        rednut/elasticsearch \
        /elasticsearch/bin/elasticsearch \
		-Des.config=/data/elasticsearch.yml \
                -Des.cluster.name=$CLUSTER_NAME \
		-Des.node.name=$NODE_NAME
