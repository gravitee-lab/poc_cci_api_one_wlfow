#!/bin/bash

# docker pull quay.io/gravitee-lab/pull-request-bot

export QUAY_BOT_USERNAME=${QUAY_BOT_USERNAME:-'gravitee-lab+graviteebot'}
export QUAY_BOT_SECRET=${QUAY_BOT_SECRET:-'xxxxxxxxxx'}

# docker login -u="${QUAY_BOT_USERNAME}" -p="${QUAY_BOT_SECRET}" quay.io

export DOCKER_TAG=${DOCKER_TAG:-'0.0.1'}

docker build -t pull-request-bot:${DOCKER_TAG} oci/

docker tag pull-request-bot:${DOCKER_TAG} quay.io/gravitee-lab/pull-request-bot:${DOCKER_TAG}

docker push quay.io/gravitee-lab/pull-request-bot:${DOCKER_TAG}
