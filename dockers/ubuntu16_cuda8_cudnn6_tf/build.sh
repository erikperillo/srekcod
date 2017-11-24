#!/bin/bash

set -ex

user="erikperillo"
img_name="$(cat NAME)"
tag="latest"

docker build -t $user/$img_name:$tag .
