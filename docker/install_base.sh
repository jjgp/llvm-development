#!/bin/bash

# Taken from https://github.com/pytorch/pytorch/blob/master/.circleci/docker/common/install_base.sh

set -ex

if [[ "$UBUNTU_VERSION" == "14.04" ]]; then
  # cmake 2 is too old
  cmake3=cmake3
else
  cmake3=cmake
fi

if [[ "$UBUNTU_VERSION" == "18.04" ]]; then
  cmake3=""
else
  cmake3="${cmake3}=3.5*"
fi

# Install common dependencies
apt-get update
apt-get install -y --no-install-recommends \
  cmake=3.10* \
  apt-transport-https \
  autoconf \
  automake \
  build-essential \
  ca-certificates \
  curl \
  git \
  libatlas-base-dev \
  libc6-dbg \
  libiomp-dev \
  libyaml-dev \
  libz-dev \
  libjpeg-dev \
  libasound2-dev \
  libsndfile-dev \
  python \
  python-dev \
  python-setuptools \
  python-wheel \
  software-properties-common \
  sudo \
  wget \
  vim

# Install Valgrind separately since the apt-get version is too old.
mkdir valgrind_build && cd valgrind_build
VALGRIND_VERSION=3.15.0
if ! wget http://valgrind.org/downloads/valgrind-${VALGRIND_VERSION}.tar.bz2
then
  wget https://sourceware.org/ftp/valgrind/valgrind-${VALGRIND_VERSION}.tar.bz2
fi
tar -xjf valgrind-${VALGRIND_VERSION}.tar.bz2
cd valgrind-${VALGRIND_VERSION}
./configure --prefix=/usr/local
make -j 4
sudo make install
cd ../../
rm -rf valgrind_build
alias valgrind="/usr/local/bin/valgrind"

# Cleanup package manager
apt-get autoclean && apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*