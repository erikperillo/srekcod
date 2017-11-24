#!/bin/bash

user="erikperillo"
img_name="$(cat NAME)"
tag="latest"

#binds this directory to /code inside container
host_code_dir="/home/erik/code/"
host_data_dir="/home/erik/data"

#getting command to run. runs CMD (from Dockerfile) if nothing is given
[[ -z "$1" ]] && cmd="" || cmd="$1"

#running command
docker run \
    -it \
    --mount type=bind,source=$host_code_dir,target=/code \
    --mount type=bind,source=$host_data_dir,target=/data \
    -p 6006:6006 \
    --runtime=nvidia \
    $user/$img_name:$tag \
    $cmd
