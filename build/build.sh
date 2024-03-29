#!/bin/sh

# Build inside docker container
docker run -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/.docker/config.json:/root/.docker/config.json -v $(pwd):/src -v $HOME/.m2:/root/.m2 maven:3-jdk-11 /src/build/maven.sh
