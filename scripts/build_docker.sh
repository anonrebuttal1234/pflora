#!/bin/bash

PARENT=stablebaselines/stable-baselines3

TAG=yourname/bpref
VERSION=1.5.1a6

if [[ ${USE_GPU} == "True" ]]; then
  PARENT="${PARENT}:${VERSION}"
else
  PARENT="${PARENT}-cpu:${VERSION}"
  TAG="${TAG}-cpu"
fi

docker build --build-arg PARENT_IMAGE=${PARENT} --build-arg USE_GPU=${USE_GPU} -t ${TAG}:${VERSION} . -f docker/Dockerfile
docker tag ${TAG}:${VERSION} ${TAG}:latest

if [[ ${RELEASE} == "True" ]]; then
  docker push ${TAG}:${VERSION}
  docker push ${TAG}:latest
fi

sleep 10