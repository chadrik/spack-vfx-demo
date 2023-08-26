#!/bin/bash

mkdir ./spack-builds
git clone https://github.com/chadrik/spack --branch vfx-demo
docker run -it --rm \
  -v $(pwd)/spack-builds:/opt/spack/opt/spack/ \
  -v $(pwd)/spack/lib:/opt/spack/lib \
  -v $(pwd)/spack/var/spack:/opt/spack/var/spack \
  -v $(pwd)/scripts/:/root/scripts \
  --entrypoint spack-env spack/centos7:v0.19.0 /root/scripts/demo-internal.sh
