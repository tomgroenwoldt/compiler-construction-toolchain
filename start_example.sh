#!/bin/bash

CONTAINER_NAME=cc-toolchain

if $(podman container exists $CONTAINER_NAME); then
  podman start $CONTAINER_NAME && podman attach $CONTAINER_NAME
else
  podman run \
  --name $CONTAINER_NAME \
  -v /path/to/your/shared/folder:/home/user/cc \
  --userns=keep-id \
  -w /home/user/cc \
  -it cc-toolchain:latest
fi
