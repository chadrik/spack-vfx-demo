#!/bin/bash
set -e

# install and register gcc-9.3.1
yum install -y centos-release-scl && yum install -y devtoolset-9
spack compiler find /opt/rh/devtoolset-9/root/usr/bin/

# register external packages
spack external find

# install and register ncurses external package
yum install -y ncurses-devel binutils-devel which 
echo -e "  ncurses:\n    externals:\n    - spec: ncurses@5.9.14+termlib\n      prefix: /usr" >> ~/.spack/packages.yaml

# build oiio
spack install openimageio +python ^openexr@3.1 ^python@3.9 ^py-numpy@1.20 ^boost@1.76

# build vfx reference platform

# install and register harfbuzz external package
yum install -y harfbuzz-devel
echo -e "  harfbuzz:\n    externals:\n    - spec: harfbuzz@1.7.5\n      prefix: /usr" >> ~/.spack/packages.yaml

. /opt/spack/share/spack/setup-env.sh

spack env create vfx2022
spack env activate -p vfx2022

spack add openimageio +python
spack add openexr@3.1
spack add python@3.9
spack add py-numpy@1.20
spack add boost@1.76
spack add qt@5.15
spack add intel-tbb@2020.3
spack add intel-mkl@2020
spack add opensubdiv@3.4
spack add alembic@1.8
spack add openvdb@8
spack add harfbuzz@1.7.5

# build
spack concretize
spack install
