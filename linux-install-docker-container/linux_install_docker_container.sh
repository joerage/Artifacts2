#!/bin/bash

set -e

###
# Arguments:
#
# $1    Container name
# $2    Image name
# $3    Docker run options
# $4    Additional image arguments
#
###

# Check if docker is already installed.
docker -v
installationStatus=$(echo $?)

if [ $installationStatus -eq 127 ] ; then
    wget -qO- https://get.docker.com/ | sh
fi

if [ -z "$1" ] ; then
    NAME_ARG=
else
    NAME_ARG=" --name $1"
fi

# Docker run syntax: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
#                               |__1-3__| |_2_| |_______ 4_______|

cmd="docker run $NAME_ARG $3 -d $2 $4"

echo "Running command: $cmd"
eval $cmd