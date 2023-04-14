#!/bin/bash

podman run -v /path/to/your/compiler-construction-folder:/home/user/cc \
--userns=keep-id -w /home/user/cc -it cc-toolchain:latest
