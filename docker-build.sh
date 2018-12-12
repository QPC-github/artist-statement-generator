#!/usr/bin/env bash

IMAGE=$1

DOCKER=docker
#DOCKER=nvidia-docker

if [[ -z "$IMAGE" ]]; then
echo "Usage: $0 <docker-image-name>" >&2
echo >&2
echo "where <docker-image-name> has a corresponding *.Dockerfile in docker/"
exit 1
fi

df="docker/$IMAGE/Dockerfile"
if [[ ! -f "$df" ]]; then
  echo "No such dockerfile: $df" >&2
  exit -1
fi

KEYFILE=$HOME/keys/shopify-data-ml-platform-exp.json
TMPKEY=tmp-google-auth-key.json

cp ${KEYFILE} docker/${IMAGE}/${TMPKEY}
${DOCKER} build --build-arg GCLOUD_AUTH_KEY="${TMPKEY}" \
          docker/${IMAGE} -t "$IMAGE"

rm docker/${IMAGE}/${TMPKEY}


