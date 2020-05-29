#!/bin/bash

# Based on https://github.com/pytorch/pytorch/blob/master/.circleci/docker/common/install_llvm.sh

set -ex

buildDeps='libedit-dev libncurses5-dev python-dev swig wget'
apt-get update
apt-get install -y --no-install-recommends \
  $buildDeps \
  automake \
  build-essential \
  ca-certificates \
  cmake \
  gdb \
  python \
  valgrind && \
  rm -rf /var/lib/apt/lists/*

llvm_source_url="https://github.com/llvm/llvm-project/archive/llvmorg-${LLVM_VERSION}.tar.gz"

pushd /tmp

wget --no-verbose --output-document=llvm.tar.gz "$llvm_source_url"
mkdir llvm
tar zxf llvm.tar.gz -C llvm --strip-components 1
rm -f llvm.tar.gz

cd llvm
mkdir build
cd build
cmake -G "Unix Makefiles" \
  -DLLVM_ENABLE_PROJECTS="clang;lldb" \
  -DLLVM_TARGETS_TO_BUILD="host" \
  ../llvm

cmake --build . -- -j4
cmake --build . --target install

popd

rm -rf /tmp/llvm

apt-get --purge remove -y \
  $buildDeps