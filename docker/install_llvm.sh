#!/bin/bash

# Based on https://github.com/pytorch/pytorch/blob/master/.circleci/docker/common/install_llvm.sh

set -ex

llvm_prefix=/usr/local/lib/llvm-${LLVM_VERSION}
llvm_source_url="https://github.com/llvm/llvm-project/archive/llvmorg-${LLVM_VERSION}.tar.gz"

mkdir $llvm_prefix

pushd /tmp
wget --no-verbose --output-document=llvm.tar.gz "$llvm_source_url"
mkdir llvm
tar zxf llvm.tar.gz -C llvm --strip-components 1
rm -f llvm.tar.gz

cd llvm
mkdir build
cd build
cmake -G "Unix Makefiles" \
  -DCMAKE_BUILD_TYPE=MinSizeRel \
  -DLLVM_ENABLE_ASSERTIONS=ON \
  -DLLVM_ENABLE_PROJECTS="clang;lldb" \
  -DCMAKE_INSTALL_PREFIX=$llvm_prefix \
  -DLLVM_TARGETS_TO_BUILD="host" \
  ../llvm

make -j4
sudo make install
rm -rf llvm

popd

ln -s ${llvm_prefix}/bin/* /usr/bin