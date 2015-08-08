#!/usr/bin/env bash
set -e
set -x

NODE_NAME=server2
CONTAINER_NAME=elasticsearch
IMAGE=rednut/elasticsearch
VOLUME=/docker/elasticsearch
CLUSTER_NAME=rednut-dev
RAM=4192M
IP=10.0.10.2
CIDR="/24"

docker stop $CONTAINER_NAME || echo "cannot stop a non running $CONTAINER_NAME"
docker rm -f $CONTAINER_NAME || echo "not a container yet: '$CONTAINER_NAME'"


sudo /usr/local/bin/weave run $IP$CIDR \
        -d \
        --name="$CONTAINER_NAME" \
		-p 10.9.1.9:9200:9200 \
        -p 127.0.0.1:9200:9200 \
        -p 127.0.0.1:9300:9300 \
        -v $VOLUME:/data \
		-e ES_HEAP_SIZE=$RAM \
		--privileged \
        $IMAGE \
        /elasticsearch/bin/elasticsearch -Xmx${RAM} -Xms${RAM} \
		-Des.config=/data/elasticsearch.yml \
		-Des.cluster.name=$CLUSTER_NAME \
		-Des.node.name=$NODE_NAME \
		-Des.network.host=$IP \
		-Des.discovery.zen.ping.multicast.address=$IP \
		-Des.network.bind_host=0.0.0.0 \
\
&& docker logs -f --tail=2000 $CONTAINER_NAME
