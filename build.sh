#!/bin/bash
set -euo pipefail

rm -rf logs packages
docker run --privileged --rm \
    -v $(pwd):/src \
    -v "$HOME/synology-signing-key.asc:/signing-key.asc" \
    -w /src \
    kastelo/synology-build:latest \
    ./build-in-docker.sh
