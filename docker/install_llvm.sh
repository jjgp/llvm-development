#!/bin/bash

# Based on https://github.com/pytorch/pytorch/blob/master/.circleci/docker/common/install_llvm.sh

set -ex

llvm_prefix=/usr/lib/llvm-${LLVM_VERSION}
llvm_url="https://github.com/llvm/llvm-project/releases/download/llvmorg-${LLVM_VERSION}/llvm-${LLVM_VERSION}.src.tar.xz"

mkdir llvm_prefix

pushd /tmp
wget --no-verbose --output-document=llvm.tar.xz "$llvm_url"
mkdir llvm
tar -xf llvm.tar.xz -C llvm --strip-components 1
rm -f llvm.tar.xz

cd llvm
mkdir build
cd build
cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=MinSizeRel \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DCMAKE_INSTALL_PREFIX=$llvm_prefix \
  -DLLVM_TARGETS_TO_BUILD="host" \
  -DLLVM_BUILD_TOOLS=OFF \
  -DLLVM_BUILD_UTILS=OFF \
  -DLLVM_TEMPORARILY_ALLOW_OLD_TOOLCHAIN=ON \
  ../

make -j4
sudo make install

popd